/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('GenderAlbum', {
    albumId: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'Album',
        key: 'albumId'
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
    tableName: 'GenderAlbum'
  });
};
