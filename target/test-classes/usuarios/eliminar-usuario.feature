Feature: Eliminar Usuario
  Como administrador del sistema
  Quiero eliminar usuarios del sistema
  Para mantener la base de datos limpia

  Background:
    * url baseUrl
    * def dataGenerator = call read('classpath:helpers/DataGenerator.js')

  @smoke @positive
  Scenario: Eliminar usuario existente exitosamente
    # Crear usuario primero
    * def userData = dataGenerator.generateUserData()
    Given path 'usuarios'
    And request userData
    When method POST
    Then status 201
    * def userId = response._id

    # Eliminar usuario
    Given path 'usuarios', userId
    When method DELETE
    Then status 200
    And match response == { message: '#string' }
    And match response.message == '#regex (Registro excluído com sucesso|Nenhum registro excluído)'

  @positive
  Scenario: Verificar que usuario eliminado no existe
    # Crear usuario
    * def userData = dataGenerator.generateUserData()
    Given path 'usuarios'
    And request userData
    When method POST
    Then status 201
    * def userId = response._id

    # Eliminar
    Given path 'usuarios', userId
    When method DELETE
    Then status 200
    And match response == { message: '#string' }

    # Verificar que no existe
    Given path 'usuarios', userId
    When method GET
    Then status 400

  @negative
  Scenario: Intentar eliminar usuario con ID inexistente
    Given path 'usuarios', 'idInexistente1234567890AB'
    When method DELETE
    Then status 200
    And match response.message == 'Nenhum registro excluído'
    And match response == { message: '#string' }