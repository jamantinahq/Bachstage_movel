import 'dart:convert';

class favorito {
  final int id;
  final int idUsuario;
  final int idEvento;

  favorito({
    required this.id,
    required this.idUsuario,
    required this.idEvento,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idUsuario': idUsuario,
      'idEvento': idEvento,
    };
  }

  factory favorito.fromMap(Map<String, dynamic> map) {
    return favorito(
      id: map['id'],
      idUsuario: map['idUsuario'],
      idEvento: map['idEvento'],
    );
  }

  static String encode(List<favorito> favoritos) => json.encode(
        favoritos.map<Map<String, dynamic>>((e) => e.toMap()).toList(),
      );

  static List<favorito> decode(String favoritosJson) =>
      (json.decode(favoritosJson) as List<dynamic>)
          .map<favorito>((item) => favorito.fromMap(item))
          .toList();
}