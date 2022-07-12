import express from 'express';
import cors from 'cors';
import router from './routes/routes.js';

const app = express();
app.use(cors());

app.listen(4000, () => {
    console.log('Server is running on port 4000');
});

app.use('/api', router)