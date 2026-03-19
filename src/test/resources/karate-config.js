function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);

  if (!env) {
    env = 'dev';
  }

  var config = {
    baseUrl: 'https://serverest.dev',
    timeout: 30000
  };

  // Environment-specific configuration
  if (env == 'dev') {
    config.baseUrl = 'https://serverest.dev';
  } else if (env == 'qa') {
    config.baseUrl = 'https://serverest.dev'; // Can be different QA URL
  } else if (env == 'prod') {
    config.baseUrl = 'https://serverest.dev';
  }

  karate.configure('connectTimeout', config.timeout);
  karate.configure('readTimeout', config.timeout);

  return config;
}