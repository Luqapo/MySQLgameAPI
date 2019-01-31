const User = require('../models').User;

module.exports = {
    async register(req, res) {
        console.log(req.body);
        try {
            const user = await User.create(req.body);
            return res.status(201).send(user);
        }catch (err) {
            console.log(err);
            return res.status(500).send({message: 'Error while crating user'});
        }

    },
    async getUsers(req, res) {
        try {
            const users = await User.findAll();
            res.status(200).send(users);
        } catch (err) {
            res.status(500).send({ message: 'Erron on the server'});
        }
    }
}