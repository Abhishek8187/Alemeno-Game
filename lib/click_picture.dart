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
      controller = CameraController(cameras![0], ResolutionPreset.max);
      //cameras[0] = first camera, change to 1 to another camera

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    }else{
      print("NO any camera found");
    }
  }

  void captureImage() async {
    try {
      final XFile? imageFile = await controller!.takePicture();

      // Do something with the captured imageFile, such as saving it or displaying it
      if (imageFile != null) {
        print('image clicked..........');
        // Handle the captured imageFile
        // For example, you can pass it to another screen or display it in an Image widget
        setState(() {
          image = imageFile;
        });
      }
    } catch (e) {
      // Handle any errors that occur during the image capture process
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
                       child: Icon(Icons.arrow_back,
                       color: Colors.white,
                       )
                     ),
                   ),
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
                decoration: const BoxDecoration(
                  color: Color(0xFFF4F4F4),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                ),
               child: Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         const Image(image: AssetImage("images/fork.png")),

                         //****** camera *****//
                         ClipOval(
                           child: Container(
                               height:200,
                               width:200,
                               decoration: BoxDecoration(
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
                         const Image(image: AssetImage("images/Spoon.png")),

                       ],
                     ),
                   ),
                   Text("Click your meal",
                     style: TextStyle(
                         fontFamily: 'Andika',
                         fontWeight: FontWeight.w400,
                         fontSize: 20
                     ),
                   ),
                   SizedBox(height: 20,),

                   GestureDetector(
                     onTap: (){
                       if(controller != null && controller!.value.isInitialized){
                         captureImage();
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
                           child: Icon(Icons.camera_alt,
                             color: Colors.white,
                           )
                       ),
                     ),
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
