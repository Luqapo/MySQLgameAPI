const checkSortQuery = require('./checkSortQuery');

module.exports = (userId, query) => {

    const { limit, category, sort } = query;
    console.log(limit, category, sort);

    
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

    
    // const setLimit = Number(limit);
    // if (limit && !category && !sort) {
    //     return {
    //         where: {
    //             uid: userId
    //         },
    //         limit: setLimit
    //     };
    // }
    // if (category && !limit && !sort) {
    //     return {
    //         where: {
    //             uid: userId,
    //             category: category
    //         }
    //     };
    // }
    // if (category && limit && !sort) {
    //     return {
    //         where: {
    //             uid: userId,
    //             category: category
    //         },
    //         limit: setLimit
    //     };
    // }
    // if (category && limit && sort) {
    //     const sortQuery = checkSortQuery(sort);
    //     return {
    //         where: {
    //             uid: userId,
    //             category: category
    //         },
    //         limit: setLimit,
    //         order: [
    //             ['updatedAt', sortQuery]
    //         ]
    //     };
    // }
    // if (sort && !limit && !category) {
    //     const sortQuery = checkSortQuery(sort);
    //     return {
    //         where: {
    //             uid: userId
    //         },
    //         order: [
    //             ['updatedAt', sortQuery]
    //         ]
    //     }
    // }
    // if (category && !limit && sort) {
    //     const sortQuery = checkSortQuery(sort);
    //     return {
    //         where: {
    //             uid: userId,
    //             category: category
    //         },
    //         order: [
    //             ['updatedAt', sortQuery]
    //         ]
    //     };
    // }
    // if (!category && limit && sort) {
    //     const sortQuery = checkSortQuery(sort);
    //     return {
    //         where: {
    //             uid: userId
    //         },
    //         limit: setLimit,
    //         order: [
    //             ['updatedAt', sortQuery]
    //         ]
    //     };
    // }
}