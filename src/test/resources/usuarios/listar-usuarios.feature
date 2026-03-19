Feature: Listar Usuarios
  Como administrador del sistema
  Quiero listar todos los usuarios
  Para visualizar la base de datos de usuarios

  Background:
    * url baseUrl
    * def listaSchema = read('classpath:schemas/lista-usuarios-schema.json')

  @smoke @positive
  Scenario: Listar todos los usuarios exitosamente
    Given path 'usuarios'
    When method GET
    Then status 200
    And match response.quantidade == '#number'
    And match response.usuarios == '#array'
    And match each response.usuarios ==
      """
      {
        _id: '#string',
        nome: '#string',
        email: '#string',
        password: '#string',
        administrador: '#string'
      }
      """

  @positive
  Scenario: Listar usuarios con paginación
    Given path 'usuarios'
    And param _limit = 5
    And param _skip = 0
    When method GET
    Then status 200
    And match response.quantidade == '#number'
    And match response.usuarios == '#[0..5]'

  @positive
  Scenario: Buscar usuario por nombre
    Given path 'usuarios'
    And param nome = 'Fulano'
    When method GET
    Then status 200
    And match response.quantidade == '#number'
    And match response.usuarios == '#array'

  @positive
  Scenario: Buscar usuario por email
    Given path 'usuarios'
    And param email = 'fulano@qa.com'
    When method GET
    Then status 200
    And match response.quantidade == '#number'

  @negative
  Scenario: Listar usuarios con parámetro inválido
    Given path 'usuarios'
    And param invalid_param = 'test'
    When method GET
    Then status 200
    * print 'API ignora parámetros desconocidos'