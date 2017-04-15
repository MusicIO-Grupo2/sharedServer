/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Playlist', {
    PlaylistID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true
    },
    Nombre: {
      type: DataTypes.STRING,
      allowNull: false
    },
    UserCreacion: {
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: 'Users',
        key: 'UserID'
      }
    },
    Activo: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: true
    }
  }, {
    tableName: 'Playlist'
  });
};
