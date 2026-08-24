-- migration_up.sql — La Remise
-- PostgreSQL 16. Types ENUM en tête, puis CREATE TABLE dans l'ordre de
-- l'arbre de dépendances (racines d'abord).
 
-- ============================================================
-- Types ENUM (décision D8)
-- ============================================================
 
CREATE TYPE mode_depot AS ENUM ('boutique', 'domicile');                          -- RG1
CREATE TYPE etat_objet AS ENUM ('bon état', 'à réparer', 'hors service');         -- RG5
CREATE TYPE statut_objet AS ENUM ('arrivé', 'en réparation', 'en rayon', 'vendu', 'recyclé'); -- RG6
CREATE TYPE categorie_objet AS ENUM (
    'mobilier', 'électroménager', 'livres', 'vaisselle',
    'textile', 'jouets', 'bricolage'
);                                                                                  -- RG4
CREATE TYPE resultat_reparation AS ENUM ('réussie', 'échouée');                    -- RG8
CREATE TYPE mode_paiement AS ENUM ('espèces', 'carte', 'chèque');                  -- RG10
 
 
-- ============================================================
-- Tables racines (aucune clé étrangère) — règle R1
-- ============================================================
 
CREATE TABLE PERSONNE (
    id_personne     INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom             VARCHAR(100) NOT NULL,
    telephone       VARCHAR(20),
    est_adherent    BOOLEAN NOT NULL DEFAULT FALSE
);
 
CREATE TABLE BENEVOLE (
    id_benevole     INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom             VARCHAR(100) NOT NULL,
    coordonnees     VARCHAR(200),
    date_entree     DATE NOT NULL
);
 
CREATE TABLE COMPETENCE (
    id_competence   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    libelle         VARCHAR(50) NOT NULL UNIQUE
);
 
 
-- ============================================================
-- Tables dépendant de PERSONNE / BENEVOLE — règles R1 + R2
-- ============================================================
 
CREATE TABLE DEPOT (
    id_depot        INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date            DATE NOT NULL,
    mode            mode_depot NOT NULL,
    id_personne     INTEGER NOT NULL REFERENCES PERSONNE(id_personne)  -- RG1, R2
);
 
CREATE TABLE VENTE (
    id_vente        INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date            DATE NOT NULL,
    mode_paiement   mode_paiement NOT NULL,
    id_personne     INTEGER REFERENCES PERSONNE(id_personne)           -- D5 : facultatif (0,1)
);
 
CREATE TABLE ATELIER (
    id_atelier      INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    titre           VARCHAR(100) NOT NULL,
    date            DATE NOT NULL,
    duree           NUMERIC(4,1) NOT NULL,
    nb_places       INTEGER NOT NULL CHECK (nb_places > 0),
    id_benevole     INTEGER NOT NULL REFERENCES BENEVOLE(id_benevole)  -- RG12, R2
);
 
 
-- ============================================================
-- OBJET — dépend de DEPOT et, éventuellement, de VENTE
-- ============================================================
 
CREATE TABLE OBJET (
    numero_etiquette   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    designation        VARCHAR(150) NOT NULL,
    categorie          categorie_objet NOT NULL,                       -- RG4
    etat_arrivee       etat_objet NOT NULL,                            -- RG5
    poids              NUMERIC(6,2) NOT NULL CHECK (poids > 0),
    statut             statut_objet NOT NULL DEFAULT 'arrivé',         -- RG6
    date_statut        DATE NOT NULL DEFAULT CURRENT_DATE,             -- D3
    id_depot           INTEGER NOT NULL REFERENCES DEPOT(id_depot),    -- RG3, R2
    id_vente           INTEGER REFERENCES VENTE(id_vente),             -- RG9, D4 : nullable
    prix_paye          NUMERIC(8,2)                                    -- RG10, D4 : nullable
);
 
 
-- ============================================================
-- REPARATION — dépend de OBJET et BENEVOLE
-- ============================================================
 
CREATE TABLE REPARATION (
    id_reparation      INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date               DATE NOT NULL,
    duree_heures       NUMERIC(5,1) NOT NULL CHECK (duree_heures > 0),  -- RG8, D6
    resultat           resultat_reparation NOT NULL,                    -- RG8
    numero_etiquette   INTEGER NOT NULL REFERENCES OBJET(numero_etiquette), -- RG7/RG8, R2
    id_benevole        INTEGER NOT NULL REFERENCES BENEVOLE(id_benevole)     -- RG8, R2
);
 
 
-- ============================================================
-- Tables d'association (relations n,n) — règle R3
-- ============================================================
 
CREATE TABLE BENEVOLE_COMPETENCE (
    id_benevole     INTEGER NOT NULL REFERENCES BENEVOLE(id_benevole),
    id_competence   INTEGER NOT NULL REFERENCES COMPETENCE(id_competence),
    PRIMARY KEY (id_benevole, id_competence)                            -- RG11
);
 
CREATE TABLE INSCRIPTION_ATELIER (
    id_personne         INTEGER NOT NULL REFERENCES PERSONNE(id_personne),
    id_atelier          INTEGER NOT NULL REFERENCES ATELIER(id_atelier),
    date_inscription    DATE NOT NULL,
    present             BOOLEAN,                                        -- NULL = pas encore eu lieu
    PRIMARY KEY (id_personne, id_atelier)                                -- RG13, RG14
);
 