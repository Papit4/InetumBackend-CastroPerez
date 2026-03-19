📄 README.md (Copiar y pegar completo)markdown# ServeRest API - Automated Testing Suite

Suite de pruebas automatizadas para la API de Usuarios de [ServeRest](https://serverest.dev/) utilizando **Karate DSL**.

## 🛠️ Tecnologías

- **Karate DSL** `1.4.1` - Framework BDD para API Testing
- **Java** `11+` - Lenguaje de programación
- **Maven** `3.x` - Gestión de dependencias
- **JUnit 5** - Ejecución de tests

## 🚀 Requisitos Previos

- Java JDK 11 o superior
- Maven 3.x

Verificar instalación:
```bashjava -version
mvn -version

## 📦 Instalación
```bashClonar repositorio
git clone https://github.com/Papit4/InetumBackend-CastroPerez.git
cd InetumBackend-CastroPerezInstalar dependencias
mvn clean install

## ▶️ Ejecutar Tests
```bashTodos los tests
mvn testFeature específico
mvn test -Dtest=UsuariosTest#testListarUsuariosCon tags
mvn test -Dkarate.options="--tags @smoke"

## 📊 Ver Reportes

Después de ejecutar tests, abrir:target/karate-reports/karate-summary.html

## 📁 Estructura del ProyectoInetumBackend-CastroPerez/
├── src/test/
│   ├── java/
│   │   └── runners/
│   │       └── UsuariosTest.java
│   └── resources/
│       ├── usuarios/
│       │   ├── listar-usuarios.feature
│       │   ├── registrar-usuario.feature
│       │   ├── buscar-usuario.feature
│       │   ├── actualizar-usuario.feature
│       │   └── eliminar-usuario.feature
│       ├── helpers/
│       │   ├── DataGenerator.js
│       │   └── SchemaValidator.js
│       ├── schemas/
│       │   ├── usuario-schema.json
│       │   └── lista-usuarios-schema.json
│       └── karate-config.js
├── pom.xml
└── README.md

## 🧪 Cobertura de Tests

### Endpoints Cubiertos

| Método | Endpoint | Escenarios |
|--------|----------|------------|
| GET | `/usuarios` | Listar, búsqueda por parámetros |
| POST | `/usuarios` | Registro exitoso, validaciones |
| GET | `/usuarios/{id}` | Buscar existente/inexistente |
| PUT | `/usuarios/{id}` | Actualización, validaciones |
| DELETE | `/usuarios/{id}` | Eliminación exitosa/fallida |

**Total:** 23 escenarios (12 positivos, 11 negativos)

## 🎯 Características

### Generación de Datos
Datos únicos generados dinámicamente para evitar conflictos:
```gherkin
def userData = dataGenerator.generateUserData()


### Validación de Schemas
Validación programática de contratos API:
```gherkin
assert schemaValidator.validateUsuario(response)


### Configuración por Ambiente
```bashmvn test -Dkarate.env=qa

## 🔧 Patrones Implementados

- **BDD:** Casos de prueba en Gherkin
- **Data Generator:** Datos únicos por ejecución
- **Schema Validation:** Validación de contratos
- **Auto Cleanup:** Limpieza automática de datos

## 🐛 Troubleshooting

**Compilación falla:**
```bashmvn clean
mvn test-compile

**Tests no ejecutan:**
- Verificar Java 11+
- Verificar estructura de carpetas

## 📄 Documentación

Ver [AUTOMATION_STRATEGY.md](./AUTOMATION_STRATEGY.md) para estrategia completa.

## 👤 Autor

**Enrique Castro**  
GitHub: [@Papit4](https://github.com/Papit4)