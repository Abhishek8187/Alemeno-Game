import 'package:abhishek_kannaujia/Screens/share_picture.dart';
import 'package:abhishek_kannaujia/utils/round_button.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class ClickPicture extends StatefulWidget {
  const ClickPicture({Key? key}) : super(key: key);

  @override
  State<ClickPicture> createState() => _ClickPictureState();
}



class _ClickPictureState extends State<ClickPicture> {

  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image; //for captured image

  @override
  void initState() {
    loadCamera();
    super.initState();
  }

  loadCamera() async {
    cameras = await availableCameras();
    if(cameras != null){
      controller = CameraController(cameras![0], ResolutionPreset.max, enableAudio: false);
      //cameras[0] = first camera, change to 1 to another camera

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    }else{
      print("No camera found");
    }
  }

  void captureImage() async {
    try {
      final XFile? imageFile = await controller!.takePicture();

      // *** passing the clicked image to next screen *** //
      if (imageFile != null) {
        print('image clicked..........');
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SharePicture(image: imageFile)));
        setState(() {
          image = imageFile;
        });
      }
    } catch (e) {
      // *** errors that occur during the image capture process ** //
      print('Error capturing image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
         children: [

           //****** backButton *****//
           Row(
             children: [
               Padding(
                 padding: const EdgeInsets.only(top: 24, left: 24),
                 child: InkWell(
                   onTap: (){
                     Navigator.pop(context);
                   },
                   child: RoundButton(height: 50, width: 50, icon: const Icon(Icons.arrow_back), size: 25,),
                 ),
               ),
             ],
           ),


           //****** animalImage *****//
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 20),
             child: SizedBox(
               height: (0.2*screenHeight),
                width: (0.2*screenHeight),
                child: const Image(image: AssetImage('images/Lion.png'),),
             ),
           ),

           //****** cameraPreview *****//
           Expanded(
             child: Container(
               width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF4F4F4),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                ),
               child: Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                     child: Stack(
                       children:[
                          Positioned(
                             left: 0,
                             top: (0.04*screenHeight),
                             child:  Image(image: AssetImage("images/fork.png"))),
                          Positioned(
                             top: (0.007*screenHeight),
                             left: (0.09*screenWidth),
                             child: Image(image: AssetImage("images/horizontalLine.png"),)),
                           Positioned(
                              top: (0.007*screenHeight),
                              left: (0.09*screenWidth),
                              child: Image(image: AssetImage("images/verticalLine.png"),)),


                          Positioned(
                             bottom: (0.007*screenHeight),
                             left: (0.09*screenWidth),
                             child: Image(image: AssetImage("images/horizontalLine.png"),)),
                          Positioned(
                              bottom: (0.007*screenHeight),
                              left: (0.09*screenWidth),
                             child: Image(image: AssetImage("images/verticalLine.png"),)),


                          Positioned(
                             top: (0.007*screenHeight),
                             right: (0.09*screenWidth),
                             child: Image(image: AssetImage("images/verticalLine.png"),)),
                          Positioned(
                              top: (0.007*screenHeight),
                              right: (0.09*screenWidth),
                             child: Image(image: AssetImage("images/horizontalLine.png"),)),

                          Positioned(
                             bottom: (0.007*screenHeight),
                             right: (0.09*screenWidth),
                             child: Image(image: AssetImage("images/verticalLine.png"),)),
                          Positioned(
                             bottom: (0.007*screenHeight),
                             right: (0.09*screenWidth),
                             child: Image(image: AssetImage("images/horizontalLine.png"),)),


                         //****** CAMERA *****//
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 50),
                           child: ClipOval(
                             child: Container(
                                 height:(0.25*screenHeight),
                                 width:(0.25*screenHeight),
                                 decoration: const BoxDecoration(
                                   // borderRadius: BorderRadius.circular(100)
                                 ),
                                 child: controller == null?
                                 const Center(child:Text("Loading Camera...")):
                                 !controller!.value.isInitialized?
                                 const Center(
                                   child: CircularProgressIndicator(),
                                 ):
                                 CameraPreview(controller!)
                             ),
                           ),
                         ),
                         const Positioned(
                             right: 0,
                             top: 30,
                             child: Image(image: AssetImage("images/Spoon.png"))),
                       ]
                     ),
                   ),
                   const Text("Click your meal",
                     style: TextStyle(
                         fontFamily: 'Andika',
                         fontWeight: FontWeight.w400,
                         fontSize: 20
                     ),
                   ),
                   const SizedBox(height: 20,),

                   // *** CAMERA BUTTON *** ///
                   GestureDetector(
                     onTap: (){
                       if(controller != null && controller!.value.isInitialized){
                         captureImage();
                       }
                     },
                     child: RoundButton(height: 70, width: 70, icon: const Icon(Icons.camera_alt), size: 30,)
                   ),
                 ],
               ),
             ),
           )
         ],
        ),
      ),
    );
  }
}


