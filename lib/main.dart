

import 'dart:io';

import 'package:face_detection/face_detection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main(){
  return runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FaceDetectorApp(),

    );
  }
}
class FaceDetectorApp extends StatefulWidget {
  const FaceDetectorApp({Key? key}) : super(key: key);

  @override
  _FaceDetectorAppState createState() => _FaceDetectorAppState();
}

class _FaceDetectorAppState extends State<FaceDetectorApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Center(child: Text('Face Detection'))
      ),
      body: Container(
        child: Column(
          children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text('Pick Image'),

            ],
          ),
            buttons(context)
        ]),
      ),
    );
  }
  Widget text(String textToWrite){
    return Padding(
        padding: EdgeInsets.all(30),
      child: Text(textToWrite, style: TextStyle(fontSize: 22),),
    );
  }
  Widget buttons(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          createButton('Camera'),
          createButton('Gallery')
    ]
    );
  }

  Widget createButton(String btnName){
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ElevatedButton(
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.blueGrey)
            ),
            onPressed: (){},
            child: Text(btnName)),

    );
  }

  onPickImageSelected(String source)async{
    ImageSource imageSource;
    if(source == 'Camera'){
      imageSource = ImageSource.camera;
    }else{
      imageSource = ImageSource.gallery;
    }
    final scaffold = _scaffoldKey.currentState;
    try{
      ImagePicker picker = ImagePicker();
      final file = picker.pickImage(source: imageSource);
      if(file == null){
        throw Exception('File is not available ');
      }
      Navigator.push(context, MaterialPageRoute(builder: (_) => FaceDetection(file as File) ));
    }catch(e){
      scaffold?.showSnackBar(
        SnackBar(content: Text('$e') ));
    }
  }

}

