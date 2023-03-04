const express = require('express');
const app = express();
const port = 3000;
require('dotenv').config();
const db = require('./dbConnect.js');

app.get('/', (req, res) => {
  console.log('Hello World!');
  db.promise().query('SELECT * from product WHERE productId = 1')
    .then(data => {
      console.log('returned data: \n', data);
    });
  res.send('Successful database query');
});

app.get('/products', (req, res) => {
  const page = req.query.page ? parseInt(req.query.page) : 1;
  const count = req.query.count ? (parseInt(req.query.count) - 1) : 4;
  db.promise().query(`SELECT * from product WHERE productId BETWEEN ${page} AND ${page + count}`)
    .then(data => {
      let returnData = [];
      for(var x = 0; x < data[0].length; x++) {
        returnData.push({
          id: data[0][x].productId,
          name: data[0][x].productName,
          slogan: data[0][x].Slogan,
          description: data[0][x].description,
          category: data[0][x].category,
          default_price: data[0][x].defaultPrice
        });
      }
      res.status(200).send(returnData);
    });
});

app.get('/loaderio-1ba8904285c44ff985f7c05ee462d40a.txt', (req, res) => {
  res.send('loaderio-1ba8904285c44ff985f7c05ee462d40a');
});

app.listen(port, () => {
  console.log(`listening on ${port}`);
})