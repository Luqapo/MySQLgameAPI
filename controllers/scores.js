const Score = require('../models').Score;
const sequelize = require('../models').sequelize;

module.exports = {
    async create(req, res) { 
        try {
            const score = await Score.create({
                    category: req.body.category,
                    score: req.body.score,
                    uid: req.userId
                })
            res.status(201).send(score);
        }catch(err) {
            res.status(500).send(err);
        }
    },
    async get(req, res) {
        try {
            const limit = Number(req.query.limit);
            if(!limit) {
                const scores = await Score.findAll({
                    where: { uid: req.userId },
                })
            return res.status(200).send(scores);
            } 
            const scores = await Score.findAll({
                    where: { uid: req.userId },
                    limit
                })
            res.status(200).send(scores);
        } catch(err)  {
                console.log(err);
                res.status(500).send({message: 'Limit not set'});
        }
    },
    async delete(req, res) {
        console.log(req.params.scoreId); 
        try {  
            const destroyedScore = await Score.destroy({where: { id: req.params.scoreId,
                                                                 uid: req.userId }});
            res.status(200).send({message: 'Score deleted', destroyedScore})    
        }catch(err) {
            res.status(500).send({ message: 'Delete failed'});
        }
    },
    async summary(req,res) {
        // in MySQl ----> SET GLOBAL sql_mode = '';
        try {
        const maxScore = await Score.findAll({
            where: { uid: req.userId },
            attributes: [
                'createdAt',
                [
                    sequelize.fn('MAX', sequelize.col('score')),
                    'max_score'
                ]
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
            ]
        });
        const minScore = await Score.findAll({
            where: { uid: req.userId },
            attributes: [
                'createdAt',
                [
                    sequelize.fn('MIN', sequelize.col('score')),
                    'min_score'
                ]
            ]
        });
        return res.status(200).send({maxScore, avargeScore, minScore});
        } catch (err) {
            console.log(err);
            res.status(500).send({ message:'Err Find', err});
        }

    },
    async category(req, res) {
        const category = req.query.category;
        if(!category) {
            return res.status(500).send({ message: 'Category nedded'});
        }
        try {
            const scores = await Score.findAll({
                where: { uid: req.userId,
                category }
            })
        res.status(200).send(scores);
        } catch (err) {
            console.log(err);
            res.status(500).send({ message: 'Error while finding category'});
        }
    },
    async sort(req, res) {
        const sort = req.query.sort;
        if(!sort || !(sort === 'DESC' || sort === 'ASC')){
           return res.status(500).send({ message: 'Wrong search param!'})
        }
        try {
            const sortedScore = await Score.findAll({
                where: { uid: req.userId },
                order: [['updatedAt', sort]]
            });
            res.status(200).send(sortedScore);
        } catch (err) {
            console.log(err);
            res.status(500).send({ message: 'Error while sorting score'});
        }
    }
};