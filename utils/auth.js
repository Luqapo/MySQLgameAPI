const User = require('../models').User;

module.exports = async (req, res, next) => {
    try {
        const authHeader = req.get('Authorization');
        if(!authHeader) {
            const error = new Error('Atuhorization fail, no header');
            error.statusCode = 401;
            throw error;
        }
        const token = authHeader.split(' ')[1];
        if(!token) {
            const error = new Error('Atuhorization fail, no token');
            error.statusCode = 401;
            throw error;
        }
        const user = await User.findOne({ where: { name: token }});
        if(!user){
            const error = new Error('User not found');
            error.statusCode = 404;
            throw error;
        }
        req.userId = user.id;
        req.isAuth = true;
        console.log('User auth success');
        next();
    } catch (err) {
        next(err);
    }
}