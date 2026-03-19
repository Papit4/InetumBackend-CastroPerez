function fn() {

  // Validate user schema
  function validateUsuario(response) {
    // Validar campos requeridos
    karate.match(response._id, '#string');
    karate.match(response.nome, '#string');
    karate.match(response.email, '#string');
    karate.match(response.password, '#string');
    karate.match(response.administrador, '#regex (true|false)');

    // Validar que no haya campos extra inesperados
    var expectedKeys = ['_id', 'nome', 'email', 'password', 'administrador'];
    var actualKeys = Object.keys(response);

    actualKeys.forEach(function(key) {
      if (expectedKeys.indexOf(key) === -1) {
        karate.fail('Unexpected field in response: ' + key);
      }
    });

    return true;
  }

  // Validate lista usuarios schema
  function validateListaUsuarios(response) {
    karate.match(response.quantidade, '#number');
    karate.match(response.usuarios, '#array');

    // Validar cada usuario en el array
    response.usuarios.forEach(function(usuario) {
      validateUsuario(usuario);
    });

    return true;
  }

  return {
    validateUsuario: validateUsuario,
    validateListaUsuarios: validateListaUsuarios
  };
}