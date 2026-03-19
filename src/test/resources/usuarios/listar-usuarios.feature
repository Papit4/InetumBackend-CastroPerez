Feature: Listar Usuarios
  Como administrador del sistema
  Quiero listar todos los usuarios
  Para visualizar la base de datos de usuarios

  Background:
    * url baseUrl
    * def schemaValidator = call read('classpath:helpers/SchemaValidator.js')

  @smoke @positive
  Scenario: Listar todos los usuarios exitosamente
    Given path 'usuarios'
    When method GET
    Then status 200
    And match response.quantidade == '#number'
    And match response.usuarios == '#array'
    * assert schemaValidator.validateListaUsuarios(response)

  @positive
  Scenario: Verificar estructura de respuesta al listar usuarios
    Given path 'usuarios'
    When method GET
    Then status 200
    * assert schemaValidator.validateListaUsuarios(response)
    And match response ==
      """
      {
        quantidade: '#number',
        usuarios: '#array'
      }
      """

  @positive
  Scenario: Buscar usuario por nombre
    Given path 'usuarios'
    And param nome = 'Admin'
    When method GET
    Then status 200
    * assert schemaValidator.validateListaUsuarios(response)

  @positive
  Scenario: Buscar usuario por email
    Given path 'usuarios'
    And param email = 'admin@qa.com'
    When method GET
    Then status 200
    * assert schemaValidator.validateListaUsuarios(response)

  @negative
  Scenario: Listar usuarios con parámetro inválido
    Given path 'usuarios'
    And param invalid_param = 'test'
    When method GET
    Then status 400
    And match response.invalid_param == 'invalid_param não é permitido'