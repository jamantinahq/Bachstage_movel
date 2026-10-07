import 'package:bachstage_mobile/modelo/classes/evento.dart';
import 'package:bachstage_mobile/modelo/local_storage_service.dart';
import 'package:bachstage_mobile/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventoController {
  static Future<bool> baixarEventos(String token) async {
    try {
      final resposta = await http.get(
        Uri.parse('$baseUrl/eventos'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (resposta.statusCode != 200) return false;
      final corpo = json.decode(resposta.body);
      if (corpo['status'] != 'success') return false;
      final List<dynamic> dados = corpo['data'];

      final eventos = dados.map((item) {
        return Evento(
          id: item['id'],
          nome: item['name'],
          descricao: item['descricao'],
          data: item['data'],
          local: item['local'],
          imagem: item['imagem'] ?? '',
          usuarioId: item['user_id'],
        );
      }).toList();
      await LocalStorageService.salvarEventos(eventos);
      await LocalStorageService.salvarUltimaAtualizacao(DateTime.now());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<Evento>> listarEventos() async {
    List<Evento> lista = await LocalStorageService.carregarEvento();
    return lista;
  }
}
