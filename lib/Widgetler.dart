

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:password_manager/Sayfalar/Anasayfa.dart';
import 'package:password_manager/Sayfalar/SifreListesi.dart';



Widget buildTextField(TextEditingController controller,Icon icon,String text ){
  return   Padding(
    padding: const EdgeInsets.only(
        left: 15.0, right: 15.0),
    child: TextFormField(
      textInputAction: TextInputAction.next,
      controller: controller,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: icon,
        filled: true,
        fillColor:   controller.text == "" ?Color(0x36b1eeff):Color(0xff7d61b3),
        labelText: text,
        labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontStyle: FontStyle.italic),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white,),
        ),
        contentPadding: EdgeInsets.all(20),

      ),
    ),
  );
}

Widget buildNot(TextEditingController controller,double height){
  return  Padding(
    padding: const EdgeInsets.all(9.0),
    child: Container(
      color: controller.text == "" ?Color(0x36b1eeff):Color(0xff7d61b3),
      height: height,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 15.0, right: 15.0),
        child: TextFormField(
          controller: controller,
          cursorColor: Colors.black,
          style: TextStyle(color: Colors.white),

          maxLines: null,
          decoration: InputDecoration(
            labelText: "Not",
            labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontStyle: FontStyle.italic),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(20),
          ),
        ),
      ),
    ),
  );
}
/////////////////////////////////////////////////////////////////////////////

Widget buildNewButton(String text,void Function()? onPressed,){

  final backgroundColor = MaterialStateColor.resolveWith((states) =>
  states.contains(MaterialState.pressed) ? Colors.blueAccent : Colors.black);

  return SizedBox(
    width: 150,
    height: 50,
    child: ElevatedButton(
      style: ButtonStyle(backgroundColor: backgroundColor),

      child: Text(text,textAlign: TextAlign.center,),


      onPressed: onPressed,
    ),
  );
}






//Batom Navigation bar
Widget bottomNavigationBar(String sayfa){

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color:  Color(0x727d61b3),//Color(0x51eff5ff),
        ),
        width:  double.infinity,
        padding: EdgeInsets.symmetric(vertical: 9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [


            buildNavIcon(iconData: Icons.home_filled, active: sayfa == "Anasayfa", go: Anasayfa(), text: 'Anasayfa',),

            const SizedBox(
              height: 40,
              child: VerticalDivider(
                thickness: 2,
                width: 20,
                color: Colors.black,
              ),
            ),
            buildNavIcon(iconData: Icons.list_outlined, active: sayfa == "Liste", go: SifreListesi(), text: 'Şifreler',),




          ],
        ),
      ),
    ),
  );
}


class  buildNavIcon extends StatelessWidget {

  IconData iconData;
  bool active;
  Widget go;
  String text;

  buildNavIcon({required this.iconData,required this.active,required this.go,required this.text});


  @override
  Widget build(BuildContext context) {
    return
      Container(
        decoration: BoxDecoration(
          color: active ?Color(0xff7b61b3):Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: IconButton(onPressed: (){

          Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: go));

          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return go;}));
        }, icon: Icon(iconData,
            size: 30, color: Color(active ? 0XFFDBDDE2F5 : 0xff0a1034)),
        ),

        //Text(active ? text: "",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)

      );

  }
}




/////////////////////////////////////////////////////////////////////
buildAppbar(IconData icon, String baslik, String icerikBaslik, String icerik, BuildContext context) {
  Size size = MediaQuery.of(context).size;

  Future<bool> geriDonusTusu(BuildContext context) async{
    return true;
  }

  return WillPopScope(

    onWillPop: ()=> geriDonusTusu(context),
    child: Stack(
      children: [
        Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.only(top: 10.0, left: 14.0, right: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.keyboard_backspace_outlined,
                      size: 35.0,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 17.0),
                    child: Text(
                      baslik,
                      style: GoogleFonts.patrickHand(
                        color: Colors.white,
                        fontSize: 35,
                      ),
                    ),
                  ),
                  Spacer(),
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
                                title: Text(icerikBaslik),
                                content: Text(
                                    icerik),
                                backgroundColor: Colors.blue[100],
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
                                      primary: Colors.blue[100],
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
      ],
    ),
  );
}














