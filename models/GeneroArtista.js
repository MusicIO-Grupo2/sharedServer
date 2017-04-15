/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('GeneroArtista', {
    ArtistaID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'Artista',
        key: 'ArtistaID'
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
    tableName: 'GeneroArtista'
  });
};
