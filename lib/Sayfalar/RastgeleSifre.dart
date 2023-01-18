import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:counter_button/counter_button.dart';
import 'package:password_manager/Sayfalar/KendiSifren.dart';
import 'package:password_manager/Sayfalar/SifreListesi.dart';
import 'package:password_manager/SifreVeVeritabaniSayfalari/TumSifrelerdao.dart';
import 'package:password_manager/Widgetler.dart';

class RastgeleSifre extends StatefulWidget {
  const RastgeleSifre({Key? key}) : super(key: key);

  @override
  State<RastgeleSifre> createState() => _RastgeleSifreState();
}

class _RastgeleSifreState extends State<RastgeleSifre> {






  final s_rastgele = TextEditingController();

  @override
  void dispose() {
    s_rastgele.dispose();
    super.dispose();
  }



  //Rastgele şifre oluşturma

  String generatePassword({
    bool hasLetter = true,
    bool hasLetters = true,
    bool hasNumbers = true,
    bool hasSpecial = true,
  }){
    final length = _RastgeleSifreState.newLength;
    final lettersLowercase = 'abcdefghıjklmnopqrstuvwxzy';
    final lettersUppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final numbers = '0123456789';
    final special = '@#=+!£\$%&?(){}';

    String chars = '';
    if (hasLetter) chars += '$lettersUppercase';
    if (hasLetters) chars += '$lettersLowercase';
    if (hasNumbers)chars += '$numbers';
    if (hasSpecial)chars += '$special';
    else null;

    return List.generate(length, (index){
      final indexRandom = Random.secure().nextInt(chars.length);

      return chars[indexRandom];
    }).join('');
  }

  static bool buyukHarf = true;
  static bool kucukHarf = true;
  static bool numara = true;
  static bool sembol = true;

  var tf = TextEditingController();

  static int newLength = 8;

  int _counterValue = 8;

  Future<void> ekle(String s_baslik, String s_kullanici_adi, String s_sifre, String s_not)  async{
    await TumSifrelerdao().sifreEkle(s_baslik,s_kullanici_adi,s_sifre,s_not);


    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SifreListesi()));
  }

  var s_b = TextEditingController();
  var s_k_a = TextEditingController();
  var s_n = TextEditingController();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfde6edf3),
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [

              // Arkaplan image
              Positioned(
                child: Image.asset("resimler/arkaplan.png",),
                width: size.width,

              ),

              buildAppbar(CupertinoIcons.back,"Otomatik Şifre", "Otomatik Şifre", "güzel", context),

              Column(

                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //Başlık Text
                  SizedBox(
                    height: 50,
                  ),
                  buildTextField(s_b,  Icon(Icons.title,), "Başlık Giriniz"),


                  //Kullanıcı Adı
                  SizedBox(
                    height: 10,
                  ),
                  buildTextField(s_k_a, Icon(Icons.abc,), "Kullanıcı Adı Giriniz"),


                  //Not ekle burada ayar yapılacak pading all 9 height 100 altpad 15 lr
                  SizedBox(height: 1,),
                  buildNot(s_n, 100),


                  //checkbox buyuk kucuk
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildCheckBox("Büyük Harf",buyukHarf,(bool? veri) {setState(() {print("j h $veri");buyukHarf=veri!;});}),
                      buildCheckBox("Küçük Harf",kucukHarf,(bool? veri) {setState(() {print("j h $veri");kucukHarf=veri!;});}),

                    ],
                  ),
                  SizedBox(height: 10,),

                  //checkbox sembol numara
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildCheckBox("Sembol",sembol,(bool? veri) {setState(() {print("j h $veri");sembol=veri!;});}),
                      buildCheckBox("Numara",numara,(bool? veri) {setState(() {print("j h $veri");numara=veri!;});}),
                    ],
                  ),
                  SizedBox(height: 12,),

                  //Rastgele sifre
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        //karakter Sayısı
                        Container(
                          color: Color(0x36b1eeff),
                          child: SizedBox(
                            height: 58,
                            child: CounterButton(
                              loading: false,
                              onChange: (int val) {
                                setState(() {
                                  _counterValue = val;
                                  newLength = _counterValue;
                                });
                              },
                              count: _counterValue,
                              countColor: Colors.white,
                              buttonColor: Colors.white,
                              progressColor: Colors.white,

                            ),
                          ),
                        ),

                        //rastgele sifre
                        SizedBox(
                          width: size.width/1.5,
                          child: TextField(
                            controller: s_rastgele,
                            readOnly: true,
                            enableInteractiveSelection: false,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock,),
                                filled: true,
                                fillColor:Color(0x36b1eeff),
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.copy),
                                  onPressed: (){
                                    final data = ClipboardData(text: s_rastgele.text);
                                    Clipboard.setData(data);

                                    final snackBar = SnackBar(content: Text(
                                      '✓ Şifre Kopyalandı',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                      backgroundColor: Colors.pinkAccent,);
                                    ScaffoldMessenger.of(context)
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(snackBar);
                                  },
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4,),

                  ///Button
                  buildButton(),
                  SizedBox(height: 4,),

                  bottomNavigationBar("Anasayfa"),

                ],
              ),
            ],
          ),
        )

    );
  }

  Widget buildCheckBox(String text,bool filtre,void Function(bool?)? onChanged,){
    return Container(


      width: 140,
      height: 60,
      color: filtre==false ? Color(0x36b1eeff):Color(0xff7d61b3),
      child: CheckboxListTile(

          title: Text(text,style: TextStyle(color: Colors.white,fontSize: 14),),
          value: filtre,//unchecked
          controlAffinity: ListTileControlAffinity.platform,
          onChanged: onChanged
      ),
    );
  }

  Widget buildButton(){



    final backgroundColor = MaterialStateColor.resolveWith((states) =>
    states.contains(MaterialState.pressed) ? Colors.blueAccent : Colors.black);
    return

      buyukHarf ==false && kucukHarf ==false && sembol ==false && numara ==false
          ? ElevatedButton(
        style:  ElevatedButton.styleFrom(
            primary:Color(0x16b1eeff)
        ),
        child: Text("Şifre Oluştur",style: TextStyle(color: Color(0x37FFFFFF)),),
        onPressed: (){

        },
      )
          : buildNewButton(
           "Şifre Oluştur",
            () {
              final password = generatePassword(hasLetter: buyukHarf,hasLetters: kucukHarf,hasSpecial: sembol,hasNumbers: numara);
              s_rastgele.text = password;
              ekle(s_b.text,s_k_a.text,s_rastgele.text,s_n.text);
            });

  }
}

