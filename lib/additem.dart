import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  CollectionReference templateList = FirebaseFirestore.instance.collection('templateList');

  final id = TextEditingController();
  final name = TextEditingController();
  final company = TextEditingController();
  final from = TextEditingController();
  final amount = TextEditingController();

  styledTextField(field, text) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8 ),
        child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: text,
        ),
        controller: field,
      )
      );
  }

  styledNumberField(field, text) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8 ),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: text,
          ),
          controller: field,
          keyboardType: TextInputType.number,
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Item'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          styledNumberField(id, 'Id'),
          SizedBox(height: 10),
          styledTextField(name, 'Name'),
          SizedBox(height: 10),
          styledTextField(company, 'Company'),
          SizedBox(height: 10),
          styledTextField(from, 'From'),
          SizedBox(height: 10),
          styledNumberField(amount, 'Amount'),
          SizedBox(height: 20,),
          Center (
            child: ElevatedButton(
              onPressed: () {
                templateList.doc(id.text).set(
                  {
                    "id": int.parse(id.text),
                    "name": name.text,
                    "company": company.text,
                    "from": from.text,
                    "amount": int.parse(amount.text),
                  }
                );
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text(
                'Confirm item',
                style: TextStyle(fontSize: 20),
              ),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(20.0)),
              ),
            )
          )
        ],
      ),
    );
  }
}
