import express from 'express';
import pool from '../db.js';

const router = express.Router();

// GET /personnes — liste tous les personnes
router.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM personnes ORDER BY id');
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ erreur: 'Erreur serveur' });
  }
});

// GET /personnes/:id — récupère une seule personne
router.get('/:id', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM personnes WHERE id = $1', [req.params.id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ erreur: 'Personne introuvable' });
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ erreur: 'Erreur serveur' });
  }
});

// POST /personnes — crée une personne
router.post('/', async (req, res) => {
  const { nom, prenom, age } = req.body;

  if (!nom || !prenom || !age) {
    return res.status(400).json({
      erreur: 'nom, prenom et age sont requis',
    });
  }

  try {
    const result = await pool.query(
      `INSERT INTO personnes (nom, prenom, age)
       VALUES ($1, $2, $3)
       RETURNING *`,
      [nom, prenom, age]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ erreur: 'Erreur serveur' });
  }
});

// PUT /personnes/:id — modifie une personne existante
router.put('/:id', async (req, res) => {
  const { nom, prenom, age } = req.body;

  try {
    const result = await pool.query(
      `UPDATE personnes
       SET nom = $1, prenom = $2, age = $3
       WHERE id = $4
       RETURNING *`,
      [nom, prenom, age, req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ erreur: 'Personne introuvable' });
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ erreur: 'Erreur serveur' });
  }
});

// DELETE /personnes/:id — supprime une personne
router.delete('/:id', async (req, res) => {
  try {
    const result = await pool.query('DELETE FROM personnes WHERE id = $1 RETURNING *', [req.params.id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ erreur: 'Personne introuvable' });
    }
    res.status(204).send();
  } catch (err) {
    console.error(err);
    res.status(500).json({ erreur: 'Erreur serveur' });
  }
});

export default router;
