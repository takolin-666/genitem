# =====================================================
# ANALYSE AI-GENIE - MULTI-CONSTRUITS
# =====================================================
#
# Variante de analyse_genie.R pour un pool d'items couvrant PLUSIEURS
# construits (2 a 10), assignes via l'outil HTML "assignation_facteurs.html".
# Contrairement a analyse_genie.R (un seul construit, NMI toujours a 0),
# ce script compare la structure detectee par le reseau a tes construits
# theoriques, le NMI devient donc informatif.
#
# MODE D'EMPLOI :
# 1. Ce script vit dans le dossier R\ (a cote de l'installation R
#    elle-meme), PAS dans le dossier projet\ : il va chercher
#    AI-GENIE_construits.csv tout seul dans le dossier projet\ voisin.
# 2. Structure attendue sur le disque (peu importe la lettre) :
#      <disque>\R\analyse_genie_multi_construits.R   <- ce fichier, ici
#      <disque>\projet\AI-GENIE_construits.csv       <- export de assignation_facteurs.html
# 3. Lance ce script (voir commande PowerShell dans le configurateur HTML).
# 4. Les fichiers exportes apparaissent dans projet\, avec un
#    horodatage (Excel + 2 graphiques PNG).

# =====================================================
# ETAPE 1 : reperer les dossiers automatiquement
# =====================================================
# Sans jamais ecrire de lettre de disque : tout part de l'emplacement du script.
trouver_dossier_script <- function() {
  # commandArgs(trailingOnly = FALSE) renvoie tous les arguments de lancement de R,
  # dont "--file=chemin/du/script.R" quand on utilise Rscript.
  args <- commandArgs(trailingOnly = FALSE)
  arg_fichier <- args[grep("^--file=", args)]
  if (length(arg_fichier) > 0) {
    # Retire "--file=", normalise le chemin, puis garde le dossier qui contient le script.
    return(dirname(normalizePath(sub("^--file=", "", arg_fichier))))
  }
  getwd()  # secours si lance autrement qu'avec Rscript
}

DOSSIER_SCRIPT <- trouver_dossier_script()            # ex: O:/R
DOSSIER_RACINE <- dirname(DOSSIER_SCRIPT)             # remonte d'un niveau -> ex: O:/
DOSSIER_PROJET <- file.path(DOSSIER_RACINE, "projet") # ex: O:/projet

# --- A MODIFIER SI BESOIN -----------------------------------------
# Fichier d'entree : le CSV exporte par assignation_facteurs.html.
FICHIER_ITEMS <- file.path(DOSSIER_PROJET, "AI-GENIE_construits.csv")
# --------------------------------------------------------------------


# =====================================================
# ETAPE 2 : charger les packages
# =====================================================
# suppressPackageStartupMessages evite le bruit dans la console.
suppressPackageStartupMessages({
  library(AIGENIE)   # l'analyse AI-GENIE elle-meme
  library(ggplot2)   # sauvegarde des graphiques (ggsave)
  # repos explicite : une installation R portable n'a pas de depot configure,
  # et install.packages() echoue alors ("trying to use CRAN without setting a mirror").
  # writexl (export Excel) est installe seulement s'il manque.
  if (!requireNamespace("writexl", quietly = TRUE)) {
    install.packages("writexl", repos = "https://cloud.r-project.org")
  }
  library(writexl)
})

# =====================================================
# ETAPE 3 : verifier (et reparer) l'environnement Python d'AI-GENIE
# =====================================================
# L'environnement Python d'AI-GENIE garde en memoire, dans son fichier
# pyvenv.cfg, la lettre de disque utilisee au moment de sa creation. Si le
# disque a change de lettre depuis (ex: hier en O:, aujourd'hui en G:),
# l'environnement doit etre recree. Ce bloc le detecte et le fait tout
# seul, sans intervention manuelle.
# La fonction renvoie TRUE si tout est en ordre, FALSE s'il faut reconstruire.
verifier_environnement_aigenie <- function() {
  # Emplacement attendu du fichier de configuration de l'environnement.
  chemin_cfg <- file.path(Sys.getenv("APPDATA"), "R", "data", "R", "AIGENIE",
                           "aigenie_python_env", "pyvenv.cfg")

  # Fichier absent : premiere installation.
  if (!file.exists(chemin_cfg)) {
    cat("Environnement Python d'AI-GENIE absent, premiere installation...\n")
    return(FALSE)
  }

  # Lit le fichier et repere la ligne qui commence par "home".
  cfg <- readLines(chemin_cfg, warn = FALSE)
  ligne_home <- cfg[grepl("^home", cfg)]

  # [1] : un pyvenv.cfg comportant deux lignes "home" ferait planter le if
  # ("length = 2 in coercion to logical(1)" sous R >= 4.2).
  if (length(ligne_home) == 0) {
    cat("Fichier pyvenv.cfg illisible, reconstruction de l'environnement Python...\n")
    return(FALSE)
  }
  # Chemin enregistre dans "home = ...", sans espaces.
  chemin_enregistre <- trimws(sub("^home\\s*=\\s*", "", ligne_home[1]))

  # Comparaison du dossier complet, et non de la seule lettre de disque : si
  # subst reattribue la meme lettre a un autre dossier, l'environnement est
  # invalide alors que la lettre, elle, n'a pas change.
  dossier_attendu <- file.path(Sys.getenv("APPDATA"), "R", "data", "R", "AIGENIE",
                               "aigenie_python_env")
  # Uniformise les chemins (minuscules, "/" partout, sans "/" final) pour pouvoir les comparer.
  normaliser <- function(p) tolower(gsub("\\\\", "/", sub("/+$", "", p)))
  racine_enregistree <- normaliser(dirname(dirname(chemin_enregistre)))
  racine_attendue <- normaliser(dirname(dossier_attendu))

  # Reconstruction si le chemin enregistre n'existe plus ou pointe ailleurs.
  if (!file.exists(chemin_enregistre) || racine_enregistree != racine_attendue) {
    cat("L'emplacement du disque a change (", chemin_enregistre, " n'est plus valide)",
        ", reconstruction de l'environnement Python...\n", sep = "")
    return(FALSE)
  }

  cat("Environnement Python d'AI-GENIE deja a jour pour cet emplacement.\n")
  TRUE
}

# Si l'environnement est invalide, on le recree de force.
if (!verifier_environnement_aigenie()) {
  ensure_aigenie_python(force_reinstall = TRUE)
}

# =====================================================
# ETAPE 4 : lire et controler les items
# =====================================================
# Lecture des items (CSV multi-construits, colonnes ID/statement/attribute/type).
if (!file.exists(FICHIER_ITEMS)) {
  stop("Fichier introuvable : ", FICHIER_ITEMS,
       "\nGenere-le d'abord avec assignation_facteurs.html, puis depose-le dans \\projet\\.")
}

# fileEncoding = "UTF-8-BOM" (et non encoding = "UTF-8") : le CSV exporte par
# assignation_facteurs.html commence par un BOM. Sans cette option, R nomme la
# premiere colonne "X.U.FEFF.ID" et le controle des colonnes echoue a tort.
items_df <- read.csv(FICHIER_ITEMS, fileEncoding = "UTF-8-BOM", stringsAsFactors = FALSE)

# Controle de la structure : les 4 colonnes attendues doivent toutes etre presentes.
colonnes_attendues <- c("ID", "statement", "attribute", "type")
colonnes_manquantes <- setdiff(colonnes_attendues, names(items_df))
if (length(colonnes_manquantes) > 0) {
  stop("Colonne(s) manquante(s) dans ", FICHIER_ITEMS, " : ",
       paste(colonnes_manquantes, collapse = ", "),
       "\nCe fichier doit venir de assignation_facteurs.html, sans modification de structure.")
}

# Compte les items et les construits distincts (colonne "type").
nb_construits <- length(unique(items_df$type))
cat("Nombre d'items charges :", nrow(items_df), "\n")
cat("Nombre de construits distincts :", nb_construits, "\n")
# Avertissements (sans arreter le script) si la situation est douteuse.
if (nb_construits < 2) {
  cat("ATTENTION : un seul construit detecte, le NMI sera a 0 (rien a comparer).",
      "Utilise plutot analyse_genie.R pour ce cas, ou verifie ton export CSV.\n")
}
if (nrow(items_df) < 10) {
  cat("ATTENTION : moins de 10 items, l'analyse de reseau risque de ne pas",
      "aboutir ou d'etre peu interpretable. Recommande : 15-20+ items.\n")
}

# =====================================================
# ETAPE 5 : analyse AI-GENIE (embeddings + EGA + UVA + bootEGA)
# =====================================================
# all.together = TRUE : tous les items passent dans UNE seule analyse de
# reseau, et le NMI compare les communautes detectees a tes construits
# theoriques (colonne "type"). C'est ce qui rend le NMI informatif ici,
# contrairement a une analyse par construit separe (NMI toujours nul).
# Les items sont transformes en vecteurs (embeddings) par le modele bert-base-uncased.
resultats <- local_GENIE(
  items = items_df,
  embedding.model = "bert-base-uncased",
  plot = TRUE,
  all.together = TRUE
)

# =====================================================
# ETAPE 6 : preparer l'export
# =====================================================
# Horodatage dans le nom des fichiers : un nouveau lancement n'ecrase jamais un ancien.
horodatage <- format(Sys.time(), "%Y%m%d_%H%M%S")
# Les fichiers sont ecrits dans le meme dossier que le CSV d'entree (projet\).
dossier_sortie <- dirname(FICHIER_ITEMS)

# Avec all.together = TRUE, le resultat n'est plus imbrique par construit
# (pas de $item_type_level) : tout est directement au premier niveau.
resultat_construit <- resultats

# Items non retenus = ceux du pool initial dont l'ID n'apparait plus
# dans la liste finale retenue par AI-GENIE (retires par l'UVA ou la
# reduction du reseau).
ids_retenus <- resultat_construit$final_items$ID
items_non_retenus <- items_df[!(items_df$ID %in% ids_retenus), ]

# Resume avec les indicateurs NMI (Normalized Mutual Information), le modele
# de reseau retenu, et les compteurs UVA/bootEGA.
# Tout est converti en texte (as.character) pour tenir dans une seule colonne "Valeur".
resume_nmi <- data.frame(
  Indicateur = c(
    "Nombre de construits theoriques",
    "NMI initial (avant reduction)",
    "NMI final (apres reduction)",
    "Modele de reseau retenu (EGA)",
    "Items retires par redondance (UVA)",
    "Passes de nettoyage UVA (sweeps)",
    "Items retires pour instabilite (bootEGA)"
  ),
  Valeur = c(
    as.character(nb_construits),
    as.character(resultat_construit$initial_NMI),
    as.character(resultat_construit$final_NMI),
    as.character(resultat_construit$EGA.model_selected),
    as.character(resultat_construit$UVA$n_removed),
    as.character(resultat_construit$UVA$n_sweeps),
    as.character(resultat_construit$bootEGA$n_removed)
  )
)

# Paires d'items juges redondants par l'UVA (avant reduction du reseau).
# Exportee telle quelle : la structure exacte de ce tableau depend de la
# version d'AIGENIE, donc on ne suppose aucun nom de colonne precis.
paires_redondantes <- resultat_construit$UVA$redundant_pairs
# Si le tableau est vide ou absent, on met une ligne d'information a la place
# (un onglet Excel vide serait deroutant).
if (is.null(paires_redondantes) || (is.data.frame(paires_redondantes) && nrow(paires_redondantes) == 0)) {
  paires_redondantes <- data.frame(Info = "Aucune paire redondante detectee par l'UVA.")
}

# Items retires specifiquement pour instabilite (bootEGA), distincts de ceux
# retires par redondance (UVA). Meme principe : export brut, sans supposer
# la structure exacte.
items_instables <- resultat_construit$bootEGA$items_removed
if (is.null(items_instables) || length(items_instables) == 0) {
  items_instables <- data.frame(Info = "Aucun item retire pour instabilite par bootEGA.")
} else if (!is.data.frame(items_instables)) {
  # Si c'est un simple vecteur, on le transforme en tableau pour l'export.
  items_instables <- data.frame(ID_ou_item = items_instables)
}

# =====================================================
# ETAPE 7 : ecrire le fichier Excel et les graphiques
# =====================================================
# Un classeur Excel avec 5 onglets (chaque element de la liste = un onglet).
write_xlsx(
  list(
    "Résumé" = resume_nmi,
    "Items retenus" = resultat_construit$final_items,
    "Items non retenus" = items_non_retenus,
    "Paires redondantes (UVA)" = paires_redondantes,
    "Items instables (bootEGA)" = items_instables
  ),
  file.path(dossier_sortie, paste0("resultats_multi_", horodatage, ".xlsx"))
)

# Graphique du reseau (les items et leurs communautes), en PNG 12 x 7 pouces, 150 dpi.
ggsave(
  file.path(dossier_sortie, paste0("network_plot_multi_", horodatage, ".png")),
  plot = resultat_construit$network_plot,
  width = 12, height = 7, dpi = 150
)

# Graphique de stabilite (bootEGA), meme format.
ggsave(
  file.path(dossier_sortie, paste0("stability_plot_multi_", horodatage, ".png")),
  plot = resultat_construit$stability_plot,
  width = 12, height = 7, dpi = 150
)

# =====================================================
# ETAPE 8 : bilan dans la console
# =====================================================
cat("\n=== TERMINE ===\n")
cat("Construits theoriques :", nb_construits, "\n")
cat("NMI initial :", resultat_construit$initial_NMI, "\n")
cat("NMI final   :", resultat_construit$final_NMI, "\n")
cat("Modele de reseau retenu :", resultat_construit$EGA.model_selected, "\n")
cat("Items retires par redondance (UVA) :", resultat_construit$UVA$n_removed, "\n")
cat("Items retires pour instabilite (bootEGA) :", resultat_construit$bootEGA$n_removed, "\n")
cat("Items retenus :", nrow(resultat_construit$final_items), "sur", nrow(items_df), "\n")
cat("Items non retenus :", nrow(items_non_retenus), "(inclus dans l'Excel, 2e feuille)\n")
cat("Fichiers exportes dans :", dossier_sortie, "\n")
cat("  - resultats_multi_", horodatage, ".xlsx\n", sep = "")
cat("  - network_plot_multi_", horodatage, ".png\n", sep = "")
cat("  - stability_plot_multi_", horodatage, ".png\n", sep = "")
