import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/eventos_card.dart';
import '../modelo/classes/evento.dart';
import '../controle/eventoController.dart';
import '../controle/usuarioController.dart';

class Eventos extends StatefulWidget {
  const Eventos({super.key});

  @override
  State<Eventos> createState() => _EventosState();
}

class _EventosState extends State<Eventos> {
  List<Evento> _eventos = [];
  DateTime? _ultimaAtualizacao;
  bool _carregando = true;
  bool _semConexao = false;

  @override
  void initState() {
    super.initState();
    atualizar();
  }
  Future<void> atualizar() async {
    setState(() => _carregando = true);
    final tokenSalvo = await UsuarioController.tokenAtual();
    final sucesso = tokenSalvo != null ? await EventoController.baixarEventos(tokenSalvo) : false;
    final eventosLocais = await EventoController.listarEventos();
    final ultimaAtualizacao = await UsuarioController.ultimaAtualizacao();
    setState(() {
      _eventos = eventosLocais;
      _ultimaAtualizacao = ultimaAtualizacao;
      _carregando = false;
      _semConexao = !sucesso;
    });
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eventos"),
        actions: [
          IconButton(
            onPressed: atualizar,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_semConexao)
            Container(
              width: double.infinity,
              color: Colors.red.shade100,
              padding: const EdgeInsets.all(8),
              child: const Text(
                "Sem conexão com o servidor. Mostrando os últimos eventos salvos.",
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          if (_ultimaAtualizacao != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "Última atualização: ${DateFormat('dd/MM/yyyy HH:mm').format(_ultimaAtualizacao!)}",
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
          Expanded(
            child: _carregando
                ? const Center(child: CircularProgressIndicator())
                : _eventos.isEmpty
                    ? const Center(child: Text("Nenhum evento disponível."))
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
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}