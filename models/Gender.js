/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Gender', {
    genderId: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true
    },
    description: {
      type: DataTypes.STRING,
      allowNull: false
    },
    active: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: true
    }
  }, {
    tableName: 'Gender'
  });
};
