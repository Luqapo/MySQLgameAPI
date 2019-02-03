module.exports = (sortQuery) => {
    if(!(sortQuery === 'DESC' || sortQuery === 'ASC')){
        const error = new Error('Wrong sort query');
        error.statusCode = 400;
        throw error;
    }
    return sortQuery;
}