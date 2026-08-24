-- migration_down.sql — La Remise
-- Inverse exact de migration_up.sql : les tables dans l'ordre inverse de
-- l'arbre de dépendances (feuilles d'abord), puis les types ENUM.
-- IF EXISTS partout pour que le script soit rejouable sans erreur.

-- ============================================================
-- Tables d'association (dernières créées, donc premières supprimées)
-- ============================================================

DROP TABLE IF EXISTS INSCRIPTION_ATELIER;
DROP TABLE IF EXISTS BENEVOLE_COMPETENCE;

-- ============================================================
-- Table dépendant de OBJET et BENEVOLE
-- ============================================================

DROP TABLE IF EXISTS REPARATION;

-- ============================================================
-- Table dépendant de DEPOT et VENTE
-- ============================================================

DROP TABLE IF EXISTS OBJET;

-- ============================================================
-- Tables dépendant de PERSONNE / BENEVOLE
-- ============================================================

DROP TABLE IF EXISTS ATELIER;
DROP TABLE IF EXISTS VENTE;
DROP TABLE IF EXISTS DEPOT;

-- ============================================================
-- Tables racines
-- ============================================================

DROP TABLE IF EXISTS COMPETENCE;
DROP TABLE IF EXISTS BENEVOLE;
DROP TABLE IF EXISTS PERSONNE;

-- ============================================================
-- Types ENUM (en dernier, car les tables en dépendent)
-- ============================================================

DROP TYPE IF EXISTS mode_paiement;
DROP TYPE IF EXISTS resultat_reparation;
DROP TYPE IF EXISTS categorie_objet;
DROP TYPE IF EXISTS statut_objet;
DROP TYPE IF EXISTS etat_objet;
DROP TYPE IF EXISTS mode_depot;