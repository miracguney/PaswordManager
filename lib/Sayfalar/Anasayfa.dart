import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/Sayfalar/KendiSifren.dart';
import 'package:password_manager/Sayfalar/RastgeleSifre.dart';
import 'package:password_manager/Widgetler.dart';


class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  //Drawer kullanımı için
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _globalKey,
      drawer: buildDrawer(),
      body: Material(
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [

              //Arkaplan resim
              Positioned(
                child: Image.asset("resimler/arkaplan.png",
                  color: Color(0xE2EEF3F2).withOpacity(0.9), colorBlendMode: BlendMode.modulate,),
                width: size.width,
              ),

              //Telefon resim
              Positioned(
                top: 40,
                right:-20,
                child:  Image.asset("resimler/telefon.png",),
                width:size.width/1.8,
              ),

              //Drawer
              Padding(
                padding: EdgeInsets.only(top: size.height/30.0, left:8.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: (){
                      _globalKey.currentState!.openDrawer();

                    },
                  ),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(height: 5,),

                  // İlk text
                  buildAnasayfaText(
                      ' Şifre Oluştur ',
                      Colors.white,
                      size.width/12, 8.0, 0, 8.0, 0),

                  SizedBox(height: 10,),

                  //İkinci text
                  buildAnasayfaText(
                      ' İster belirlediğiniz bir \n şifre oluşturun  \n istersenizde rastgele bir şifre oluşrurun',
                      Colors.white54,
                      size.width/22, 8.0, 8.0, 8.0, 8.0
                  ),

                  SizedBox(height: 25,),

                  //Sayfa geçiş Contaniner button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      buildContainer("resimler/kendiSifren.png",  "Kendi Şifren", KendiSifren(),context),

                      buildContainer("resimler/rastgeleSifre.png",  "Rastgele Şifre",RastgeleSifre(),context)

                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [     bottomNavigationBar("Anasayfa"),

                ],
              ),


            ],
          ),
        ),
      ),
    );
  }


}
//kendi Şifreni Oluşturma ve rastgele şifre oluşturma container
Widget buildContainer(String image, String textt , Widget go, BuildContext context){
  Size size = MediaQuery.of(context).size;
  return   GestureDetector(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => go));

    },
    child: Container(

      width: size.width/2.2,
      height: size.height/3,

      decoration: BoxDecoration(

          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0x5b7d61b3),

                Color(0x727d61b3),
              ]),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color:  Color(0xff603fbb),width:2 )
        //Color(0x9F3D416E),

      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: size.height/4,

          ),

          Text(
            textt,
            style: GoogleFonts.patrickHand(
              color: Colors.white70,
              fontSize: size.width/19,
            ),
            textAlign: TextAlign.center,
          ),

        ],
      ),
    ),
  );
}


Widget buildDrawer(){

  return Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
    child: Container(
      color:   Color(0xff7d61b3),
      child: ListView(


        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.all(19.0),
            child: DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [

                      Color(0xff8c48fa),
                      Color(0x727d61b3)

                    ]
                ),
              ),

              child:
              Text('Şifre Yöneticisi',
                style: GoogleFonts.patrickHand(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),



            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color(0x9E66EAEF),
                    width: 1,
                  )
              ),
              child: ListTile(
                title: const Text('Şifreler'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color(0x9E66EAEF),
                    width: 1,
                  )
              ),
              child: ListTile(
                title: const Text('Bize ulaş'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color(0x9E66EAEF),
                    width: 1,
                  )
              ),
              child: ListTile(
                title: const Text('Yardım'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ),
          ),

        ],
      ),
    ),
  );
}

Widget buildAnasayfaText(String text, Color color, double size, double left, double top, double right, double bottom){
  return  Padding(
    padding:  EdgeInsets.only(left: left,top: top,right: right,bottom: bottom),
    child: Text(
      text,
      style: GoogleFonts.inter(
          color: color,
          fontSize: size,
          fontWeight: FontWeight.bold
      ),
    ),
  );
}