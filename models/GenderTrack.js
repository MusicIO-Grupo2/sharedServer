/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('GenderTrack', {
    trackId: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'Track',
        key: 'trackId'
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
    tableName: 'GenderTrack'
  });
};
