import 'package:bachstage_mobile/modelo/classes/evento.dart';
import 'package:bachstage_mobile/modelo/local_storage_service.dart';

class EventoController{

  static Future<void>adicionarEvento(int id,String nome,String local,String data,String descricao,String imagem,int usuarioId) async{ 
    List<Evento> lista =  await LocalStorageService.carregarEvento();
    lista.add(new Evento(id: id, nome: nome, local: local, data: data, descricao: descricao, imagem: imagem,usuarioId: usuarioId));
    await LocalStorageService.salvarEventos(lista);
  }
  static Future<void> deletarEvento(int id) async {
  List<Evento> lista =await LocalStorageService.carregarEvento();
  lista.removeWhere((evento) => evento.id == id);
  await LocalStorageService.salvarEventos(lista);
}

  static Future<void>atualizarEvento(int id,String nome,String local,String data,String descricao,String imagem,int usuarioId) async{
    List<Evento> lista =  await LocalStorageService.carregarEvento();
    int index = lista.indexWhere((evento) => evento.id == id);
    if(index != -1){
      lista[index] = new Evento(id: id, nome: nome, local: local, data: data, descricao: descricao, imagem: imagem,usuarioId: usuarioId);
      await LocalStorageService.salvarEventos(lista);
    }
}
  static Future<List<Evento>>listarEventos() async{
    List<Evento> lista =  await LocalStorageService.carregarEvento();
    return lista;
  }
  static Future<List<Evento>> listarMeusEventos(int usuarioId) async {
    List<Evento> lista = await LocalStorageService.carregarEvento();
    return lista.where((e) => e.usuarioId == usuarioId).toList();
  }
}
