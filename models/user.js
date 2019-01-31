'use strict';
module.exports = (sequelize, DataTypes) => {
  const User = sequelize.define('User', {
    name: DataTypes.STRING
  }, {});
  User.associate = models => {
    // associations can be defined here
    User.hasMany(models.Score,{
      foreignKey: 'uid',
      as: 'userID'
    })
  };
  return User;
};