import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:template/tempdata.dart';
import 'package:template/itemdetails.dart';
import 'package:template/options.dart';
import 'package:template/deleteItems.dart';
import 'package:holding_gesture/holding_gesture.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference templateList = FirebaseFirestore.instance.collection('templateList');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('templateApp'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Options()));
          }, icon: Icon(Icons.settings))
        ],
      ),
      body: StreamBuilder(
        stream: templateList.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: Text('Loading...'));
          return ListView(
            children: snapshot.data!.docs.map((document) {
              var newdata = TempData.fromFirestore(document as QueryDocumentSnapshot<Map<String, dynamic>>);
              print(snapshot);
              return Column(
                  children: [
                    HoldDetector(
                      onHold: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeleteItems()));
                      },
                      holdTimeout: Duration(milliseconds: 500),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ItemDetails(newdata)));
                        },
                        splashColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        child: ListTile(
                          title: Text(newdata.name.toString()),
                          trailing: Text(newdata.amount.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ]
              );
            }).toList().cast(),
          );
        },
      ),
    );
  }
}