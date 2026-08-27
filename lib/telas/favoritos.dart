import 'package:bachstage_mobile/widgets/eventos_card.dart';
import 'package:flutter/material.dart';
import '../modelo/classes/evento.dart';
import '../modelo/classes/favorito.dart';
import '../controle/eventoController.dart';
import '../controle/favoritosController.dart';
import '../controle/usuarioController.dart';

class Favoritos extends StatefulWidget {
  const Favoritos({super.key});

  @override
  State<Favoritos> createState() => _FavoritosState();
}

class _FavoritosState extends State<Favoritos> {
  List<favorito> _favoritos = [];
  List<Evento> _todosEventos = [];

  @override
  void initState() {
    super.initState();
    carregarFavoritos();
  }

  Future<void> carregarFavoritos() async {
    final usuario = await UsuarioController.usuarioLogado();
    if (usuario == null) {
      setState(() {
        _favoritos = [];
        _todosEventos = [];
      });
      return;
    }

    final todosFavoritos = await FavoritosController.listarFavoritos();
    final eventos = await EventoController.listarEventos();

    setState(() {
      _favoritos = todosFavoritos
          .where((f) => f.idUsuario == usuario.id)
          .toList();
      _todosEventos = eventos;
    });
  }

  Evento? _buscarEvento(int idEvento) {
    for (Evento e in _todosEventos) {
      if (e.id == idEvento) return e;
    }
    return null;
  }

  void removerFavorito(int idFavorito) async {
    await FavoritosController.deletarFavorito(idFavorito);
    carregarFavoritos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: _favoritos.isEmpty
          ? const Center(child: Text("Você ainda não tem favoritos."))
          : ListView.builder(
              itemCount: _favoritos.length,
              itemBuilder: (context, index) {
                final fav = _favoritos[index];
                final evento = _buscarEvento(fav.idEvento);

                if (evento == null) return const SizedBox.shrink();

                return EventosCard(
                  imagem: evento.imagem,
                  nome: evento.nome,
                  local: evento.local,
                  data: evento.data,
                  descricao: evento.descricao,
                  onExcluir: () => removerFavorito(fav.id),
                );
              },
            ),
    );
  }
}
