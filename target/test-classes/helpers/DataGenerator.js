function fn() {

  // Generate random string
  function randomString(length) {
    var chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    var result = '';
    for (var i = 0; i < length; i++) {
      result += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return result;
  }

  // Generate random email
  function randomEmail() {
    var timestamp = new Date().getTime();
    var random = randomString(8);
    return 'test_' + random + '_' + timestamp + '@qa.com';
  }

  // Generate random user data
  function generateUserData() {
    var timestamp = new Date().getTime();
    var random = randomString(6);

    return {
      nome: 'Usuario Test ' + random,
      email: randomEmail(),
      password: 'senha@' + timestamp,
      administrador: 'true'
    };
  }

  // Generate random user data (non-admin)
  function generateUserDataNonAdmin() {
    var userData = generateUserData();
    userData.administrador = 'false';
    return userData;
  }

  return {
    randomString: randomString,
    randomEmail: randomEmail,
    generateUserData: generateUserData,
    generateUserDataNonAdmin: generateUserDataNonAdmin
  };
}