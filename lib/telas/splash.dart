import 'package:flutter/material.dart';
import '../controle/usuarioController.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
//espera o tempo e apos isso leva para a tela de login
  @override
  State<Splash> createState() => _Contador();
}

class _Contador extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () async {
      await verificarLogin();
    });
  }
  Future <void>verificarLogin() async{
    final logado = await UsuarioController.verificaLoginOffline();
    if (logado) {
      Navigator.pushReplacementNamed(context, '/principal');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //imagem da logo
          children: [
            Image.asset(
              'assets/images/bachstage_logo2-Photoroom.png',
              width: 180,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
