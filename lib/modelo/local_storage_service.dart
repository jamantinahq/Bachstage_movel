import 'package:shared_preferences/shared_preferences.dart';
import 'package:bachstage_mobile/modelo/classes/evento.dart';
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

  static const String USUARIO_LOGADO = 'usuario_logado';

  static Future<void> salvarLogado(Usuario usuario) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(usuario.toMap());
    await prefs.setString(USUARIO_LOGADO, encodedData);
  }

  static Future<Usuario?> carregarLogado() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? usuarioJson = prefs.getString(USUARIO_LOGADO);
    if (usuarioJson == null) return null;
    return Usuario.fromMap(json.decode(usuarioJson));
  }

  static Future<void> removerLogado() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(USUARIO_LOGADO);
  }

  static const String TOKEN = "api_token";

  static Future<void> salvarToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(TOKEN, token);
  }

  static Future<String?> carregarToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(TOKEN);
  }

  static Future<void> removerToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(TOKEN);
  }

  static const String ULTIMA_ATUALIZACAO = "ultima_atualizacao";

  static Future<void> salvarUltimaAtualizacao(DateTime data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(ULTIMA_ATUALIZACAO, data.toIso8601String());
  }

  static Future<DateTime?> carregarUltimaAtualizacao() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? dataString = prefs.getString(ULTIMA_ATUALIZACAO);
    if (dataString == null) return null;
    return DateTime.parse(dataString);
  }
}
