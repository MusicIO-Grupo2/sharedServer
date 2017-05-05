/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('ArtistUser', {
    artistId: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'Artist',
        key: 'artistId'
      }
    },
    userId: {
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: 'Users',
        key: 'userId'
      }
    }
  }, {
    tableName: 'ArtistUser'
  });
};
