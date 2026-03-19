📄 AUTOMATION_STRATEGY.md (Copiar y pegar completo)markdown# Estrategia de Automatización - ServeRest API

## 1. Resumen Ejecutivo

Suite de pruebas automatizadas para la API de Usuarios de ServeRest, implementando testing de contratos, validaciones y casos de error con Karate DSL.

## 2. Alcance del Proyecto

### Incluido
- Operaciones CRUD completas (GET, POST, PUT, DELETE)
- Validación de esquemas JSON
- Casos positivos y negativos
- Generación dinámica de datos

### Excluido
- Performance testing
- Security testing
- Otros endpoints de ServeRest (productos, login)

## 3. Selección de Herramientas

### Karate DSL

**Razones de selección:**
- Sintaxis Gherkin nativa (BDD sin conversión)
- Validaciones JSON potentes built-in
- No requiere Java avanzado
- Reportes HTML automáticos
- Ejecución paralela nativa

**Vs RestAssured:**
- Menos código boilerplate
- Mejor legibilidad para stakeholders
- Setup más rápido

**Vs Postman/Newman:**
- Mayor control programático
- Mejor integración CI/CD
- Data-driven más flexible

## 4. Arquitectura del Framework

### Estructura de CapasFeature Files (Gherkin)
↓
Helpers & Validators (JavaScript)
↓
Configuration & Schemas

### Componentes

**Feature Files (`/usuarios/*.feature`)**
- Un archivo por endpoint
- Scenarios organizados por funcionalidad
- Tags: @smoke, @positive, @negative

**Helpers (`/helpers/`)**
- `DataGenerator.js`: Genera usuarios únicos
- `SchemaValidator.js`: Valida contratos API

**Schemas (`/schemas/`)**
- Documentan estructura de respuestas
- Base para validación programática

**Configuration (`karate-config.js`)**
- BaseURL por ambiente
- Timeouts globales

## 5. Estrategia de Testing

### Distribución de Tests

| Tipo | Cantidad | % |
|------|----------|---|
| Positivos | 12 | 52% |
| Negativos | 11 | 48% |
| **Total** | **23** | **100%** |

### Cobertura por EndpointGET /usuarios         → 5 scenarios
POST /usuarios        → 7 scenarios
GET /usuarios/{id}    → 3 scenarios
PUT /usuarios/{id}    → 5 scenarios
DELETE /usuarios/{id} → 3 scenarios

### Priorización por Riesgo

| Prioridad | Escenario | Tag |
|-----------|-----------|-----|
| Crítica | Registro de usuario | @smoke |
| Crítica | Listar usuarios | @smoke |
| Alta | Validaciones de campos | @negative |
| Media | Búsqueda por parámetros | @positive |

## 6. Manejo de Datos de Prueba

### Estrategia: Generación Dinámica

**DataGenerator.js:**
```javascriptemail: 'test_' + randomString(8) + '_' + timestamp + '@qa.com'

**Ventajas:**
- Sin colisiones de datos
- Ejecutable en paralelo
- No requiere base de datos de prueba
- Cleanup simple

**Pattern de Cleanup:**
```gherkinScenario: Test con cleanup
Setup

def userId = response._id
Test
...Cleanup
Given path 'usuarios', userId
When method DELETE

## 7. Validación de Contratos API

### Dos Niveles

**Nivel 1: JSON Schema (Documentación)**
```json{
"type": "object",
"properties": {
"_id": {"type": "string"}
}
}

**Nivel 2: Validación Programática**
```javascriptfunction validateUsuario(response) {
karate.match(response._id, '#string');
karate.match(response.email, '#string');
}

**Ventajas:**
- Schemas documentan el contrato
- Validator ejecuta validaciones
- Detección temprana de cambios en API

## 8. Estrategia de Ejecución

### Actual
- Secuencial (1 thread)
- ~25 segundos para 23 scenarios
- Headless por defecto

### Futuro (Escalamiento)
- Ejecución paralela (4 threads)
- Integración CI/CD
- Múltiples ambientes (dev/qa/prod)

## 9. Reportes y Observabilidad

### Reportes Generados

**Karate HTML Report:**
- Resumen ejecutivo
- Detalle por scenario
- Request/Response completos
- Tiempos de ejecución

**Ubicación:**target/karate-reports/karate-summary.html

### Métricas Clave

- **Pass Rate:** 100%
- **Tiempo Promedio:** ~1 segundo/test
- **Cobertura:** 5 endpoints, 23 scenarios

## 10. Mantenibilidad

### Prácticas Aplicadas

**Separación de Concerns:**
- Lógica de negocio (features)
- Generación de datos (helpers)
- Validaciones (validators)

**Reusabilidad:**
```gherkinBackground:

def dataGenerator = call read('classpath:helpers/DataGenerator.js')


**Nomenclatura Consistente:**
- Features: `verbo-sustantivo.feature`
- Scenarios: Descripción clara en español
- Variables: camelCase descriptivo

## 11. Riesgos y Mitigación

| Riesgo | Mitigación |
|--------|------------|
| API caída | Timeouts configurables |
| Datos duplicados | Generación con timestamp |
| Tests flaky | Cleanup automático |
| Cambios en API | Schema validation |

## 12. Mejoras Futuras

### Corto Plazo
- [ ] Ejecución paralela
- [ ] Tags para smoke/regression
- [ ] Integración GitHub Actions

### Mediano Plazo
- [ ] Performance tests básicos
- [ ] Múltiples ambientes
- [ ] Test data management avanzado

### Largo Plazo
- [ ] Contract testing con Pact
- [ ] Security testing básico
- [ ] Integración con Allure Reports

## 13. Conclusión

Framework robusto que:
- ✅ Cubre operaciones CRUD completamente
- ✅ Valida contratos API
- ✅ Maneja datos de prueba eficientemente
- ✅ Genera reportes claros
- ✅ Es mantenible y escalable

**Listo para CI/CD y ejecución continua.**

---

**Autor:** Enrique Castro  
**Fecha:** Marzo 2026  
**Versión:** 1.0