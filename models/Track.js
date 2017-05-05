/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Track', {
    trackId: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false
    },
    description: {
      type: DataTypes.STRING,
      allowNull: true
    },
    active: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: true
    },
    duration: {
      type: DataTypes.BIGINT,
      allowNull: true
    }
  }, {
    tableName: 'Track'
  });
};
