import 'package:abhishek_kannaujia/click_picture.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: (0.8*screenHeight)),
              child: Center(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ClickPicture()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(
                            1.0,
                            5.0,
                          ),
                          blurRadius: 6.0,
                          spreadRadius: 2.0,
                        ), //BoxShadow//BoxShadow
                      ],
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xFF3E8B3A),
                    ),
                    width: (0.6*screenWidth),
                    height: (0.12*screenWidth),

                    child: const Center(
                      child: Text("Share your meal",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Andika',
                        fontWeight: FontWeight.w400,
                        fontSize: 20
                      ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
