Feature: Registrar Usuario
  Como administrador del sistema
  Quiero registrar nuevos usuarios
  Para gestionar el acceso al sistema

  Background:
    * url baseUrl
    * def dataGenerator = call read('classpath:helpers/DataGenerator.js')

  @smoke @positive
  Scenario: Registrar usuario administrador exitosamente
    * def userData = dataGenerator.generateUserData()

    Given path 'usuarios'
    And request userData
    When method POST
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'
    And match response._id == '#string'
    And match response._id == '#notnull'
    And match response ==
      """
      {
        message: '#string',
        _id: '#string'
      }
      """

    # Cleanup
    * def userId = response._id
    Given path 'usuarios', userId
    When method DELETE

  @positive
  Scenario: Registrar usuario no administrador
    * def userData = dataGenerator.generateUserDataNonAdmin()

    Given path 'usuarios'
    And request userData
    When method POST
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'
    And match response == { message: '#string', _id: '#string' }

    # Cleanup
    * def userId = response._id
    Given path 'usuarios', userId
    When method DELETE

  @negative
  Scenario: Intentar registrar usuario con email duplicado
    * def userData = dataGenerator.generateUserData()

    # Crear usuario
    Given path 'usuarios'
    And request userData
    When method POST
    Then status 201
    * def userId = response._id

    # Intentar crear otro con mismo email
    Given path 'usuarios'
    And request userData
    When method POST
    Then status 400
    And match response.message == 'Este email já está sendo usado'
    And match response == { message: '#string' }

    # Cleanup
    Given path 'usuarios', userId
    When method DELETE

  @negative
  Scenario: Intentar registrar usuario sin nombre
    * def userData =
      """
      {
        email: 'test@qa.com',
        password: 'senha123',
        administrador: 'true'
      }
      """

    Given path 'usuarios'
    And request userData
    When method POST
    Then status 400
    And match response.nome == 'nome é obrigatório'
    And match response == { nome: '#string' }

  @negative
  Scenario: Intentar registrar usuario sin email
    * def userData =
      """
      {
        nome: 'Test User',
        password: 'senha123',
        administrador: 'true'
      }
      """

    Given path 'usuarios'
    And request userData
    When method POST
    Then status 400
    And match response.email == 'email é obrigatório'
    And match response == { email: '#string' }

  @negative
  Scenario: Intentar registrar usuario sin password
    * def userData =
      """
      {
        nome: 'Test User',
        email: 'test@qa.com',
        administrador: 'true'
      }
      """

    Given path 'usuarios'
    And request userData
    When method POST
    Then status 400
    And match response.password == 'password é obrigatório'
    And match response == { password: '#string' }

  @negative
  Scenario: Intentar registrar usuario con email inválido
    * def userData =
      """
      {
        nome: 'Test User',
        email: 'email-invalido',
        password: 'senha123',
        administrador: 'true'
      }
      """

    Given path 'usuarios'
    And request userData
    When method POST
    Then status 400
    And match response.email == 'email deve ser um email válido'
    And match response == { email: '#string' }