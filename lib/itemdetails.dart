import 'package:flutter/material.dart';
import 'package:template/tempdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemDetails extends StatefulWidget {
  final TempData data;
  const ItemDetails(this.data);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  final amount = TextEditingController();
  var id;
  var name;
  var company;
  var from;
  var amountValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.data.id.toString();
    name = widget.data.name.toString();
    company = widget.data.company.toString();
    from = widget.data.from.toString();
    amountValue = widget.data.amount.toString();
  }

  void _onButtonPressed() {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        height: 300,
        color: Color(0xFF737373),
        child: Container(
          child: _bottomDrawer(),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(color: Colors.white, spreadRadius: 3),
            ],
          ),
        ),
      );
    });
  }

  Column _bottomDrawer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'amount',
            ),
            controller: amount,
            keyboardType: TextInputType.number,
            onSubmitted: (value) {
              CollectionReference templateList = FirebaseFirestore.instance.collection('templateList');
              templateList.doc(widget.data.id.toString()).update({
                'amount': int.parse(amount.text),
              });
              setState(() {
                amountValue = amount.text;
              });
              Navigator.pop(context);
            },
          )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Id'),
            trailing: Text(
              id,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: Text('Name'),
            trailing: Text(
              name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: Text('Company'),
            trailing: Text(
              company,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: Text('From'),
            trailing: Text(
              from,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: Text('Amount'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  amountValue,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(onPressed: () {
                  _onButtonPressed();
                }, icon: Icon(Icons.add))
              ],
            )
          ),
        ]
      ),
    );
  }
}
