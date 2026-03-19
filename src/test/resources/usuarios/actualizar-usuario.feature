Feature: Actualizar Usuario
  Como administrador del sistema
  Quiero actualizar la información de usuarios existentes
  Para mantener los datos actualizados

  Background:
    * url baseUrl
    * def dataGenerator = call read('classpath:helpers/DataGenerator.js')

  @smoke @positive
  Scenario: Actualizar todos los datos de un usuario
    # Crear usuario
    * def userData = dataGenerator.generateUserData()
    Given path 'usuarios'
    And request userData
    When method POST
    Then status 201
    * def userId = response._id

    # Actualizar usuario
    * def updatedData = dataGenerator.generateUserData()
    Given path 'usuarios', userId
    And request updatedData
    When method PUT
    Then status 200
    And match response.message == 'Registro alterado com sucesso'

    # Verificar actualización
    Given path 'usuarios', userId
    When method GET
    Then status 200
    And match response.nome == updatedData.nome
    And match response.email == updatedData.email

    # Cleanup
    Given path 'usuarios', userId
    When method DELETE

  @positive
  Scenario: Actualizar solo el nombre del usuario
    # Crear usuario
    * def userData = dataGenerator.generateUserData()
    Given path 'usuarios'
    And request userData
    When method POST
    Then status 201
    * def userId = response._id

    # Actualizar solo nombre
    * def updateData =
      """
      {
        nome: 'Nombre Actualizado',
        email: '#(userData.email)',
        password: '#(userData.password)',
        administrador: '#(userData.administrador)'
      }
      """
    Given path 'usuarios', userId
    And request updateData
    When method PUT
    Then status 200

    # Cleanup
    Given path 'usuarios', userId
    When method DELETE

  @negative
  Scenario: Intentar actualizar usuario con ID inexistente
    * def userData = dataGenerator.generateUserData()

    Given path 'usuarios', 'idInexistente123'
    And request userData
    When method PUT
    Then status 201
    * print 'API crea un nuevo usuario si el ID no existe'

    # Cleanup del usuario creado
    * def newUserId = response._id
    Given path 'usuarios', newUserId
    When method DELETE

  @negative
  Scenario: Intentar actualizar con email duplicado
    # Crear primer usuario
    * def userData1 = dataGenerator.generateUserData()
    Given path 'usuarios'
    And request userData1
    When method POST
    Then status 201
    * def userId1 = response._id

    # Crear segundo usuario
    * def userData2 = dataGenerator.generateUserData()
    Given path 'usuarios'
    And request userData2
    When method POST
    Then status 201
    * def userId2 = response._id

    # Intentar actualizar user2 con email de user1
    * def updateData =
      """
      {
        nome: 'Test',
        email: '#(userData1.email)',
        password: 'senha123',
        administrador: 'true'
      }
      """
    Given path 'usuarios', userId2
    And request updateData
    When method PUT
    Then status 400
    And match response.message == 'Este email já está sendo usado'

    # Cleanup
    Given path 'usuarios', userId1
    When method DELETE
    Given path 'usuarios', userId2
    When method DELETE

  @negative
  Scenario: Intentar actualizar usuario sin datos obligatorios
    # Crear usuario
    * def userData = dataGenerator.generateUserData()
    Given path 'usuarios'
    And request userData
    When method POST
    Then status 201
    * def userId = response._id

    # Intentar actualizar sin nombre
    * def invalidData =
      """
      {
        email: 'test@qa.com',
        password: 'senha123',
        administrador: 'true'
      }
      """
    Given path 'usuarios', userId
    And request invalidData
    When method PUT
    Then status 400
    And match response.nome == 'nome é obrigatório'

    # Cleanup
    Given path 'usuarios', userId
    When method DELETE