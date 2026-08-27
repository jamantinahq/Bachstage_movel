import 'package:flutter/material.dart';
import '../widgets/eventos_card.dart';
import '../modelo/classes/evento.dart';
import '../controle/eventoController.dart';
import '../controle/usuarioController.dart';
import 'criar_evento.dart';
import 'atualizar_evento.dart';

class MeusEventos extends StatefulWidget{
  const MeusEventos({super.key});

 @override 
 State<MeusEventos> createState() => _MeusEventosState();
 }
 class _MeusEventosState extends State<MeusEventos> {
  List<Evento> _eventos = [];

  @override
  void initState() {
    super.initState();
    carregarMeusEventos();
  }

  Future<void>carregarMeusEventos() async {
    final usuario = await UsuarioController.usuarioLogado();
    if (usuario == null) {
      setState(() => _eventos = []);
      return;
    }
  
  final eventos = await EventoController.listarMeusEventos(usuario.id);
  setState(() {
      _eventos = eventos;
    });
  }

  void abrirTelaCriar() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CriarEvento()),
    );
    carregarMeusEventos();
  }

   void abrirTelaEditar(Evento evento) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AtualizarEvento(evento: evento)),
    );
    carregarMeusEventos();
  }

  Future<void> deletarEvento(int id) async {
  await EventoController.deletarEvento(id);
  await carregarMeusEventos();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meus Eventos")),
      floatingActionButton: FloatingActionButton(
        onPressed: abrirTelaCriar,
        child: const Icon(Icons.add),
      ),
      body: _eventos.isEmpty
          ? const Center(child: Text("Você ainda não criou nenhum evento."))
          : ListView.builder(
              itemCount: _eventos.length,
              itemBuilder: (context, index) {
                final evento = _eventos[index];
                return EventosCard(
                  imagem: evento.imagem,
                  nome: evento.nome,
                  local: evento.local,
                  data: evento.data,
                  descricao: evento.descricao,
                  onEditar: () => abrirTelaEditar(evento),
                  onExcluir: () async {await deletarEvento(evento.id);},
                );
              },
            ),
    );
  }
}
 