/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('RateTrack', {
    userId: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'Users',
        key: 'userId'
      }
    },
    trackId: {
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: 'Track',
        key: 'trackId'
      }
    },
    rate: {
      type: DataTypes.INTEGER,
      allowNull: false
    }
  }, {
    tableName: 'RateTrack'
  });
};
