/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Album', {
    AlbumID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true
    },
    Nombre: {
      type: DataTypes.STRING,
      allowNull: false
    },
    FechaLanzamiento: {
      type: DataTypes.DATE,
      allowNull: true
    },
    Activo: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
      defaultValue: true
    }
  }, {
    tableName: 'Album'
  });
};
