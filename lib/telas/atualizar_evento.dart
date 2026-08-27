import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controle/eventoController.dart';
import '../modelo/classes/evento.dart';
import '../modelo/imagem_service.dart';

class AtualizarEvento extends StatefulWidget {
  final Evento evento;
  const AtualizarEvento({super.key, required this.evento});

  @override
  State<AtualizarEvento> createState() => _AtualizarEventoState();
}

class _AtualizarEventoState extends State<AtualizarEvento> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController tecNome;
  late final TextEditingController tecLocal;
  late final TextEditingController tecData;
  late final TextEditingController tecDescricao;
  late String _caminhoImagem;

  String? _obrigatorio(String? v) => (v == null || v.isEmpty) ? 'Obrigatório' : null;

  @override
  void initState() {
    super.initState();
    tecNome = TextEditingController(text: widget.evento.nome);
    tecLocal = TextEditingController(text: widget.evento.local);
    tecData = TextEditingController(text: widget.evento.data);
    tecDescricao = TextEditingController(text: widget.evento.descricao);
    _caminhoImagem = widget.evento.imagem;
  }

  void trocarImagem() async {
    final caminho = await ImagemService.escolherImagem();
    if (caminho != null) {
      setState(() {
        _caminhoImagem = caminho;
      });
    }
  }

  void escolherData() async {
    final dataEscolhida = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (dataEscolhida != null) {
      setState(() {
        tecData.text = DateFormat('dd/MM/yyyy').format(dataEscolhida);
      });
    }
  }

  void salvarEdicao() async {
    if (!_formKey.currentState!.validate()) return;
    await EventoController.atualizarEvento(
      widget.evento.id,
      tecNome.text,
      tecLocal.text,
      tecData.text,
      tecDescricao.text,
      _caminhoImagem,
      widget.evento.usuarioId,
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Editar Evento")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: tecNome,
                validator: _obrigatorio,
                decoration: const InputDecoration(labelText: "Nome do Evento"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: tecLocal,
                validator: _obrigatorio,
                decoration: const InputDecoration(labelText: "Local do Evento"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: tecData,
                validator: _obrigatorio,
                readOnly: true,
                onTap: escolherData,
                decoration: const InputDecoration(
                  labelText: "Data do Evento",
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: tecDescricao,
                validator: _obrigatorio,
                decoration: const InputDecoration(labelText: "Descrição do Evento"),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: trocarImagem,
                icon: const Icon(Icons.image),
                label: const Text("Trocar imagem"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: salvarEdicao,
                child: const Text("Salvar Alterações"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}