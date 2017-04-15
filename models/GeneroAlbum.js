/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('GeneroAlbum', {
    AlbumID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'Album',
        key: 'AlbumID'
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
    tableName: 'GeneroAlbum'
  });
};
