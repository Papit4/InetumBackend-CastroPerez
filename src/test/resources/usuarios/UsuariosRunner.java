package usuarios;

import com.intuit.karate.junit5.Karate;

class UsuariosRunner {

    @Karate.Test
    Karate testUsuarios() {
        return Karate.run("classpath:usuarios").relativeTo(getClass());
    }

    @Karate.Test
    Karate testListarUsuarios() {
        return Karate.run("classpath:usuarios/listar-usuarios.feature").relativeTo(getClass());
    }

    @Karate.Test
    Karate testRegistrarUsuario() {
        return Karate.run("classpath:usuarios/registrar-usuario.feature").relativeTo(getClass());
    }

    @Karate.Test
    Karate testBuscarUsuario() {
        return Karate.run("classpath:usuarios/buscar-usuario.feature").relativeTo(getClass());
    }

    @Karate.Test
    Karate testActualizarUsuario() {
        return Karate.run("classpath:usuarios/actualizar-usuario.feature").relativeTo(getClass());
    }
}