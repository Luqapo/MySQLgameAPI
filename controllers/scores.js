const Score = require('../models').Score;
const sequelize = require('../models').sequelize;

const makeQuery  = require('../utils/makeQuery');

module.exports = {
    async create(req, res, next) { 
        try {
            const score = await Score.create({
                    category: req.body.category,
                    score: req.body.score,
                    uid: req.userId
                })
            res.status(201).send(score);
        }catch(err) {
            next(err);
        }
    },
    async get(req, res, next) {
        try {
            const query = makeQuery(req.userId, req.query);
            const scores = await Score.findAll(query);
            res.status(200).send(scores);
        } catch(err)  {
            next(err);
        }
    },
    async delete(req, res, next) {
        try {  
            const destroyedScore = await Score.destroy({where: { id: req.params.scoreId,
                                                                 uid: req.userId }});
            res.status(200).send({message: 'Score deleted', destroyedScore})    
        }catch(err) {
            next(err);
        }
    },
    async summary(req, res, next) {
        // in MySQl ----> SET GLOBAL sql_mode = '';
        try {
        const maxScore = await Score.findAll({
            where: {
                uid: req.userId
            },
            limit: 1,
            attributes: [
                'createdAt',
                'score'
            ],
            order: [
                ['score', 'DESC']
            ]
        });
        const avargeScore = await Score.findAll({
            where: { uid: req.userId },
            attributes: [
                'createdAt',
                [
                    sequelize.fn('AVG', sequelize.col('score')),
                    'avg_score'
                ]
            ],
            group: ['createdAt'],
            limit: 1
        });
        const minScore = await Score.findAll({
            where: {
                uid: req.userId
            },
            limit: 1,
            attributes: [
                'createdAt',
                'score'
            ],
            order: [
                ['score', 'ASC']
            ]
        });
        return res.status(200).send({maxScore, avargeScore, minScore});
        } catch (err) {
            next(err);
        }

    }
};