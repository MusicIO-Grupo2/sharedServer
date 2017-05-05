/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('ArtistTrack', {
    artistId: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'Artist',
        key: 'artistId'
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
    tableName: 'ArtistTrack'
  });
};
