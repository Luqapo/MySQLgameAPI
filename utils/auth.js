const User = require('../models').User;

module.exports = async (req, res, next) => {
    const authHeader = req.get('Authorization');
    if(!authHeader) {
        return res.status(401).send({ message: 'Atuhorization fail, no header' });
    }
    const token = authHeader.split(' ')[1];
    if(!token) {
        return res.status(401).send({ message: 'Atuhorization fail, no token' });
    }
    try {
        const user = await User.findOne({ where: { name: token }});
        if(!user){
            return res.status(404).send({ message: 'User not found'});
        }
        req.userId = user.id;
        req.isAuth = true;
        console.log('User auth success');
        next();
    } catch (err) {
        console.log(err);
        res.status(500).send({ message: 'Error on the server while authorization!'});
    }
}