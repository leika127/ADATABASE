import express from 'express';
import pool from '../db.js';

const router = express.Router();

// GET /categories — liste toutes les catégories
router.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM categories ORDER BY id');
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ erreur: 'Erreur serveur' });
  }
});

// GET /categories/:id — récupère une seule catégorie
router.get('/:id', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM categories WHERE id = $1', [req.params.id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ erreur: 'Catégorie introuvable' });
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ erreur: 'Erreur serveur' });
  }
});

// POST /categories — crée une catégorie
router.post('/', async (req, res) => {
  const { libelle } = req.body;   // seul `libelle` est extrait

  if (!libelle) {
    return res.status(400).json({
      erreur: 'libelle est requis',
    });
  }

  try {
    const result = await pool.query(
      `INSERT INTO categories (libelle)
       VALUES ($1)
       RETURNING *`,
        [libelle]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ erreur: 'Erreur serveur' });
  }
});

// PUT /categories/:id — modifie une catégorie existante
router.put('/:id', async (req, res) => {
  const { libelle } = req.body;

  try {
    const result = await pool.query(
      `UPDATE categories
       SET libelle = $1
       WHERE id = $2
       RETURNING *`,
      [libelle, req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ erreur: 'Catégorie introuvable' });
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ erreur: 'Erreur serveur' });
  }
});

// DELETE /categories/:id — supprime une catégorie
router.delete('/:id', async (req, res) => {
  try {
    const result = await pool.query('DELETE FROM categories WHERE id = $1 RETURNING *', [req.params.id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ erreur: 'Catégorie introuvable' });
    }
    res.status(204).send();
  } catch (err) {
    console.error(err);
    res.status(500).json({ erreur: 'Erreur serveur' });
  }
});

export default router;