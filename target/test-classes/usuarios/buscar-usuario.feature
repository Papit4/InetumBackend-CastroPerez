Feature: Buscar Usuario por ID
  Como administrador del sistema
  Quiero buscar usuarios por su ID
  Para consultar información específica de un usuario

  Background:
    * url baseUrl
    * def dataGenerator = call read('classpath:helpers/DataGenerator.js')
    * def schemaValidator = call read('classpath:helpers/SchemaValidator.js')

  @smoke @positive
  Scenario: Buscar usuario existente por ID
    # Crear usuario primero
    * def userData = dataGenerator.generateUserData()
    Given path 'usuarios'
    And request userData
    When method POST
    Then status 201
    * def userId = response._id

    # Buscar usuario creado
    Given path 'usuarios', userId
    When method GET
    Then status 200
    * assert schemaValidator.validateUsuario(response)
    And match response._id == userId
    And match response.nome == userData.nome
    And match response.email == userData.email
    And match response.administrador == userData.administrador

    # Cleanup
    Given path 'usuarios', userId
    When method DELETE

  @negative
  Scenario: Buscar usuario con ID inexistente
    Given path 'usuarios', 'idInexistente1234567890AB'
    When method GET
    Then status 400

  @positive
  Scenario: Verificar estructura completa de respuesta
    # Crear usuario
    * def userData = dataGenerator.generateUserData()
    Given path 'usuarios'
    And request userData
    When method POST
    Then status 201
    * def userId = response._id

    # Buscar y validar estructura
    Given path 'usuarios', userId
    When method GET
    Then status 200
    * assert schemaValidator.validateUsuario(response)
    And match response._id == '#notnull'
    And match response.nome == '#present'
    And match response.email == '#present'
    And match response.password == '#present'
    And match response.administrador == '#regex (true|false)'

    # Cleanup
    Given path 'usuarios', userId
    When method DELETE