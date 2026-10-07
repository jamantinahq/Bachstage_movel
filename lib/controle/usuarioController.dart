import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bachstage_mobile/modelo/classes/usuario.dart';
import 'package:bachstage_mobile/modelo/local_storage_service.dart';
import 'package:bachstage_mobile/config.dart';

class UsuarioController {
  static Future<bool> login(String email, String senha) async {
    try {
      final resposta = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'email': email, 'password': senha}),
      );
      if (resposta.statusCode == 200) {
        final corpo = json.decode(resposta.body);
        if (corpo['status'] != 'success') return false;
        final dados = corpo['data'];
        final usuario = Usuario(
          id: dados['id'],
          nome: dados['nome'],
          email: dados['email'],
          senha: '', 
        );

        await LocalStorageService.salvarLogado(usuario);
        await LocalStorageService.salvarToken(dados['tokenAuth']);
        return true;
      }
      return false; 
    } catch (e) {
      return false;
    }
  }

  static Future<void> logout() async {
    final token = await LocalStorageService.carregarToken();
    if (token != null) {
      try {
        await http.post(
          Uri.parse('$baseUrl/logout'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
      } catch (e) {
      }
    }
    await LocalStorageService.removerLogado();
    await LocalStorageService.removerToken();
  }

  static Future<Usuario?> usuarioLogado() async {
    return await LocalStorageService.carregarLogado();
  }

  static Future<bool> estaLogado() async {
    final usuario = await LocalStorageService.carregarLogado();
    final token = await LocalStorageService.carregarToken();
    return usuario != null && token != null;
  }

  static Future<String?> tokenAtual() async {
    return await LocalStorageService.carregarToken();
  }

  static Future<DateTime?> ultimaAtualizacao() async {
    return await LocalStorageService.carregarUltimaAtualizacao();
  }
}
