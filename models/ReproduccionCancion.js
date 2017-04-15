/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('ReproduccionCancion', {
    CancionID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'Cancion',
        key: 'CancionID'
      }
    },
    UserID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: 'Users',
        key: 'UserID'
      }
    },
    Fecha: {
      type: DataTypes.DATE,
      allowNull: false
    }
  }, {
    tableName: 'ReproduccionCancion'
  });
};
