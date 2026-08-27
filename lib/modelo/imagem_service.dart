import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImagemService{
  static Future<String?>escolherImagem ()async{
    final picker = ImagePicker();
    final XFile? imagemEscolhida = await picker.pickImage(source: ImageSource.gallery);
    if(imagemEscolhida == null)return null;
    final Directory pastaApp = await getApplicationDocumentsDirectory();
    final String nomeArquivo = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final String caminhoFinal = '${pastaApp.path}/$nomeArquivo';
    final File arquivoOriginal = File(imagemEscolhida.path);
    await arquivoOriginal.copy(caminhoFinal);
 
    return caminhoFinal;
  }

}