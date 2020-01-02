const express = require('express');
const app = express();

const PORT = process.env.PORT || 8000;

app.use('/static', express.static('public'));

app.get('/', (req, res) => {
  res.send(`
    <h1>Docker and Node</h1>
    <span>A match made in the cloud</span>
  `);
});

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}...`);
});
