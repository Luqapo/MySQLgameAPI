const express = require('express');
const bodyParser = require('body-parser');

const models = require('./models');

const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

require('./routes')(app);
app.get('*', (req, res) => {
    res.status(200).send({ message: 'Welcome to the beginning of nothingness.'})
});

models.sequelize.sync()
    .then(() => {
        app.listen(5000, () => {
            console.log('Server listen at port 5000');
        });
    })
    .catch(err => console.log(err));

module.exports = app;