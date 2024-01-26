
// Express.js uygulaması
const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

// Basit bir GET yolu
app.get('/', (req, res) => {
  res.send('Merhaba Dünya!');
});

// Sunucuyu başlat
app.listen(port, () => {
  console.log(`Sunucu port ${port} üzerinde çalışıyor.`);
});

module.exports = app; // Testler için dışa aktar
