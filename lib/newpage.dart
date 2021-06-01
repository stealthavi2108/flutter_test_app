import 'package:flutter/material.dart';
import 'package:flutter_app/usermodel.dart';
class np extends StatefulWidget {
  final Usermodel u1;
  np({Key key,@required this.u1});
  @override
  _npState createState() => _npState();
}

class _npState extends State<np> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( centerTitle: true,title: Text("Measurements"),),
      floatingActionButton: FloatingActionButton.extended(label: Text("Take Measurement Again"),backgroundColor: Colors.blue,
        elevation: 6.0,onPressed: (){Navigator.pop(context);},
        ),
      body: ListView(
        children: [Card(
          child: ExpansionTile(
            title: Text(
              "measurementId",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            children: <Widget>[
              ListTile(
                title: Text(
                  widget.u1.d.measurementId,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        ),
          Card(
          child: ExpansionTile(
            title: Text(
              "neck",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            children: <Widget>[
              ListTile(
                title: Text(
                  widget.u1.d.neck,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        ),
          Card(
            child: ExpansionTile(
              title: Text(
                "Height",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              children: <Widget>[
                ListTile(
                  title: Text(
                    widget.u1.d.height,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text(
                "weight",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              children: <Widget>[
                ListTile(
                  title: Text(
                    widget.u1.d.weight,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text(
                "Belly",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              children: <Widget>[
                ListTile(
                  title: Text(
                    widget.u1.d.belly,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text(
                "Chest",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              children: <Widget>[
                ListTile(
                  title: Text(
                    widget.u1.d.chest,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text(
                "Wrist",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              children: <Widget>[
                ListTile(
                  title: Text(
                    widget.u1.d.wrist,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text(
                "ArmLength",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              children: <Widget>[
                ListTile(
                  title: Text(
                    widget.u1.d.armLength,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text(
                "Thigh",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              children: <Widget>[
                ListTile(
                  title: Text(
                    widget.u1.d.thigh,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text(
                "Shoulder",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              children: <Widget>[
                ListTile(
                  title: Text(
                    widget.u1.d.shoulder,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text(
                "Hips",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              children: <Widget>[
                ListTile(
                  title: Text(
                    widget.u1.d.hips,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text(
                "Ankle",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              children: <Widget>[
                ListTile(
                  title: Text(
                    widget.u1.d.ankle,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),


        ],
      ),
    );
  }
}
