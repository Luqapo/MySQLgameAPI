const checkSortQuery = require('./checkSortQuery');

module.exports = (userId, query) => {

    const { limit, category, sort } = query;

    return {
        where: {
            uid: userId,
            ...(category && {category})
        },
        ...(limit && {limit: Number(limit)}),
        ...(sort && {order: [
            ['updatedAt', checkSortQuery(sort)]
        ]})
    };
}