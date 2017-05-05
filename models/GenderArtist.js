/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('GenderArtist', {
    artistId: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'Artist',
        key: 'artistId'
      }
    },
    genderId: {
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: 'Gender',
        key: 'genderId'
      }
    }
  }, {
    tableName: 'GenderArtist'
  });
};
