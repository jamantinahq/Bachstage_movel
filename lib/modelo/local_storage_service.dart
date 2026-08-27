import 'package:shared_preferences/shared_preferences.dart';
import 'package:bachstage_mobile/modelo/classes/evento.dart';
import 'package:bachstage_mobile/modelo/classes/favorito.dart';
import 'package:bachstage_mobile/modelo/classes/usuario.dart';
import 'dart:convert';

class LocalStorageService {
  static const String LISTA_EVENTOS = 'lista_eventos';
  static Future<void> salvarEventos(List<Evento> lista) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = Evento.encode(lista);
    await prefs.setString(LISTA_EVENTOS, encodedData);
  }

  static Future<List<Evento>> carregarEvento() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? eventosJson = prefs.getString(LISTA_EVENTOS);
    if (eventosJson == null) return [];
    return Evento.decode(eventosJson);
  }

  static const String LISTA_FAVORITOS = 'lista_favoritos';

  static Future<void> salvarFavoritos(List<favorito> lista) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = favorito.encode(lista);
    await prefs.setString(LISTA_FAVORITOS, encodedData);
  }

  static Future<List<favorito>> carregarFavoritos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? favoritosJson = prefs.getString(LISTA_FAVORITOS);
    if (favoritosJson == null) return [];
    return favorito.decode(favoritosJson);
  }

  static const String LISTA_USUARIOS = 'lista_usuarios';

  static Future<void> salvarUsuarios(List<Usuario> lista) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = Usuario.encode(lista);
    await prefs.setString(LISTA_USUARIOS, encodedData);
  }

  static Future<List<Usuario>> carregarUsuarios() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? usuariosJson = prefs.getString(LISTA_USUARIOS);
    if (usuariosJson == null) return [];
    return Usuario.decode(usuariosJson);
  }

  static const String USUARIO_LOGADO = 'usuario_logado';
  
  static Future<void> salvarLogado(Usuario usuario) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(usuario.toMap());
    await prefs.setString(USUARIO_LOGADO, encodedData);
  }

  static Future<Usuario?>carregarLogado() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? usuarioJson = prefs.getString(USUARIO_LOGADO);
    if (usuarioJson == null) return null;
    return Usuario.fromMap(json.decode(usuarioJson));
  }

  static Future<void> removerLogado() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(USUARIO_LOGADO);
  }
}
