const config = {
  production: {
    database: `${process.env.MONGODB_URI}`
  },

  development: {
    database: 'mongodb://localhost/<database_name>'
  },

  test: {
    database: 'mongodb://localhost/<test_database_name>'
  },

  default: {
    database: 'mongodb://localhost/<database_name>'
  }
}

exports.get = function get(env) {
  return config[env] || config.default;
}