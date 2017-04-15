/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('PuntuacionCancion', {
    UserID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'Users',
        key: 'UserID'
      }
    },
    CancionID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: 'Cancion',
        key: 'CancionID'
      }
    },
    Puntaje: {
      type: DataTypes.INTEGER,
      allowNull: false
    }
  }, {
    tableName: 'PuntuacionCancion'
  });
};
