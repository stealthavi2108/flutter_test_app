import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/usermodel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:permission_handler/permission_handler.dart';

import 'excel.dart';
import 'newpage.dart';
void main() {
  void requestPermission() {
    PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }
  runApp(
 MaterialApp(
   debugShowCheckedModeBanner: false,
   title: "Flutter App",
   home: Material(
     color: Colors.yellow,
     child:  epage())
 )

  );
}
class b extends StatefulWidget {
  @override
  _bState createState() => _bState();
}

class _bState extends State<b> {
  @override
  File imageFile;
  Usermodel _user;
  File image;
  String img1;
  Future getcamera() async {

    ImagePicker imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        setState(() { image = imageFile;});
      } else {
        print('No image selected.');
      }
    });
  }
  Future<Usermodel> createurl(String i1) async{
    String apiUrl ="https://backend-test-zypher.herokuapp.com/uploadImageforMeasurement";
    final response = await http.post(apiUrl,body: {
    "imageURL" : i1
    }
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode==200)
    {
      final String responsestring=response.body;//response from api body
      return usermodelFromJson(responsestring);

    }
    else{
      return null;
    }
  }
  Future uploadimg() async{
    String imgname=DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference storageReference=FirebaseStorage.instance.ref().child("images").child(imgname);//for uploading data to firebase storage
    StorageUploadTask storageTask=  storageReference.putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot=await storageTask.onComplete;
    storageTaskSnapshot.ref.getDownloadURL().then((dwnurl) async{
      imgurl=dwnurl;

      setState(() {
        img1=dwnurl;


      });
      print("url :$img1");
      final Usermodel user= await createurl(img1);
      Fluttertoast.showToast(msg:"Image Uploaded Successfully");
      setState(() {
        image=null;
        _user=user;//_user retrieved from usre
      });
      print(user.d.ankle);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>np(u1: _user,)));
      setState(() {
        var docref=Firestore.instance.collection("images")
            .document(DateTime.now().millisecondsSinceEpoch.toString());
        Firestore.instance.runTransaction((transaction)async{
          await transaction.set(docref, {
            "time":DateTime.now().millisecondsSinceEpoch.toString(),
            "content":imgurl,
          });
        }).whenComplete(() => (){
       });

      });

    },onError: (error){
      setState(() {

      });

      Fluttertoast.showToast(msg: 'Error'+error);

    });



  }
  Future getImg() async{

    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);

        setState(() { image = imageFile;});
      } else {
        print('No image selected.');
      }
    });
    print(imageFile);
    // imagefile=await ImagePicker.pickImage(source: ImageSource.gallery);


    // setState(() {
    //   image=null;
    // });
  }
  String imgurl;
  Widget build(BuildContext context) {
   String str="center";

    return Scaffold(
        appBar: AppBar( centerTitle: true,title: Text("Measurements"),),
    floatingActionButton: image == null ? Container():FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        elevation: 6.0,
        heroTag: null,
        icon: Icon(Icons.upload_rounded),
        label: Text("Upload Image"),
        onPressed: () {
         uploadimg();

        }
      // Navigator.push(context,MaterialPageRoute(builder: (context) => add()));

    ),
      resizeToAvoidBottomInset: false,

      body: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
        Container(
          child: image == null ? Container() : Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(height: 400.0,width:350.0,child: Image.file(image)),SizedBox(height: 30.0,),
              Container(width: 100.0,height: 40.0,
                // ignore: deprecated_member_use
                child: RaisedButton(color: Colors.red,onPressed: (){setState(() {
                  image=null;
                  str="center";
                },
                );},child: Row(
                  children: [Icon(Icons.cancel_outlined,color: Colors.white,),
                    Text("Delete",style: TextStyle(color: Colors.white),),
                  ],
                ),
                ),
              ),
            ],
          ),
        )
        ,image == null?Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            // ignore: deprecated_member_use, 2
            children: [RaisedButton(onPressed: (){
              getcamera();
            },color: Colors.blue,child: Text("Click Using Camera"),),SizedBox(width: 10.0,),
              // ignore: deprecated_member_use
              RaisedButton(onPressed: (){
                getImg();
              },color: Colors.amber,child: Text("Access Gallery"))],
          ),
        ):Container()
      ],)
    );

  }
}
