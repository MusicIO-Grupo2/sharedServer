/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Contacto', {
    UserID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'Users',
        key: 'UserID'
      }
    },
    ContactoID: {
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
    tableName: 'Contacto'
  });
};
