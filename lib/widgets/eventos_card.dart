import 'package:flutter/material.dart';

class EventosCard extends StatelessWidget {
  final String nome;
  final String imagem;
  final String local;
  final String data;
  final String descricao;

  const EventosCard({
    super.key,
    required this.nome,
    required this.imagem,
    required this.local,
    required this.data,
    required this.descricao,
  });

  Widget _buildImagem() {
    if (imagem.isEmpty) {
      return Container(
        height: 200,
        width: double.infinity,
        color: Colors.grey.shade300,
        alignment: Alignment.center,
        child: const Icon(Icons.image_not_supported, size: 48),
      );
    }

    if (imagem.startsWith('assets/')) {
      return Image.asset(
        imagem,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }

    // imagens vindas da API são URLs (http/https) — funciona em qualquer plataforma, inclusive web
    return Image.network(
      imagem,
      height: 200,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        height: 200,
        width: double.infinity,
        color: Colors.grey.shade300,
        alignment: Alignment.center,
        child: const Icon(Icons.broken_image, size: 48),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImagem(),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nome,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text("Local: $local"),
                const SizedBox(height: 8),
                Text("Data e hora $data"),
                const SizedBox(height: 8),
                Text(descricao),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
