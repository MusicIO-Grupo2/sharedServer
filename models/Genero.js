/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Genero', {
    GeneroID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true
    },
    Descripcion: {
      type: DataTypes.STRING,
      allowNull: false
    },
    Activo: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: true
    }
  }, {
    tableName: 'Genero'
  });
};
