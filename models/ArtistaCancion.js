/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('ArtistaCancion', {
    ArtistaID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'Artista',
        key: 'ArtistaID'
      }
    },
    CancionID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: 'Cancion',
        key: 'CancionID'
      }
    }
  }, {
    tableName: 'ArtistaCancion'
  });
};
