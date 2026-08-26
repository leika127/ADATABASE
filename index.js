import express from 'express';
import swaggerUi from 'swagger-ui-express';
import { readFileSync } from 'fs';

const swaggerDocument = JSON.parse(readFileSync('./swagger.json', 'utf8'));

const app = express();
app.use(express.json());

app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));

app.listen(3000, () => {
  console.log('Serveur démarré sur http://localhost:3000');
  console.log('Doc Swagger sur http://localhost:3000/api-docs');
});