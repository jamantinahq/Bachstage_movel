import 'package:bachstage_mobile/modelo/classes/usuario.dart';
import 'package:bachstage_mobile/modelo/local_storage_service.dart';

class UsuarioController {

  static Future<void> salvarLogin(Usuario usuario) async {
    await LocalStorageService.salvarLogado(usuario);
  }

  static Future<bool> verificaLoginOnline(String email, String senha) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'teste1@gmail.com' && senha == 'teste1kkkk') {
      Usuario usuarioRetorno = Usuario(
        id: 1,
        nome: 'fera',
        email: email,
        senha: 'çalskdfsoiu23j́bdçvocuiyvhkjqerb-iudfhnsbdkljqghoi',
      );
      await salvarLogin(usuarioRetorno);
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> verificaLoginOffline() async {
    Usuario? usuario = await LocalStorageService.carregarLogado();
    if (usuario == null) return false;
    return true;
  }

  static Future<Usuario?> usuarioLogado() async {
    return await LocalStorageService.carregarLogado();
  }

  static Future<void> logout() async {
    await LocalStorageService.removerLogado();
  }
}
