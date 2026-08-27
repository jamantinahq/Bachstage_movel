import 'dart:io';
import 'package:flutter/material.dart';

class EventosCard extends StatelessWidget {
  final String nome;
  final String imagem;
  final String local;
  final String data;
  final String descricao;
  final VoidCallback? onEditar;
  final VoidCallback? onExcluir;
  final VoidCallback? onFavoritar;

  const EventosCard({
    super.key,
    required this.nome,
    required this.imagem,
    required this.local,
    required this.data,
    required this.descricao,
    this.onEditar,
    this.onExcluir,
    this.onFavoritar,
  });

  Widget _buildImagem() {
    if (imagem.startsWith('assets/')) {
      return Image.asset(
        imagem,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
    return Image.file(
      File(imagem),
      height: 200,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        height: 200,
        color: Colors.grey.shade300,
        child: const Icon(Icons.broken_image, size: 48),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 5,
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
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (onEditar != null)
                        IconButton(
                          onPressed: onEditar,
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.deepPurple,
                          ),
                        ),
                      if (onExcluir != null)
                        IconButton(
                          onPressed: onExcluir,
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      if (onEditar == null && onExcluir == null)
                        IconButton(
                          onPressed: onFavoritar,
                          icon: const Icon(Icons.favorite, color: Colors.red),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
