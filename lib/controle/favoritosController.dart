import 'package:bachstage_mobile/modelo/classes/favorito.dart';
import 'package:bachstage_mobile/modelo/local_storage_service.dart';

class FavoritosController{
  static Future<void>adicionarFavorito(int id,int idUsuario,int idEvento) async{
     List<favorito> lista = await LocalStorageService.carregarFavoritos();
     bool verificacao = lista.any((favorito) => favorito.idEvento == idEvento && favorito.idUsuario == idUsuario);
     if (!verificacao){
     lista.add(new favorito(id: id, idUsuario: idUsuario, idEvento: idEvento));
     await LocalStorageService.salvarFavoritos(lista);
     }
  }
  static Future<void>deletarFavorito(int id) async{ 
  List<favorito> lista = await LocalStorageService.carregarFavoritos(); 
  lista.removeWhere((favorito) => favorito.id == id);
  await LocalStorageService.salvarFavoritos(lista);
}
  static Future<List<favorito>>listarFavoritos() async{
    List<favorito> lista = await LocalStorageService.carregarFavoritos();
    return lista;
  }
}