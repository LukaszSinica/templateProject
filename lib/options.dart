import 'package:flutter/material.dart';
import 'package:template/additem.dart';

class Options extends StatefulWidget {
  const Options({Key? key}) : super(key: key);

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Options'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddItem()));
              },
              child: Text(
                'Add item',
                style: TextStyle(fontSize: 20),
              ),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(20.0)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
