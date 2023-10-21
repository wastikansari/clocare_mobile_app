import 'package:flutter/material.dart';



class Stepper1 extends StatefulWidget {
  @override
  _Stepper1State createState() => _Stepper1State();
}

class _Stepper1State extends State<Stepper1> {
  String selectedOption = 'No option selected';

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text('Option 1'),
                onTap: () {
                  setState(() {
                    selectedOption = 'Option 1 selected';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.star),
                title: Text('Option 2'),
                onTap: () {
                  setState(() {
                    selectedOption = 'Option 2 selected';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.attach_money),
                title: Text('Option 3'),
                onTap: () {
                  setState(() {
                    selectedOption = 'Option 3 selected';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Sheet Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _showBottomSheet(context);
              },
              child: Text('Show Bottom Sheet'),
            ),
            SizedBox(height: 20),
            Text(
              'Selected Option:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              selectedOption,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
