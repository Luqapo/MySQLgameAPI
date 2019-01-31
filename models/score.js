'use strict';
module.exports = (sequelize, DataTypes) => {
  const Score = sequelize.define('Score', {
    category: DataTypes.STRING,
    score: DataTypes.INTEGER
  }, {});
  Score.associate = function(models) {
    // associations can be defined here
    Score.belongsTo(models.User,{
      foreignKey: 'uid',
      as: 'userId'
    })
  };
  return Score;
};