const scoreController = require('../controllers').score;
const userController = require('../controllers').user

module.exports = (app) => {
    app.get('/api', (req, res) => {
        res.status(200).send({ message: 'Welcome to gameScore API'});
    });

    app.post('/api/score', scoreController.create);

    app.get('/api/score', scoreController.get);

    app.get('/api/score/summary', scoreController.summary);

    app.get('/api/score/category', scoreController.category);

    app.get('/api/score/delete/:scoreId', scoreController.delete);

    app.post('/api/auth/register', userController.register);

    app.get('/api/auth/user', userController.getUsers);
};