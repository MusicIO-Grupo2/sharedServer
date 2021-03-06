/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('PlaylistAlbum', {
    playlistId: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'Playlist',
        key: 'playlistId'
      }
    },
    albumId: {
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: 'Album',
        key: 'albumId'
      }
    }
  }, {
    tableName: 'PlaylistAlbum'
  });
};
