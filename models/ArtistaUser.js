/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('ArtistaUser', {
    ArtistaID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'Artista',
        key: 'ArtistaID'
      }
    },
    UserID: {
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: 'Users',
        key: 'UserID'
      }
    }
  }, {
    tableName: 'ArtistaUser'
  });
};
