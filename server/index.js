const express = require('express');
const app = express();
const port = 3000;
const db = require('/dbConnect.js');

app.get('/', (req, res) => {
  console.log('Hello World!');
  db.query('SELECT * from product')
    .then(data => {
      console.log('returned data: \n', data);
    });
  res.send('Successful database query');
});

app.listen(port, () => {
  console.log(`listening on ${port}`);
})