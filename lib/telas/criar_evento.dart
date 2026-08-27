import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controle/eventoController.dart';
import '../controle/usuarioController.dart';
import '../modelo/imagem_service.dart';

class CriarEvento extends StatefulWidget {
  const CriarEvento({super.key});

  @override
  State<CriarEvento> createState() => _CriarEventoState();
}

class _CriarEventoState extends State<CriarEvento> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController tecNome = TextEditingController();
  final TextEditingController tecLocal = TextEditingController();
  final TextEditingController tecData = TextEditingController();
  final TextEditingController tecDescricao = TextEditingController();
  final TextEditingController tecImagem = TextEditingController();

  String? _validacao(String? v) =>
      (v == null || v.isEmpty) ? 'Obrigatório' : null;

  String? _caminhoImagem;
  void escolherImagem() async {
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

  void salvarEvento() async {
    if (!_formKey.currentState!.validate()) return;
    final usuario = await UsuarioController.usuarioLogado();
    if (usuario == null) return;
    if (_caminhoImagem == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Escolha uma imagem.')));
      return;
    }
    int id = DateTime.now().millisecondsSinceEpoch;
    await EventoController.adicionarEvento(
      id,
      tecNome.text,
      tecLocal.text,
      tecData.text,
      tecDescricao.text,
      _caminhoImagem!,
      usuario.id,
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Criar Evento")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: tecNome,
                validator: _validacao,
                decoration: const InputDecoration(labelText: "Nome do Evento"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: tecLocal,
                validator: _validacao,
                decoration: const InputDecoration(labelText: "Local do Evento"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: tecData,
                validator: _validacao,
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
                validator: _validacao,
                decoration: const InputDecoration(
                  labelText: "Descrição do Evento",
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: escolherImagem,
                icon: const Icon(Icons.image),
                label: Text(
                  _caminhoImagem == null ? "Escolher imagem" : "Trocar imagem",
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: salvarEvento,
                child: const Text("Salvar Evento"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
