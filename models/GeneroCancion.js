/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('GeneroCancion', {
    CancionID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'Cancion',
        key: 'CancionID'
      }
    },
    GeneroID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: 'Genero',
        key: 'GeneroID'
      }
    }
  }, {
    tableName: 'GeneroCancion'
  });
};
