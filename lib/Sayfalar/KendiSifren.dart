
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/Sayfalar/SifreListesi.dart';
import 'package:password_manager/SifreVeVeritabaniSayfalari/TumSifrelerdao.dart';
import 'package:password_manager/Widgetler.dart';


class KendiSifren extends StatefulWidget {

  @override
  State<KendiSifren> createState() => _KendiSifrenState();
}

class _KendiSifrenState extends State<KendiSifren> {
  var s_b = TextEditingController();
  var s_k_a = TextEditingController();
  var s_s = TextEditingController();
  var s_n = TextEditingController();

  //Sifre ekle
  Future<void> ekle(String s_baslik, String s_kullanici_adi, String s_sifre, String s_not)  async{
    await TumSifrelerdao().sifreEkle(s_baslik, s_kullanici_adi, s_sifre, s_not);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SifreListesi()));
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return
      Material(
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [

              //Arkaplan image
              Positioned(
                child: Image.asset("resimler/arkaplan.png",
                  color: Color(0xE2EEF3F2).withOpacity(0.9), colorBlendMode: BlendMode.modulate,),
                width: size.width,
              ),

              //Appbar
              buildAppbar(CupertinoIcons.back,"Kendin Oluştur", "Kendin Oluştur", "güzel", context),

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    buildTextField(s_b, Icon(Icons.title,), "Başlık Giriniz"),
                    SizedBox(height: 12,),

                    buildTextField(s_k_a, Icon(Icons.abc,), "Kullanıcı Adı Giriniz"),
                    SizedBox(height: 12,),

                    buildTextField(s_s, Icon(Icons.lock), "Şifre"),
                    SizedBox(height: 12,),

                    ///Not Rkle
                   buildNot(s_n, 200),

                    buildNewButton("Şifre Oluştur", () {   ekle(s_b.text, s_k_a.text, s_s.text, s_n.text); }),

                    bottomNavigationBar("Anasayfa"),

                  ],
                ),
              ),
            ],
          ),
        ),
      );

  }

}



