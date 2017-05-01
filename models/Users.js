/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Users', {
    UserID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true
    },
    Name: {
      type: DataTypes.STRING,
      allowNull: true
    },
    LastName: {
      type: DataTypes.STRING,
      allowNull: true
    },
    Email: {
      type: DataTypes.STRING,
      allowNull: true
    },
    Passwd: {
      type: DataTypes.STRING,
      allowNull: true
    },
    FechaNacimiento: {
      type: DataTypes.DATE,
      allowNull: true
    },
    Activo: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false
    },
    ImageName: {
      type: DataTypes.STRING,
      allowNull: true
    }
  }, {
    tableName: 'Users'
  });
};
