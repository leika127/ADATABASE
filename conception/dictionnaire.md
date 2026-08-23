# dictonnaire

| Nom | Type | Description | Contraintes / Remarques |
|---|---|---|---|---|
| id_personne | Texte | Numéro unique de la personne | Nécessaire pour savoir si elle revient plusieurs fois dans l'année |
| nom_personne | Texte | Nom de la personne | |
| telephone_personne | Nombre | Numéro de téléphone | |
| personne_adherent | Booléen | Adhérent ou non | Impacte le prix payé en boutique |
| id_depot | Texte | Numéro du dépôt | |
| date-depot | Date | Date du dépôt | |
| mode-depot | énum | "dépôt en boutique" ou "collecte à domicile" | |
| id_deposant | Texte | Personne à l'origine du dépôt | Renvoie à PERSONNE |
| numero_etiquette | Nombre | Numéro unique de l'objet | Étiquette physique |
| designation_objet | Texte | Description de l'objet | |
| categorie_objet | Texte | mobilier / électroménager / livres / vaisselle / textile / jouets / bricolage | |
| etat_arrivee | énum | bon état / à réparer / hors service | |
| poids_objet | Nombre | Poids pesé individuellement en kg | Donnée demandée par la mairie |
| statut_parcours | énum | arrivé / en réparation / en rayon / vendu / sorti | Doit être connu à tout moment ; "sorti" si non vendu après 6 mois |
| objet_depot | énum | Dépôt d'origine | Renvoie à DEPOT |
| id_reparation | Nombre | Numéro de la réparation | |
| id_objet | Texte | Objet concerné | Renvoie à OBJET |
| id_benevole | Texte | Bénévole qui répare | Renvoie à BENEVOLE |
| date_reparation | Date | Date de début | |
| duree_reparation | Date | Temps passé (1h à plusieurs semaines) | Sert au bilan (ex. "340 heures de bénévolat") |
| resultat_reparation | énum | réussie / échouée | Si échouée, l'objet part quand même au recyclage |
| id_passage | Nombre | Numéro du passage en caisse | Un passage = une transaction |
| date_vente | Date | Date de la vente | |
| id_acheteur | Texte | Acheteur | Renvoie à PERSONNE |
| mode_paiement | Texte | Mode de paiement | |
| id_vente | Texte | Passage en caisse concerné | Renvoie à VENTE |
| id_vendu | Texte | Objet vendu | Renvoie à OBJET |
| prix_paye | Nombre | Prix réellement payé | Peut différer du prix affiché (gestes commerciaux, adhérents) |
| id_benevole | Nombre | Numéro du bénévole | |
| nom_benevole | Texte | Nom | |
| coordonnees_benevole | Texte | Coordonnées de contact | |
| entree_benevole | Date | Date d'entrée dans l'association | |
| id_competence | Nombre | Numéro de compétence | |
| libelle_competences | Texte | couture / électricité / menuiserie / informatique / vente / … | |
| competences_benevole | texte | Bénévole concerné | Table d'association (un bénévole peut avoir plusieurs compétences) |
| association_competence | Texte | Compétence associée | Renvoie à COMPETENCE |
| id_atelier | Nombre | Numéro de l'atelier | |
| titre_atelier | Texte | Ex. "répare ton vélo", "initiation couture" | |
| date_seance | Date | Date de la séance | Un même titre peut revenir à une autre date → nouvelle ligne |
| temps_atelier | Durée | Durée de l'atelier | |
| nb_places | Nombre | Nombre de places disponibles | |
| atelier_benevole | Texte | Bénévole animateur | Renvoie à BENEVOLE |
| inscription_atelier | Texte | Atelier concerné | Renvoie à ATELIER |
| personne_atelier | Texte | Personne inscrite | Renvoie à PERSONNE |
| presence_atelier | Booléen | Présence effective ou désistement | Nombreux désistements signalés par Malika |