/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('PlaylistAlbum', {
    PlaylistID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'Playlist',
        key: 'PlaylistID'
      }
    },
    AlbumID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: 'Album',
        key: 'AlbumID'
      }
    }
  }, {
    tableName: 'PlaylistAlbum'
  });
};
