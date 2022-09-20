import 'package:filmler_app_sqlite/Kategoriler.dart';
import 'package:filmler_app_sqlite/VeritabaniYardimcisi.dart';

class Kategorilerdao{
  Future<List<Kategoriler>> tumKategoriler() async{
    // VERİ TABANINDAN KATEGORİLER ALINIR
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    
    
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kategoriler");
    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Kategoriler(satir["kategori_id"], satir["kategori_ad"]);
    });
  }
}