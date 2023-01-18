
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/Sayfalar/SifreListesi.dart';
import 'package:password_manager/SifreVeVeritabaniSayfalari/TumSifreler.dart';
import 'package:password_manager/SifreVeVeritabaniSayfalari/TumSifrelerdao.dart';
import 'package:password_manager/Widgetler.dart';

class DetaySayfasi extends StatefulWidget {


  TumSifreler sifre;


  DetaySayfasi({required this.sifre});


  @override
  State<DetaySayfasi> createState() => _DetaySayfasiState();
}

class _DetaySayfasiState extends State<DetaySayfasi> {

  var s_b = TextEditingController();
  var s_k_a = TextEditingController();
  var s_s = TextEditingController();
  var s_n = TextEditingController();




  @override
  void initState() {
    super.initState();
    var sifre = widget.sifre;
    s_b.text = sifre.s_baslik;
    s_k_a.text = sifre.s_kullanici_adi;
    s_s.text = sifre.s_sifre;
    s_n.text= sifre.s_not;
  }

  @override
  Widget build(BuildContext context) {




    Size size = MediaQuery.of(context).size;

    ///kisi güncelle

    Future<void> sifreGuncelle(int sifre_id,String s_baslik,String s_kullanici_adi,String s_sifre, String s_not) async{
      await TumSifrelerdao().sifreGuncelle(sifre_id, s_baslik, s_kullanici_adi,s_sifre,s_not);

      Navigator.push(context, MaterialPageRoute(builder: (context) => SifreListesi()));
    }

    return  Scaffold(
      resizeToAvoidBottomInset: false,

      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            //arkaplan image
            Positioned(
              child: Image.asset("resimler/arkaplan.png",),
              width: size.width,

            ),

            //apbar
            buildAppbar(CupertinoIcons.back,"Otomatik Şifre", "Otomatik Şifre", "güzel", context),



            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //Baslik
                SizedBox(height: 110,),
                buildTextField(s_b, Icon(Icons.title,), "Başlık"),

                // kullanici adi
                SizedBox(height: 10,),
                buildTextField(s_k_a, Icon(Icons.abc,), "Kullacıcı Adı"),

                // sifre
                SizedBox(height: 10,),
                buildTextField(s_s, Icon(Icons.lock,), "Şifre"),

                //not ekle pad 9 altp lr 15
                SizedBox(height: 10,),
                buildNot(s_n, 160),

                SizedBox(height: 10,),
                buildNewButton(
                "Güncelle",
                () {
                  sifreGuncelle(widget.sifre.sifre_id, s_b.text,s_k_a.text, s_s.text,s_n.text);
                }),

                Spacer(),
                bottomNavigationBar("Liste"),
              ],
            ),

          ],
        ),
      ),

    );
  }
}
