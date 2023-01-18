
import 'package:password_manager/SifreVeVeritabaniSayfalari/TumSifreler.dart';
import 'package:password_manager/SifreVeVeritabaniSayfalari/VeritabaniYardimcisi.dart';

class TumSifrelerdao {
  Future<List<TumSifreler>> tumSifreler() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM tumSifreler ORDER BY sifre_id DESC");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return TumSifreler(satir["sifre_id"], satir["s_baslik"], satir["s_kullanici_adi"], satir["s_sifre"], satir["s_not"] );
    });
  }


  //sifre ekler
  Future<void> sifreEkle(String s_baslik, String s_kullanici_adi, String s_sifre ,String s_not) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var bilgiler = Map<String, dynamic>();
    bilgiler["s_baslik"] = s_baslik;
    bilgiler["s_kullanici_adi"] = s_kullanici_adi;
    bilgiler["s_sifre"] = s_sifre;
    bilgiler["s_not"] = s_not;
    await db.insert("tumSifreler", bilgiler);
  }


  //sifre siler
  Future<void> sifreSil(int sifre_id) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("tumSifreler",where: "sifre_id=?",whereArgs: [sifre_id]);
  }


  //sifre güncelle
  Future<void> sifreGuncelle(int sifre_id,String s_baslik, String s_kullanici_adi, String s_sifre ,String s_not) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();


    var bilgiler = Map<String, dynamic>();
    bilgiler["s_baslik"] = s_baslik;
    bilgiler["s_kullanici_adi"] = s_kullanici_adi;
    bilgiler["s_sifre"] = s_sifre;
    bilgiler["s_not"] = s_not;
    await db.update("tumSifreler", bilgiler,where: "sifre_id=?",whereArgs: [sifre_id]);
  }


  //sifre arama
  Future<List<TumSifreler>> sifreArama(String aramaKelimesi) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM tumSifreler WHERE s_baslik like '%$aramaKelimesi%'");

    return List.generate(maps.length, (i){
      var satir = maps[i];
      return TumSifreler(satir["sifre_id"],satir["s_baslik"],satir["s_kullanici_adi"],satir["s_sifre"],satir["s_not"]);
    });
  }

}

