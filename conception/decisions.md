# Décisions de conception — La Remise

##  Les personnes qui donnent, achètent, s'inscrivent : je les regroupe dans une seule entité
J'ai décidé de créer une seule entité PERSONNE pour les donateurs, les acheteurs et
les gens qui s'inscrivent aux ateliers. Les bénévoles, eux, restent à part dans
BENEVOLE, sans lien direct avec PERSONNE. Aucune règle de gestion ne m'oblige à
relier les deux, et un bénévole a des infos en plus (compétences, date d'entrée,
ce qu'il anime ou répare) qu'une personne "normale" n'a pas. J'assume la limite :
si un bénévole donne aussi un objet, il aura deux fiches différentes, sans lien
entre elles. Je considère que c'est acceptable pour cette version.

##  Je colle strictement aux 5 statuts de RG6, je supprime "trié"
Malika parlait d'un statut "trié" pendant l'entretien, mais RG6 ne liste que :
arrivé, en réparation, en rayon, vendu, recyclé. Comme les règles de gestion font
foi, je ne garde pas "trié" comme statut à part — je considère que c'est une étape
de passage, pas un état qu'on a besoin de stocker.

##  "Sorti après 6 mois" n'est pas un statut, c'est un calcul
RG6 ne prévoit pas de statut "sorti". Du coup, pour répondre à la question 10
(objets en rayon depuis plus de 6 mois), je ne crée pas de statut en plus : je
compare simplement la date du jour à la date du dernier changement de statut.
J'ajoute donc un champ `date_statut` sur OBJET, que personne ne m'a demandé
explicitement, mais sans lui je ne peux pas répondre aux questions 2 et 10. Je
choisis de ne garder que la dernière date de changement, pas tout l'historique —
plus simple, et ça suffit pour ce qu'on me demande.

## Je fusionne la vente et l'objet plutôt que de créer une table à part
Un objet n'est vendu qu'une seule fois (RG9), donc la relation entre VENTE et
OBJET a une cardinalité 1,n / 0,1 : pas besoin d'une table de liaison. J'applique
la règle de passage classique et je mets `id_vente` et `prix_paye` directement
dans la table OBJET, en NULL tant que l'objet n'est pas vendu.

##  Je rends l'acheteur facultatif sur la vente
RG10 ne dit pas explicitement qu'on doit connaître l'acheteur, mais l'entretien
parle de gestes commerciaux pour les adhérents, donc j'imagine qu'on identifie le
client au moins parfois. Je garde le lien PERSONNE-VENTE, mais en facultatif (0,1)
côté vente, pour couvrir aussi les ventes en caisse où on ne sait pas qui achète.

##  La durée de réparation devient un nombre d'heures
RG8 dit clairement "une durée en heures". Je transforme donc ce que Malika disait
à l'oral ("une heure comme trois semaines") en une valeur numérique, plus facile
à additionner pour sortir le total d'heures de bénévolat demandé en fin
d'entretien.

##  J'ajoute une date d'inscription aux ateliers
RG13 demande une date d'inscription en plus de la présence, alors que l'entretien
n'en parlait pas du tout. Je l'ajoute sur la relation entre PERSONNE et ATELIER.

##  Je ferme six champs en listes de valeurs (ENUM)
Catégorie d'objet (les 7 valeurs citées par Malika), état à l'arrivée (RG5),
statut (RG6), mode de dépôt (RG1), mode de paiement (RG10), résultat de
réparation (RG8). Je les déclare en ENUM dès le début de mon script de migration,
pour être sûr qu'on ne puisse pas rentrer n'importe quoi dans ces champs.