// index.js

const express = require('express');
const swaggerUi = require('swagger-ui-express');
const swaggerDocument = require('./swagger.json');

const app = express();
app.use('/objets', require('./routes/objets'));
app.use(express.json());

app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));

app.listen(3000, () => {
  console.log('Serveur démarré sur http://localhost:3000');
  console.log('Doc Swagger sur http://localhost:3000/api-docs');
});