'use strict';

const config = {
  production: {
    database: `${process.env.MONGODB_URI}`
  },

  development: {
    database: 'mongodb://localhost/<devDB>'
  },

  test: {
    database: 'mongodb://localhost/<testDB>'
  },

  default: {
    database: 'mongodb://localhost/<productionDB>'
  }
};

exports.get = function get(env) {
  return config[env] || config.default;
};
