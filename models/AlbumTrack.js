/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('AlbumTrack', {
    albumId: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'Album',
        key: 'albumId'
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
    tableName: 'AlbumTrack'
  });
};
