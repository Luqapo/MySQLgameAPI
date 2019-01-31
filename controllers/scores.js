const Score = require('../models').Score;
const models = require('../models');

module.exports = {
    create(req, res) {
        return Score
            .create({
                category: req.body.category,
                score: req.body.score,
                uid: req.body.userId
            })
            .then(score => res.status(201).send(score))
            .catch(err => res.status(500).send(err));
    },
    async get(req, res) {
        try {
        const limit = Number(req.query.limit);
        if(!limit) {
            const scores = await Score.findAll({
                where: { uid: req.query.userId },
            })
        return res.status(200).send(scores);
        } 
        const scores = await Score.findAll({
                where: { uid: req.query.userId },
                limit
            })
        res.status(200).send(scores);
        } catch(err)  {
                console.log(err);
                res.status(500).send({message: 'Limit not set'});
        }
    },
    delete(req, res) {
        console.log(req.params.scoreId);
        return Score    
            .destroy({where: {id: req.params.scoreId}})
            .then(score => {
                res.status(200).send({message: 'Score deleted', score})
            })
            .catch(err => {
                res.status(500).send({ message: 'Delete failed'});
            });
    },
    async summary(req,res) {
        console.log(req.query.userId)
        try {
        const maxScore = await Score.findAll({
            where: { uid: req.query.userId },
            attributes: [
                'createdAt',
                [
                    models.sequelize.fn('MAX', models.sequelize.col('score')),
                    'max_score'
                ]
            ]
        });
        const avargeScore = await Score.findAll({
            where: { uid: req.query.userId },
            attributes: [
                'createdAt',
                [
                    models.sequelize.fn('AVG', models.sequelize.col('score')),
                    'avg_score'
                ]
            ]
        });
        const minScore = await Score.findAll({
            where: { uid: req.query.userId },
            attributes: [
                'createdAt',
                [
                    models.sequelize.fn('MIN', models.sequelize.col('score')),
                    'min_score'
                ]
            ]
        });
        return res.status(200).send({maxScore, avargeScore, minScore});
        } catch (err) {
            console.log(err);
            res.status(500).send({ message:'Err Find', err});
        }

    }
};