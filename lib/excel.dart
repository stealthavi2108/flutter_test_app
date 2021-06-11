import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as p1;
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_filereader/flutter_filereader.dart';
List l1=[];
class epage extends StatefulWidget {
  @override
  _epageState createState() => _epageState();
}
class _epageState extends State<epage> {
  FirebaseStorage s1=FirebaseStorage();
  File file;
  File fnew;
  String fname=" ";
  String f1=" ";
  StorageReference storageReference;
  Future uploadfile(File file,String fname)async{
    storageReference=FirebaseStorage.instance.ref().child("excels/$fname");//create referecning for file storage on firebase
    final StorageUploadTask uploadTask=storageReference.putFile(file);
      final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
      final String url = (await downloadUrl.ref.getDownloadURL());
      print("URL is $url");
    setState(() {
      var docref=Firestore.instance.collection("ExcelFile")
          .document(DateTime.now().millisecondsSinceEpoch.toString());
      Firestore.instance.runTransaction((transaction)async{
        await transaction.set(docref, {
          "time":DateTime.now().millisecondsSinceEpoch.toString(),
          "Filename":fname,
        });
      }).whenComplete(() => (){
      });

    });

      Fluttertoast.showToast(msg: "File Uploaded SuccessFully");

  }

    filePicker() async{

        file = await FilePicker.getFile(type: FileType.custom,allowedExtensions:  ["xlsx"]);//pickup file of extension .xlsx for excel
        fname=p1.basename(file.path);
        setState(() {
          fnew=file;
          f1=fname;
        });



    }
  @override
  Map mp={};
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ fnew==null?Container():GestureDetector(child: Card(child: ListTile(title: Text(fname),trailing: IconButton(icon: Icon(Icons.cancel_outlined,color: Colors.red,)
              ,onPressed: (){setState(() {
                fnew=null;
              });},)
              ,leading: Icon(Icons.table_chart_rounded,color: Colors.green,),),),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  fnew==null?
                  ElevatedButton(onPressed: () {filePicker();  },
              // ignore: deprecated_member_use
              child: Text("Pick File"),
                  ):

                  ElevatedButton(
                    onPressed: () {
                      var file = fnew.path;
                      var bytes = File(file).readAsBytesSync();
                      var excel = Excel.decodeBytes(bytes);

                      // for (var table in excel.tables.keys) {
                      //   print(table); //sheet Name
                      //   print(excel.tables[table].maxCols);
                      //   print(excel.tables[table].maxRows);
                      //   for (var row in excel.tables[table].rows) {
                      //
                      //     for (var r in row)
                      //       {
                      //         print(r);
                      //       }
                      //   }
                      // }
                      int j=0;
                      for (var table in excel.tables.keys) {

                        for (var row in excel.tables[table].rows)
                          {
                            setState(() {
                              mp[++j] = row ;
                            });}

                    }
                      for (var i in mp.keys)
                      {

                        setState(() {
                          l1.add(mp[i]);
                        });

                      }

                      Navigator.push(context,MaterialPageRoute(builder: (context)=>view(file: fnew, fname: fname, mp: mp)));
                    },

                  // ignore: deprecated_member_use
                  child: Text("View File"),),SizedBox(width: 10.0,),
                  ElevatedButton(onPressed: (){

                    //
                  uploadfile(file, fname);
                  Fluttertoast.showToast(msg:"Spreadsheet Uploaded Successfully");
                  setState(() {
                    fnew=null;
                  });
                  },child: Text("Upload File"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class view extends StatefulWidget {
  File file;
  String fname;
  Map mp;
  view({Key key,@required this.file,@required this.fname,@required this.mp});
  @override
  _viewState createState() => _viewState();
}

class _viewState extends State<view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text(widget.fname)),
    body: MyStatefullWidget(file: widget.file,fname:widget.fname,mp: widget.mp,),

    );
  }
}
class MyStatefullWidget extends StatefulWidget {
  File file;
  String fname;
  Map mp;
  MyStatefullWidget({Key key,@required this.file,this.fname,this.mp});

  // const MyStatelessWidget({Key key}) : super(key: key);
  @override
  _MyStatefullWidgetState createState() => _MyStatefullWidgetState();
}

class _MyStatefullWidgetState extends State<MyStatefullWidget> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  // for(int i=0;i<10;i++)
  final children = <Widget>[];

  Widget build(BuildContext context) {
    return DataTable(
      columns:  <DataColumn>[
        for (var i in l1[0])
          DataColumn(label: Padding(
            padding: const EdgeInsets.only(top: 3.0,bottom: 3.0),
            child: Text("${i}"),
          ))

      ],
      rows: <DataRow>[
        for(var i in l1.getRange(1, l1.length))
          DataRow(
            cells: <DataCell>[
              for(var z in i)
                DataCell(Text('$z')),


            ],
          ),

      ],
    );
  }
}

