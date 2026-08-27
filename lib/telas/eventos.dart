import 'package:flutter/material.dart';
import '../widgets/eventos_card.dart';
import '../modelo/classes/evento.dart';
import '../controle/eventoController.dart';
import '../controle/usuarioController.dart';
import '../controle/favoritosController.dart';

class Eventos extends StatefulWidget {
  const Eventos({super.key});

  @override
  State<Eventos> createState() => _EventosState();
}

class _EventosState extends State<Eventos> {
  List<Evento> _todosEventos = []; 
  List<Evento> _eventosFiltrados = []; 

  @override
  void initState() {
    super.initState();
    carregarEventos();
  }

  Future<void> carregarEventos() async {
    final eventos = await EventoController.listarEventos();
    setState(() {
      _todosEventos = eventos;
      _eventosFiltrados = eventos;
    });
  }

    Future<void> favoritarEvento(Evento evento) async {
    final usuario = await UsuarioController.usuarioLogado();
    if (usuario == null) return;

    final id = DateTime.now().millisecondsSinceEpoch;
    await FavoritosController.adicionarFavorito(id, usuario.id, evento.id);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Adicionado aos favoritos!")),
    );
  }

  void buscar(String termo) {
    setState(() {
      _eventosFiltrados = _todosEventos
          .where((e) => e.nome.toLowerCase().contains(termo.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Eventos")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Pesquisar evento...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onChanged: buscar,
            ),
          ),
          Expanded(
            child: _eventosFiltrados.isEmpty
                ? const Center(child: Text("Nenhum evento encontrado."))
                : ListView.builder(
                    itemCount: _eventosFiltrados.length,
                    itemBuilder: (context, index) {
                      final evento = _eventosFiltrados[index];
                      return EventosCard(
                        imagem: evento.imagem,
                        nome: evento.nome,
                        local: evento.local,
                        data: evento.data,
                        descricao: evento.descricao,
                        onFavoritar: () => favoritarEvento(evento),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}