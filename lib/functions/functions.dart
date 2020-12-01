import 'package:flutter/material.dart';

class FunctionsPack extends StatefulWidget {
  List<String> item = ["Apples", "Milk", "Eggs", "Ice", "Tomatoes"];
  @override
  _FunctionsPackState createState() => _FunctionsPackState();
}

class _FunctionsPackState extends State<FunctionsPack> {

void reorderData(int oldindex, int newindex) {
    setState(() {
      if (newindex > oldindex) {
        newindex -= 1;
      }
      final items = widget.item.removeAt(oldindex);
      widget.item.insert(newindex, items);
    });
  }

  void sorting() {
    setState(() {
      widget.item.sort();
    });
  }

  void addCategory(input) {
    setState(() {
      widget.item.add(input);
    });
  }
void _showDialog(category, index) {
    String dialogText;
    String y;
    int index;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Edit ${category}"),
          content: TextField(
            onChanged: (String textTyped) {
              y = textTyped;
            },
            keyboardType: TextInputType.text,
            decoration: InputDecoration(hintText: 'Enter new category'),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            Row(
              children: <Widget>[
                new FlatButton(
                  child: new Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                    onPressed: () {
                      index = widget.item.indexOf(category);
                      print(index);
                      setState(() {
                        widget.item[index] = y;
                      });

                      Navigator.of(context).pop();
                    },
                    child: new Text("OK"))
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}