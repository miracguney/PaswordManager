import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/Sayfalar/DetaySayfasi.dart';
import 'package:password_manager/SifreVeVeritabaniSayfalari/TumSifreler.dart';
import 'package:password_manager/SifreVeVeritabaniSayfalari/TumSifrelerdao.dart';
import 'package:password_manager/Widgetler.dart';

class SifreListesi extends StatefulWidget {
  const SifreListesi({Key? key}) : super(key: key);

  @override
  State<SifreListesi> createState() => _SifreListesiState();
}

class _SifreListesiState extends State<SifreListesi> {

  bool aramaYapiliyormu = false;
  String aramaKelimesi = "";


  Future<List<TumSifreler>> sifreleriGoster()  async{
    var sifrelerListesi = await TumSifrelerdao().tumSifreler();

    return sifrelerListesi;
  }

  //Sifre arama
  Future<List<TumSifreler>> aramaYap(String aramaKelimesi)  async{
    var sifrelerListesi = await TumSifrelerdao().sifreArama(aramaKelimesi);

    return sifrelerListesi;
  }

  //Sifre ekleme
  Future<void> ekle(String s_baslik, String s_kullanici_adi, String s_sifre, String s_not)  async{
    await TumSifrelerdao().sifreEkle(s_baslik, s_kullanici_adi, s_sifre, s_not);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SifreListesi()));
  }

  //Şifre guncelle
  Future<void> sifreGuncelle(int sifre_id,String s_baslik, String s_kullanici_adi, String s_sifre, String s_not) async{
    await TumSifrelerdao().sifreGuncelle(sifre_id, s_baslik, s_kullanici_adi, s_sifre, s_not);

    Navigator.push(context, MaterialPageRoute(builder: (context) => SifreListesi()));
  }


  //kisi sil
  Future<void> sifreSil(int sifre_id) async{
    await TumSifrelerdao().sifreSil(sifre_id);
    setState(() {

    });
  }


  @override
  void initState() {
    super.initState();

    //guncelle();
    //sil();
    //ekle();
    sifreleriGoster();
    //aramaYap();


  }
  bool  gozIcon = false;
  bool isExpanded = false;

  bool visibility1 =true;
  bool visibility2 =false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Material(
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [

              //arkaplan
              Positioned(

                child: Image.asset("resimler/arkaplan.png"),
                width: size.width,
              ),


              //apbar
              Stack(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 20.0, right: 14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Spacer(),
                        aramaYapiliyormu
                            ? SizedBox(
                          width: size.width/3,
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                              autofocus: true,
                              decoration: InputDecoration(hintText: "Arama",
                                hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                                fillColor: Colors.blue,
                              ),
                              cursorColor: Colors.white,
                              onChanged: (aramaSonucu){
                                print("Arama Sonucu $aramaSonucu");
                                setState(() {
                                  aramaKelimesi = aramaSonucu;
                                });
                              }
                          ),
                        )
                            : Text(
                          "Şifreler",
                          style: GoogleFonts.patrickHand(
                              color: Colors.white,
                              fontSize: 35
                          ),
                        ),

                        Spacer(),
                        aramaYapiliyormu
                            ? IconButton(
                            icon: Icon(Icons.cancel,size: 25,color: Colors.white,),
                            onPressed: (){
                              setState(() {
                                aramaYapiliyormu = false;
                                aramaKelimesi = "";
                              });
                            }
                        )
                            : IconButton(
                            icon: Icon(Icons.search,size: 25,color: Colors.white,),
                            onPressed: (){
                              setState(() {
                                aramaYapiliyormu = true;
                              });
                            }
                        ),

                        //goz icon
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              setState((){
                                gozIcon = !gozIcon;
                              });

                            },
                            child: Icon(
                              gozIcon
                                  ? Icons.visibility_off
                                  : Icons.visibility
                              ,size: 25,color: Colors.white,),
                          ),
                        ),

                        //bilgilendirme
                        IconButton(
                            icon: Icon(
                              Icons.info_outline,
                              size: 35,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)),
                                      title: Text("Şifreler"),
                                      content: Text(
                                          " güzel"),
                                      backgroundColor: Color(0xFF1194EE),
                                      actions: [
                                        ElevatedButton(
                                          child: Text("Tamam"),
                                          style: ElevatedButton.styleFrom(
                                            side: BorderSide(
                                                width: 2, color: Colors.black),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(16)),
                                            onSurface: Colors.blueAccent,
                                            elevation: 4,
                                            shadowColor: Colors.black,
                                            primary: Color(0x4A083C5F),
                                            onPrimary: Colors.black,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  });
                            }),
                      ],
                    ),
                  ),
                ],
              ),

              //Liste
              FutureBuilder<List<TumSifreler>>(
                  future: aramaYapiliyormu ? aramaYap(aramaKelimesi) : sifreleriGoster(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      var sifrelerListesi = snapshot.data;
                      return Padding(
                        padding: EdgeInsets.only(top:size.height/6.5,bottom: size.height/9, ),
                        child:
                        Stack(
                          children: [

                            //Sifre yoksa resim ve yazı görünür
                            Visibility(
                              visible:  sifrelerListesi!.isEmpty ? visibility1:visibility2,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 17.0),
                                    child: Positioned(
                                      child: Image.asset("resimler/security.png",color: Color(
                                          0xffa83dea).withOpacity(0.8),),//Image.asset("resimler/randombg1.png",),
                                      width: size.width,
                                    ),
                                  ),
                                  Text("Kayıtlı şifre bulunmamaktadır",
                                    style: GoogleFonts.patrickHand(
                                      color: Colors.white54,
                                      fontSize: size.width/19,
                                    ),)
                                ],
                              ),
                            ),


                            ListView.builder(
                              itemCount: sifrelerListesi?.length,
                              itemBuilder: (context, indeks) {
                                var sifre = sifrelerListesi![indeks];

                                return Slidable(
                                  key:Key('$sifre'),
                                  endActionPane: ActionPane(motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context){
                                            setState(() {
                                              sifreSil(sifre.sifre_id);
                                              final snackBar = SnackBar(content: Text(
                                                '✓ Şifre Silindi',
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                                backgroundColor: Colors.pinkAccent,
                                                action: SnackBarAction(
                                                  textColor: Colors.blue,
                                                  label: "Geri al",
                                                  onPressed: (){
                                                    ekle(sifre.s_baslik, sifre.s_kullanici_adi, sifre.s_sifre, sifre.s_not);

                                                    setState(() { });
                                                  },
                                                ),
                                              );
                                              ScaffoldMessenger.of(context)
                                                ..removeCurrentSnackBar()
                                                ..showSnackBar(snackBar);


                                            });
                                          },
                                          backgroundColor: Color(0x72cd38a3),
                                          icon: Icons.delete,
                                        )
                                      ]),
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfasi(sifre: sifre)));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                      child: Card(
                                        color:  Color(0x727d61b3),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(50),bottomLeft: Radius.circular(50)),
                                            side: BorderSide(width: 1, color: Color(0x977c2cfd),
                                            )),
                                        child: SizedBox(
                                          height: 100,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              //baslik
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: CircleAvatar(
                                                  child: Text(
                                                    sifre.s_baslik.length== 0 ? "": "${sifre.s_baslik[0].toUpperCase()}",
                                                     // "${sifre.s_baslik[0].toUpperCase()}",//"${indeks + 1}",   sifre.title.length< 0 ?    : "${sifre.title[0].toUpperCase()}",//
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: size.width/18,
                                                        color: Colors.white),
                                                  ),
                                                  backgroundColor: Color(0x97121F2F),//Colors.transparent,
                                                ),
                                              ),

                                              VerticalDivider(color: Colors.blue,thickness: 2,indent: 20,endIndent: 20,),

                                              //sifre
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: Column(

                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [

                                                    //Baslık uzunluğu kontrolu
                                                    sifre.s_baslik.length > 15
                                                        ? Padding(
                                                      padding: const EdgeInsets.only(left: 0, right: 20.0, top: 8.0, bottom: 8.0),
                                                      child: Text(
                                                        "${sifre.s_baslik.substring(0,15)}...",
                                                        style: GoogleFonts.patrickHand(
                                                            color: Colors.blueAccent,
                                                            fontSize: size.width/17,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                    )
                                                        : Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 0,
                                                          right: 20.0,
                                                          top: 8.0,
                                                          bottom: 8.0),
                                                      child: Text(
                                                        "${sifre.s_baslik}",

                                                        style: GoogleFonts.patrickHand(
                                                            color: Colors.blueAccent,
                                                            fontSize: size.width/17,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                    ),


                                                    //kullanici adi uzunluğu kontrolu
                                                    sifre.s_sifre.length > 15
                                                        ? Padding(
                                                      padding: const EdgeInsets.only(left: 2.0, right: 20.0, top: 8.0, bottom: 8.0),
                                                      child: Text(
                                                        gozIcon  ?
                                                        "${sifre.s_sifre.substring(0,15)}...":'${"${sifre.s_sifre}".replaceAll(RegExp(r"."), "*").substring(0,15)}',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: size.width/27,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    )
                                                        : Padding(
                                                      padding: const EdgeInsets.only(left: 2.0, right: 20.0, top: 8.0, bottom: 8.0),
                                                      child: Text(
                                                        gozIcon  ?
                                                        "${sifre.s_sifre }":'${"${sifre.s_sifre}".replaceAll(RegExp(r"."), "*")}',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: size.width/27,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Spacer(),

                                              //sifre kopyalama
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: IconButton(
                                                  icon: Icon(Icons.copy,color: Colors.white,),
                                                  onPressed: (){
                                                    final data = ClipboardData(text: sifre.s_sifre);
                                                    Clipboard.setData(data);

                                                    final snackBar = SnackBar(content: Text(
                                                      '✓ Şifre Kopyalandı',
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                      backgroundColor: Colors.pinkAccent,


                                                    );
                                                    ScaffoldMessenger.of(context)
                                                      ..removeCurrentSnackBar()
                                                      ..showSnackBar(snackBar);
                                                  },
                                                ),
                                              )

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),


                          ],
                        ),

                      );

                    }else
                      return Center();
                  }
              ),
              Container(
                child: Column(
                  children: [
                    Spacer(),
                    bottomNavigationBar("Liste"),
                  ],
                ),
              )
            ],
          ),

        ),

      ),
    );
  }
}
