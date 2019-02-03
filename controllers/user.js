const User = require('../models').User;

module.exports = {
    async register(req, res, next) {
        console.log(req.body);
        try {
            const user = await User.create(req.body);
            return res.status(201).send(user);
        }catch (err) {
            console.log(err);
            next(err);
        }

    },
    async getUsers(req, res, next) {
        try {
            const users = await User.findAll();
            res.status(200).send(users);
        } catch (err) {
            next(err);
        }
    }
}