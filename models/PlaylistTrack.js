/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('PlaylistTrack', {
    playlistId: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'Playlist',
        key: 'playlistId'
      }
    },
    trackId: {
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: 'Track',
        key: 'trackId'
      }
    }
  }, {
    tableName: 'PlaylistTrack'
  });
};
