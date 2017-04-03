'use strict';

module.exports = {
  up: function (queryInterface, Sequelize) {
    queryInterface.addColumn(
  'Users',
  'FechaNacimiento',
  {
    type: Sequelize.DATEONLY,
    allowNull: true
  }
)

  },

  down: function (queryInterface, Sequelize) {
    queryInterface.removeColumn('Users', 'FechaNacimiento')
  }
};
