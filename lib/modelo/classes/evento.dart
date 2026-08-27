import 'dart:convert';

class Evento {
  final int id;
  final String nome;
  final String local;
  final String data;
  final String descricao;
  final String imagem;
  final int usuarioId;

  Evento({
    required this.id,
    required this.nome,
    required this.local,
    required this.data,
    required this.descricao,
    required this.imagem,
    required this.usuarioId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'local': local,
      'data': data,
      'descricao': descricao,
      'imagem': imagem,
      'usuarioId': usuarioId,
    };
  }

  factory Evento.fromMap(Map<String, dynamic> map) {
    return Evento(
      id: map['id'],
      nome: map['nome'],
      local: map['local'],
      data: map['data'],
      descricao: map['descricao'],
      imagem: map['imagem'],
      usuarioId: map['usuarioId'],
    );
  }

  static String encode(List<Evento> eventos) =>
      json.encode(eventos.map<Map<String, dynamic>>((e) => e.toMap()).toList());

  static List<Evento> decode(String eventosJson) =>
      (json.decode(eventosJson) as List<dynamic>)
          .map<Evento>((item) => Evento.fromMap(item))
          .toList();
}
