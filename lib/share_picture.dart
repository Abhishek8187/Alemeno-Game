import 'package:abhishek_kannaujia/Provider/size_provider.dart';
import 'package:abhishek_kannaujia/utils/round_button.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:fluttertoast/fluttertoast.dart';

class SharePicture extends StatefulWidget {
  final XFile? image;
  const SharePicture({Key? key, required this.image}) : super(key: key);

  @override
  State<SharePicture> createState() => _SharePictureState();
}

class _SharePictureState extends State<SharePicture> {
  @override
  Widget build(BuildContext context) {


    File file = File(widget.image!.path);  //****** converting XFile into File ***//
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
              Column(
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
                          child: RoundButton(height: 50, width: 50, icon: const Icon(Icons.arrow_back), size: 25,),
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
              Container(
                height: screenHeight*0.7,
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
                                  decoration: const BoxDecoration(
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
                      const Text(
                        "Will you eat this?",
                        style: TextStyle(
                            fontFamily: 'Andika',
                            fontWeight: FontWeight.w400,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () async{

                          // *** storing image on firebase storage *** //
                          if (!isSizeIncreased) {
                            sizeProvider.increaseSize();
                            isSizeIncreased = true;
                            Fluttertoast.showToast(
                                msg: "Thank you for sharing food with me!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,  //these all properties are working in mobile but not in emulator
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.black,
                                fontSize: 16.0
                            );
                            firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/image_${DateTime.now()}');
                            firebase_storage.UploadTask uploadTask = ref.putFile(file);
                            await Future.value(uploadTask);
                            print('snackbar showed');

                          }
                        },

                        // *****Tick button**** //
                        child: RoundButton(height: 70, width: 70, icon: const Icon(Icons.check), size: 40,),
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