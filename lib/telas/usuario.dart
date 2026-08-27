import 'package:flutter/material.dart';
import '../controle/usuarioController.dart';
import '../modelo/classes/usuario.dart';

class Perfil extends StatefulWidget  {
  const Perfil({super.key});

  @override
  State<Perfil>createState()=>_PerfilState();
  }
  class _PerfilState extends State<Perfil> {
  Usuario? _usuario;
  @override
  void initState() {
    super.initState();
    carregarUsuario();  
  }
  Future<void>carregarUsuario() async{
    final usuario = await UsuarioController.usuarioLogado();
    setState(() {
      _usuario=usuario;
    });
  }
  void _logout() async{
    await UsuarioController.logout();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meu Perfil")),
      body: _usuario == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  const SizedBox(height: 40),

            // foto
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.deepPurple.shade100,
              child: const Icon(
                Icons.person,
                size: 50,
                color: Colors.deepPurple,
              ),
            ),

            const SizedBox(height: 20),

            // nome
            Text(
              _usuario!.nome,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // email
            Text(
              _usuario!.email,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 15),
            // botao de sair
            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton(
                onPressed: _logout, 
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                   ),
                      ),
                      child: const Text(
                        "Sair da Conta",
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
