import express from 'express';
import pool from '../db.js';

const router = express.Router();

// GET /objets — liste tous les objets
router.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM objet ORDER BY id');
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ erreur: 'Erreur serveur' });
  }
});

// GET /objets/:id — récupère un seul objet
router.get('/:id', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM objet WHERE id = $1', [req.params.id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ erreur: 'Objet introuvable' });
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ erreur: 'Erreur serveur' });
  }
});

// POST /objets — crée un objet
router.post('/', async (req, res) => {
  const { libelle, poids_kg, etat_arrivee, categorie_id, depot_id } = req.body;

  if (!libelle || !poids_kg || !etat_arrivee || !categorie_id || !depot_id) {
    return res.status(400).json({
      erreur: 'libelle, poids_kg, etat_arrivee, categorie_id et depot_id sont requis',
    });
  }

  try {
    const result = await pool.query(
      `INSERT INTO objet (libelle, poids_kg, etat_arrivee, categorie_id, depot_id)
       VALUES ($1, $2, $3, $4, $5)
       RETURNING *`,
      [libelle, poids_kg, etat_arrivee, categorie_id, depot_id]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ erreur: 'Erreur serveur' });
  }
});

// PUT /objets/:id — modifie un objet existant
router.put('/:id', async (req, res) => {
  const { libelle, poids_kg, etat_arrivee, statut, prix, date_mise_rayon } = req.body;

  try {
    const result = await pool.query(
      `UPDATE objet
       SET libelle = $1, poids_kg = $2, etat_arrivee = $3,
           statut = $4, prix = $5, date_mise_rayon = $6
       WHERE id = $7
       RETURNING *`,
      [libelle, poids_kg, etat_arrivee, statut, prix, date_mise_rayon, req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ erreur: 'Objet introuvable' });
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ erreur: 'Erreur serveur' });
  }
});

// DELETE /objets/:id — supprime un objet
router.delete('/:id', async (req, res) => {
  try {
    const result = await pool.query('DELETE FROM objet WHERE id = $1 RETURNING *', [req.params.id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ erreur: 'Objet introuvable' });
    }
    res.status(204).send();
  } catch (err) {
    console.error(err);
    res.status(500).json({ erreur: 'Erreur serveur' });
  }
});

export default router;