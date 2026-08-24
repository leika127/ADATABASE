# Schéma relationnel — La Remise

Je pars de mon Modèle Conceptuel de Données et j'applique les trois règles de passage classiques :

- **R1** : chaque entité devient une table, son identifiant devient clé primaire.
- **R2** : pour une association dont un côté a une cardinalité max = 1 (1,1 ou
  0,1), l'association disparaît : la clé de l'entité "1" migre comme clé
  étrangère dans la table côté "n", et les attributs portés par l'association
  migrent avec elle.
- **R3** : pour une association n,n (les deux côtés en cardinalité max = n),
  l'association devient sa propre table, avec pour clé primaire la
  concaténation des deux clés étrangères, plus ses attributs éventuels.

---

## Mes tables

### PERSONNE(**id_personne**, nom, telephone, est_adherent)
Produite par **R1**. Simple entité, aucune association ne vient s'y ajouter
comme clé étrangère (c'est plutôt elle qui migre chez les autres).

### BENEVOLE(**id_benevole**, nom, coordonnees, date_entree)
Produite par **R1**, même logique que PERSONNE.

### COMPETENCE(**id_competence**, libelle)
Produite par **R1**.

### DEPOT(**id_depot**, date, mode, #id_personne)
Produite par **R1** (l'entité DEPOT) puis complétée par **R2** : dans
EFFECTUER, PERSONNE est côté (0,n) et DEPOT côté (1,1) — c'est donc DEPOT qui
récupère la clé de PERSONNE.

### ATELIER(**id_atelier**, titre, date, duree, nb_places, #id_benevole)
Produite par **R1** puis **R2** : dans ANIMER, BENEVOLE est côté (0,n) et
ATELIER côté (1,1) — même principe, la clé de BENEVOLE migre dans ATELIER.

### VENTE(**id_vente**, date, mode_paiement, #id_personne)
Produite par **R1** puis **R2** : dans ACHETER, PERSONNE est côté (0,n) et
VENTE côté (0,1) — la clé de PERSONNE migre dans VENTE. Je laisse
`id_personne` en NULL autorisé, parce que le côté (0,1) de VENTE veut dire
qu'une vente n'a pas forcément d'acheteur identifié (D5).

### OBJET(**numero_etiquette**, designation, categorie, etat_arrivee, poids, statut, date_statut, #id_depot, #id_vente, prix_paye)
Produite par **R1**, puis complétée par **deux R2 différentes** :
- CONCERNER (DEPOT 1,n / OBJET 1,1) → la clé de DEPOT migre dans OBJET.
- CONTENIR (VENTE 1,n / OBJET 0,1) → la clé de VENTE migre dans OBJET, avec
  l'attribut `prix_paye` porté par l'association, qui migre avec elle (D4).
  `id_vente` et `prix_paye` restent NULL tant que l'objet n'est pas vendu.

### REPARATION(**id_reparation**, date, duree_heures, resultat, #numero_etiquette, #id_benevole)
Produite par **R1**, puis deux **R2** :
- SUBIR (OBJET 0,n / REPARATION 1,1) → la clé d'OBJET migre dans REPARATION.
- REALISER (BENEVOLE 0,n / REPARATION 1,1) → la clé de BENEVOLE migre aussi
  dans REPARATION.

### BENEVOLE_COMPETENCE(**#id_benevole**, **#id_competence**)
Produite par **R3** : POSSEDER est en (0,n)/(0,n) des deux côtés, donc je
crée une table à part, avec les deux clés étrangères comme clé primaire
composée. Pas d'attribut supplémentaire à porter ici.

### INSCRIPTION_ATELIER(**#id_personne**, **#id_atelier**, date_inscription, present)
Produite par **R3** : INSCRIRE est aussi (0,n)/(0,n), donc table à part avec
clé composée. Je rajoute les deux attributs portés par l'association
(`date_inscription`, `present`) directement dans cette table.