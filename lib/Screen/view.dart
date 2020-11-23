import 'package:flutter/material.dart';
import 'package:reorder_listview/constants/colors.dart';

class CategoryScreen extends StatefulWidget {
  List<String> item = ["Apples", "Milk", "Eggs", "Ice", "Tomatoes"];
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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

  @override
  Widget build(BuildContext context) {
    String userInput;
    TextEditingController inputString = new TextEditingController();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Add Products'),
        ),
        body: Container(
          // decoration: new BoxDecoration(
          //   // image: new DecorationImage(
          //   //   //image: new AssetImage('images/whatsappbk.png'),
          //   //   fit: BoxFit.cover,
          //   // ),
          // ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              height: height,
              decoration: BoxDecoration(
                border: Border.all(
                  color: darkGrey,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 230,
                        height: 55,
                        child:
                            //               TextField(
                            //   onChanged: (String textTyped) {
                            //     y = textTyped;
                            //   },
                            //   keyboardType: TextInputType.text,
                            //   decoration: InputDecoration(hintText: 'Enter new category'),
                            // ),

                            TextField(
                          onChanged: (String textTyped) {
                            userInput = textTyped;
                          },
                          controller: inputString,
                          cursorColor: darkGrey,
                          cursorHeight: 20,
                          decoration: (InputDecoration(
                            hintStyle: TextStyle(
                              fontSize: 24,
                              fontStyle: FontStyle.normal,
                            ),
                            hintText: 'Category',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 1,
                        height: 55,
                        child: Container(
                          color: darkGrey,
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: Expanded(
                            child: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  print(inputString.text);
                                  print(widget.item);
                                  widget.item.add(inputString.text);
                                  print(widget.item);
                                }),
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: darkGrey,
                    height: 5,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                  SizedBox(),
                  Expanded(
                    child: ReorderableListView(
                      children: <Widget>[
                        for (final items in widget.item)
                          Card(
                            color: primaryColor,
                            key: ValueKey(items),
                            elevation: 2,
                            child: Container(
                              child: ListTile(
                                
                                title: Text(items),
                                leading:
                                    Icon(Icons.drag_indicator, color: lightGrey),
                                trailing: InkWell(
                                  onTap: () {
                                    int x = widget.item.indexOf(items);
                                    print(x);
                                    _showDialog(items, x);
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: lightGrey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                      onReorder: reorderData,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
}
