const scoreController = require('../controllers').score;
const userController = require('../controllers').user;

const auth = require('../utils/auth');

module.exports = (app) => {
    app.get('/api', (req, res) => {
        res.status(200).send({ message: 'Welcome to gameScore API'});
    });

    app.post('/api/score', auth, scoreController.create);

    app.get('/api/score', auth, scoreController.get);

    app.get('/api/score/summary', auth, scoreController.summary);

    app.get('/api/score/category', auth, scoreController.category);

    app.get('/api/score/delete/:scoreId', auth, scoreController.delete);

    app.get('/api/score/sort', auth, scoreController.sort);

    app.post('/api/auth/register', userController.register);

    app.get('/api/auth/user', userController.getUsers);
};