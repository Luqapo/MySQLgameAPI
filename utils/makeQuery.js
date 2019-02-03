module.exports = (userId, query) => {
    console.log(Object.keys(query).length === 0);
    if(Object.keys(query).length === 0){
        return { where: { uid: userId } };
    }
    const { limit, category, sort } = query;
    console.log(limit, category, sort);
    if(limit && !category && !sort){
        const setLimit = Number(limit);
        return { where: { uid: userId }, limit: setLimit };
    }
    if(category && !limit && !sort){
        return { where: { uid: userId, category: category }};
    }
    if(sort && !limit && !category){
        return { where: { uid: userId }, order: [['updatedAt', sort]] }
    }
}