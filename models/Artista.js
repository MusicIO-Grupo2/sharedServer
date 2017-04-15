/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Artista', {
    ArtistaID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true
    },
    Nombre: {
      type: DataTypes.STRING,
      allowNull: true
    },
    Apellido: {
      type: DataTypes.STRING,
      allowNull: true
    },
    Edad: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    Activo: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: true
    }
  }, {
    tableName: 'Artista'
  });
};
