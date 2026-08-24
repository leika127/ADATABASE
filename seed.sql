-- Données de test cohérentes, générées pour couvrir les 10 requêtes de queries.sql.
-- Volumes : 10 personnes, 12 bénévoles, 6 compétences, 8 catégories, 40 objets,
-- 15 réparations, 10 ventes, 4 ateliers + inscriptions.

-- ============================================================
-- PERSONNE (10)
-- ============================================================
INSERT INTO PERSONNE (nom, telephone, est_adherent) VALUES
('Alexandre Traore', '0382321819', FALSE),
('Alexandria Martinez', '+33 (0)3 65 38 90 83', TRUE),
('Paulette Vasseur-Pons', '0140265423', TRUE),
('Caroline Morin', '02 37 55 94 07', TRUE),
('Chantal Hoareau-Chevalier', '0494931034', FALSE),
('Gabriel Roussel', '04 30 75 25 53', FALSE),
('Zacharie-Tristan Guérin', '+33 3 82 27 64 83', FALSE),
('Andrée Rolland', '+33 (0)4 70 64 13 95', TRUE),
('Victor du Delaunay', '02 76 42 38 84', TRUE),
('Pénélope-Noémi Étienne', '+33 2 62 87 10 12', TRUE);

-- ============================================================
-- BENEVOLE (12)
-- ============================================================
INSERT INTO BENEVOLE (nom, coordonnees, date_entree) VALUES
('Zacharie Briand', 'collinalex@example.net', '2026-05-21'),
('Jeannine de Bazin', 'normandelise@example.com', '2024-09-12'),
('Cécile Cousin', 'dbarbier@example.org', '2026-01-26'),
('Philippe-Emmanuel Guillou', 'toussainttheophile@example.net', '2022-10-06'),
('Denis Le Ledoux', 'elodiemerle@example.net', '2025-10-23'),
('Margot Camus de Marie', 'veronique43@example.org', '2020-10-14'),
('Audrey-Aurélie Foucher', 'wmuller@example.net', '2024-09-04'),
('Vincent Ollivier', 'remyevrard@example.net', '2022-02-19'),
('Richard de la Delannoy', 'andree57@example.net', '2022-05-07'),
('Frédéric Andre-Maillot', 'pruvostfrancoise@example.org', '2023-05-13'),
('Auguste Neveu', 'rollanddaniel@example.org', '2025-05-16'),
('Pierre Gomez', 'marguerite73@example.net', '2019-12-25');

-- ============================================================
-- COMPETENCE (6)
-- ============================================================
INSERT INTO COMPETENCE (libelle) VALUES
('couture'),
('électricité'),
('menuiserie'),
('informatique'),
('vente'),
('bricolage');

-- ============================================================
-- BENEVOLE_COMPETENCE
-- ============================================================
INSERT INTO BENEVOLE_COMPETENCE (id_benevole, id_competence) VALUES
(1, 2),
(2, 1),
(2, 2),
(2, 5),
(3, 4),
(3, 5),
(3, 6),
(4, 2),
(4, 4),
(5, 1),
(5, 2),
(5, 3),
(6, 3),
(6, 4),
(6, 5),
(7, 2),
(8, 1),
(8, 6),
(9, 1),
(9, 2),
(9, 3),
(10, 3),
(10, 5),
(11, 6),
(12, 1),
(12, 5);

-- ============================================================
-- DEPOT (22) — personnes 1 et 2 ont plus de 3 dépôts (Q6)
-- ============================================================
INSERT INTO DEPOT (id_personne, date, mode) VALUES
(2, '2026-07-29', 'domicile'),
(1, '2026-07-18', 'boutique'),
(4, '2026-07-15', 'boutique'),
(1, '2026-07-24', 'boutique'),
(10, '2026-05-08', 'domicile'),
(2, '2025-09-10', 'domicile'),
(7, '2025-08-04', 'domicile'),
(4, '2025-12-12', 'boutique'),
(1, '2025-12-09', 'boutique'),
(1, '2025-12-26', 'domicile'),
(1, '2026-04-07', 'boutique'),
(2, '2026-03-16', 'domicile'),
(5, '2026-07-15', 'domicile'),
(2, '2025-08-05', 'domicile'),
(10, '2025-12-01', 'boutique'),
(2, '2025-11-06', 'domicile'),
(9, '2026-05-29', 'boutique'),
(6, '2025-10-02', 'boutique'),
(2, '2025-09-09', 'domicile'),
(5, '2025-12-19', 'domicile'),
(1, '2025-12-09', 'domicile'),
(2, '2025-10-14', 'domicile');

-- ============================================================
-- VENTE (10)
-- ============================================================
INSERT INTO VENTE (date, mode_paiement, id_personne) VALUES
('2025-11-28', 'espèces', 3),
('2026-07-25', 'chèque', 8),
('2026-02-05', 'espèces', 1),
('2026-07-03', 'espèces', NULL),
('2026-03-15', 'espèces', 3),
('2025-09-18', 'chèque', 7),
('2026-08-21', 'chèque', 2),
('2026-06-24', 'carte', NULL),
('2026-08-10', 'carte', 10),
('2026-07-26', 'carte', 9);

-- ============================================================
-- ATELIER (4)
-- ============================================================
INSERT INTO ATELIER (titre, date, duree, nb_places, id_benevole) VALUES
('Répare ton vélo', '2026-06-23', 2.5, 8, 3),
('Initiation couture', '2026-08-02', 3.0, 10, 1),
('Retape un meuble', '2026-08-17', 4.0, 6, 5),
('Répare ton grille-pain', '2026-09-06', 2.0, 8, 4);

-- ============================================================
-- OBJET (40)
-- ============================================================
INSERT INTO OBJET (designation, categorie, etat_arrivee, poids, statut, date_statut, id_depot, id_vente, prix_paye) VALUES
('Saladier', 'vaisselle', 'bon état', 3.27, 'arrivé', '2026-08-04', 16, NULL, NULL),
('Encyclopédie', 'livres', 'hors service', 16.79, 'en rayon', '2026-07-10', 18, NULL, NULL),
('Draps', 'textile', 'hors service', 14.98, 'en rayon', '2026-04-05', 7, NULL, NULL),
('Verres à pied', 'vaisselle', 'à réparer', 34.83, 'vendu', '2025-11-30', 21, 6, 36.17),
('Lot divers', 'autre', 'bon état', 8.1, 'vendu', '2026-04-26', 11, 1, 47.89),
('Service à café', 'vaisselle', 'bon état', 24.86, 'recyclé', '2026-06-24', 2, NULL, NULL),
('Grille-pain', 'électroménager', 'à réparer', 2.76, 'en rayon', '2026-06-11', 8, NULL, NULL),
('Décoration murale', 'autre', 'hors service', 4.89, 'vendu', '2025-12-22', 19, 10, 38.87),
('Boîte à outils', 'bricolage', 'bon état', 3.66, 'en rayon', '2025-12-30', 14, NULL, NULL),
('Scie', 'bricolage', 'à réparer', 30.28, 'en rayon', '2026-07-27', 2, NULL, NULL),
('Étagère', 'mobilier', 'hors service', 12.07, 'vendu', '2025-11-20', 4, 4, 16.94),
('Décoration murale', 'autre', 'à réparer', 6.67, 'vendu', '2026-07-14', 15, 4, 70.21),
('Vélo adulte', 'autre', 'bon état', 2.06, 'en rayon', '2026-02-12', 18, NULL, NULL),
('Micro-ondes', 'électroménager', 'bon état', 14.4, 'arrivé', '2026-06-28', 16, NULL, NULL),
('Perceuse', 'bricolage', 'bon état', 13.45, 'en rayon', '2026-06-15', 13, NULL, NULL),
('Instrument de musique', 'autre', 'à réparer', 24.47, 'en rayon', '2026-04-19', 18, NULL, NULL),
('Encyclopédie', 'livres', 'à réparer', 7.85, 'arrivé', '2026-03-26', 2, NULL, NULL),
('Commode', 'mobilier', 'bon état', 2.04, 'en réparation', '2026-04-15', 16, NULL, NULL),
('Roman policier', 'livres', 'hors service', 3.08, 'vendu', '2026-04-23', 6, 2, 48.41),
('Perceuse', 'bricolage', 'hors service', 8.84, 'en réparation', '2026-08-11', 20, NULL, NULL),
('Mixeur', 'électroménager', 'hors service', 20.55, 'arrivé', '2026-06-02', 17, NULL, NULL),
('Rideaux', 'textile', 'hors service', 25.15, 'vendu', '2026-03-21', 8, 5, 32.87),
('Instrument de musique', 'autre', 'bon état', 0.62, 'vendu', '2026-07-15', 20, 10, 79.7),
('Saladier', 'vaisselle', 'à réparer', 4.9, 'recyclé', '2026-08-04', 12, NULL, NULL),
('Verres à pied', 'vaisselle', 'à réparer', 5.77, 'en réparation', '2026-02-22', 18, NULL, NULL),
('Draps', 'textile', 'hors service', 18.65, 'vendu', '2026-06-29', 22, 9, 25.35),
('BD', 'livres', 'bon état', 31.17, 'en rayon', '2026-07-13', 18, NULL, NULL),
('Nappe', 'textile', 'hors service', 7.61, 'recyclé', '2026-06-30', 11, NULL, NULL),
('Draps', 'textile', 'à réparer', 9.01, 'en rayon', '2026-02-02', 2, NULL, NULL),
('Établi', 'bricolage', 'bon état', 0.42, 'en réparation', '2026-03-11', 5, NULL, NULL),
('Rideaux', 'textile', 'hors service', 15.63, 'en rayon', '2026-03-31', 14, NULL, NULL),
('Chaise en bois', 'mobilier', 'bon état', 33.09, 'en rayon', '2026-04-04', 5, NULL, NULL),
('Commode', 'mobilier', 'hors service', 19.47, 'recyclé', '2026-07-20', 14, NULL, NULL),
('Commode', 'mobilier', 'à réparer', 31.49, 'en rayon', '2026-05-22', 2, NULL, NULL),
('Lot d''assiettes', 'vaisselle', 'hors service', 3.87, 'en rayon', '2026-05-09', 18, NULL, NULL),
('Encyclopédie', 'livres', 'bon état', 34.17, 'vendu', '2026-03-04', 6, 7, 3.93),
('Boîte à outils', 'bricolage', 'à réparer', 5.82, 'en réparation', '2026-05-16', 4, NULL, NULL),
('Étagère', 'mobilier', 'bon état', 7.23, 'arrivé', '2026-05-24', 15, NULL, NULL),
('Rideaux', 'textile', 'bon état', 1.12, 'recyclé', '2026-05-11', 7, NULL, NULL),
('Jeu de société', 'jouets', 'bon état', 33.85, 'en rayon', '2026-05-24', 9, NULL, NULL);

-- ============================================================
-- REPARATION (15)
-- ============================================================
INSERT INTO REPARATION (date, duree_heures, resultat, numero_etiquette, id_benevole) VALUES
('2026-07-17', 10.4, 'réussie', 18, 11),
('2026-02-08', 7.0, 'réussie', 20, 9),
('2026-04-24', 4.0, 'échouée', 25, 5),
('2026-02-19', 1.2, 'réussie', 30, 5),
('2026-04-04', 14.7, 'réussie', 37, 6),
('2026-01-14', 19.7, 'réussie', 4, 10),
('2026-03-30', 4.2, 'réussie', 5, 10),
('2026-08-18', 0.5, 'échouée', 8, 7),
('2026-03-03', 13.9, 'échouée', 11, 9),
('2026-07-02', 13.6, 'réussie', 12, 12),
('2026-04-17', 19.0, 'échouée', 6, 2),
('2026-04-09', 6.6, 'échouée', 24, 10),
('2025-11-18', 18.1, 'réussie', 28, 12),
('2025-11-28', 8.5, 'réussie', 33, 11),
('2025-07-31', 11.3, 'réussie', 39, 5);

-- ============================================================
-- INSCRIPTION_ATELIER
-- ============================================================
INSERT INTO INSCRIPTION_ATELIER (id_personne, id_atelier, date_inscription, present) VALUES
(3, 1, '2026-06-14', TRUE),
(5, 1, '2026-06-10', TRUE),
(7, 1, '2026-06-06', TRUE),
(9, 1, '2026-06-04', TRUE),
(1, 1, '2026-06-15', TRUE),
(10, 1, '2026-06-11', TRUE),
(8, 1, '2026-06-10', TRUE),
(4, 2, '2026-07-28', TRUE),
(5, 2, '2026-07-24', FALSE),
(10, 2, '2026-07-18', TRUE),
(7, 2, '2026-07-23', TRUE),
(2, 2, '2026-07-30', FALSE),
(6, 2, '2026-07-27', FALSE),
(1, 2, '2026-07-23', TRUE),
(8, 2, '2026-07-14', TRUE),
(3, 2, '2026-07-13', TRUE),
(9, 2, '2026-07-27', TRUE),
(9, 3, '2026-07-29', TRUE),
(10, 3, '2026-07-28', TRUE),
(6, 3, '2026-08-09', FALSE),
(7, 3, '2026-07-30', TRUE),
(4, 3, '2026-08-07', FALSE),
(9, 4, '2026-08-25', NULL),
(8, 4, '2026-08-27', NULL),
(4, 4, '2026-08-26', NULL),
(3, 4, '2026-08-24', NULL),
(10, 4, '2026-08-24', NULL),
(1, 4, '2026-08-17', NULL);
