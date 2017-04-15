/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('PlaylistCancion', {
    PlaylistID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'Playlist',
        key: 'PlaylistID'
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
    tableName: 'PlaylistCancion'
  });
};
