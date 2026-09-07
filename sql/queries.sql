-- queries.sql — La Remise
-- Une requête par question de la section 04 du sujet.
-- Testé sur PostgreSQL 16 (dialecte différent de SQLite : pas de date('now',...),
-- pas de julianday(), pas de strftime() — on utilise CURRENT_DATE, INTERVAL et EXTRACT).

-- ============================================================
-- Q1 — Combien d'objets avons-nous reçus le mois dernier, et quel poids total ?
-- ============================================================
SELECT
    COUNT(*)      AS nb_objets_recus,
    SUM(o.poids)  AS poids_total_kg
FROM OBJET o
JOIN DEPOT d ON o.id_depot = d.id_depot
WHERE d.date >= date_trunc('month', CURRENT_DATE) - INTERVAL '1 month'
  AND d.date <  date_trunc('month', CURRENT_DATE);


-- ============================================================
-- Q2 — Quels objets sont actuellement en rayon, et depuis combien de temps ?
-- date_statut correspond à la date du dernier changement de statut (cf. décision D3).
-- En PostgreSQL, la soustraction de deux DATE renvoie directement un nombre de jours.
-- ============================================================
SELECT
    o.numero_etiquette,
    o.designation,
    o.date_statut,
    (CURRENT_DATE - o.date_statut) AS jours_en_rayon
FROM OBJET o
WHERE o.statut = 'en rayon'
ORDER BY jours_en_rayon DESC;


-- ============================================================
-- Q3 — Quelle catégorie se vend le mieux ? Laquelle rapporte le plus ?
-- Deux sous-questions distinctes : "se vend le mieux" = nombre de ventes,
-- "rapporte le plus" = somme des prix payés. Une seule requête, deux tris possibles.
-- ============================================================

-- 3a. Catégorie qui se vend le mieux (en nombre d'objets vendus)
SELECT
    o.categorie,
    COUNT(*)            AS nb_objets_vendus,
    SUM(o.prix_paye)    AS chiffre_affaires
FROM OBJET o
WHERE o.statut = 'vendu'
GROUP BY o.categorie
ORDER BY nb_objets_vendus DESC;

-- 3b. Catégorie qui rapporte le plus (en chiffre d'affaires)
SELECT
    o.categorie,
    COUNT(*)            AS nb_objets_vendus,
    SUM(o.prix_paye)    AS chiffre_affaires
FROM OBJET o
WHERE o.statut = 'vendu'
GROUP BY o.categorie
ORDER BY chiffre_affaires DESC;


-- ============================================================
-- Q4 — Combien d'heures de bénévolat ont été consacrées à la réparation cette année ?
-- ============================================================
SELECT
    SUM(r.duree_heures) AS total_heures_reparation
FROM REPARATION r
WHERE EXTRACT(YEAR FROM r.date) = EXTRACT(YEAR FROM CURRENT_DATE);


-- ============================================================
-- Q5 — Quel est le taux de réussite des réparations, par bénévole et globalement ?
-- ============================================================

-- 5a. Par bénévole
SELECT
    b.id_benevole,
    b.nom,
    COUNT(*) AS nb_reparations,
    SUM(CASE WHEN r.resultat = 'réussie' THEN 1 ELSE 0 END) AS nb_reussies,
    ROUND(
        100.0 * SUM(CASE WHEN r.resultat = 'réussie' THEN 1 ELSE 0 END) / COUNT(*),
        1
    ) AS taux_reussite_pct
FROM REPARATION r
JOIN BENEVOLE b ON r.id_benevole = b.id_benevole
GROUP BY b.id_benevole, b.nom
ORDER BY taux_reussite_pct DESC;

-- 5b. Globalement
SELECT
    ROUND(
        100.0 * SUM(CASE WHEN resultat = 'réussie' THEN 1 ELSE 0 END) / COUNT(*),
        1
    ) AS taux_reussite_global_pct
FROM REPARATION;


-- ============================================================
-- Q6 — Quelles personnes nous ont fait plus de trois dépôts ?
-- ============================================================
SELECT
    p.id_personne,
    p.nom,
    COUNT(d.id_depot) AS nb_depots
FROM PERSONNE p
JOIN DEPOT d ON d.id_personne = p.id_personne
GROUP BY p.id_personne, p.nom
HAVING COUNT(d.id_depot) > 3
ORDER BY nb_depots DESC;


-- ============================================================
-- Q7 — Quel poids total avons-nous détourné de la déchetterie
--      (tout ce qui n'est pas recyclé) ?
-- ============================================================
SELECT
    SUM(o.poids) AS poids_total_detourne_kg
FROM OBJET o
WHERE o.statut != 'recyclé';


-- ============================================================
-- Q8 — Quel est le taux de présence réelle sur nos ateliers ?
-- present = NULL tant que l'atelier n'a pas encore eu lieu (cf. dictionnaire),
-- donc on l'exclut du calcul. present est un BOOLEAN, pas un entier.
-- ============================================================
SELECT
    ROUND(
        100.0 * SUM(CASE WHEN present THEN 1 ELSE 0 END) / COUNT(*),
        1
    ) AS taux_presence_pct
FROM INSCRIPTION_ATELIER
WHERE present IS NOT NULL;


-- ============================================================
-- Q9 — Quels bénévoles ont la compétence « électricité » et sont disponibles
--      pour animer un atelier ?
-- Le sujet exclut explicitement la gestion des plannings de présence des
-- bénévoles (hors périmètre) : "disponible" est donc interprété ici comme
-- "a la compétence requise", sans vérification d'agenda.
-- ============================================================
SELECT
    b.id_benevole,
    b.nom,
    b.coordonnees
FROM BENEVOLE b
JOIN BENEVOLE_COMPETENCE bc ON bc.id_benevole = b.id_benevole
JOIN COMPETENCE c ON c.id_competence = bc.id_competence
WHERE c.libelle = 'électricité';


-- ============================================================
-- Q10 — Quels objets sont en rayon depuis plus de six mois et devraient être sortis ?
-- ============================================================
SELECT
    o.numero_etiquette,
    o.designation,
    o.date_statut
FROM OBJET o
WHERE o.statut = 'en rayon'
  AND o.date_statut <= (CURRENT_DATE - INTERVAL '6 months')::date
ORDER BY o.date_statut ASC;
