/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('AlbumCancion', {
    AlbumID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'Album',
        key: 'AlbumID'
      }
    },
    CancionID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: 'Cancion',
        key: 'CancionID'
      }
    }
  }, {
    tableName: 'AlbumCancion'
  });
};
