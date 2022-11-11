import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:template/tempdata.dart';

import 'main.dart';

class DeleteItems extends StatefulWidget {
  const DeleteItems({Key? key}) : super(key: key);

  @override
  State<DeleteItems> createState() => _DeleteItemsState();
}

class _DeleteItemsState extends State<DeleteItems> {
  CollectionReference templateList = FirebaseFirestore.instance.collection('templateList');
  List pickedItems = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Delete items'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: templateList.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: Text('Loading...'));
          return ListView(
            children: snapshot.data!.docs.map((document) {
              var newdata = TempData.fromFirestore(document as QueryDocumentSnapshot<Map<String, dynamic>>);
              bool? checkboxValue = false;
              return Column(
                  children: [
                    CheckboxListTile(
                      title: Text(newdata.name.toString()),
                      onChanged: (bool? value) {
                        setState(() {
                          if(value == true) pickedItems.add(newdata.id.toString());
                          else pickedItems.remove(newdata.id.toString());
                        });
                      },
                      value: pickedItems.contains(newdata.id.toString()),
                    ),
                  ]
              );
            }).toList().cast(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pickedItems.forEach((e) {
            templateList.doc(e).delete();
          });
          Navigator.of(context).pop(MaterialPageRoute(builder: (context) => Home()));
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
