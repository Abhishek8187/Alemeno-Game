import 'package:abhishek_kannaujia/Provider/size_provider.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class SharePicture extends StatefulWidget {
  final XFile? image;
  SharePicture({Key? key, required this.image}) : super(key: key);

  @override
  State<SharePicture> createState() => _SharePictureState();
}

class _SharePictureState extends State<SharePicture> {
  @override
  Widget build(BuildContext context) {
    final sizeProvider = Provider.of<SizeIncrease>(context, listen: false);
    bool isSizeIncreased = false;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Flexible(
                  child: Column(
                    children: [
                      //****** backButton *****//
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 24, left: 24),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 50,
                                width: 50,
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
                                  color: const Color(0xFF3E8B3A),
                                ),
                                child: const Center(
                                    child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),

                      //****** animalImage *****//
                      Consumer<SizeIncrease>(builder: (context, value, child) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: SizedBox(
                            height: (0.2 * screenHeight)+sizeProvider.size,
                            width: (0.4 * screenWidth)+sizeProvider.size,
                            child: const Image(
                              image: AssetImage('images/Lion.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Image(image: AssetImage("images/fork.png")),

                            //****** camera *****//
                            ClipOval(
                              child: Container(
                                  height: (0.25 * screenHeight),
                                  width: (0.25 * screenHeight),
                                  decoration: BoxDecoration(
                                      //borderRadius: BorderRadius.circular(100)
                                      ),
                                  child: Image.file(
                                    File(widget.image!.path),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            const Image(image: AssetImage("images/Spoon.png")),
                          ],
                        ),
                      ),
                      Text(
                        "Will you eat this?",
                        style: TextStyle(
                            fontFamily: 'Andika',
                            fontWeight: FontWeight.w400,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: (){
                          if (!isSizeIncreased) {
                            sizeProvider.increaseSize();
                            isSizeIncreased = true;
                          }
                        },
                        child: Container(
                          height: 70,
                          width: 70,
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
                            color: const Color(0xFF3E8B3A),
                          ),
                          child: const Center(
                              child: Icon(
                            Icons.check,
                            color: Colors.white,
                                size: 40,
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
