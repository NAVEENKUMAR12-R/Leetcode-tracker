import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leetcode_tracker/countdisplay.dart';
import 'package:leetcode_tracker/models/countmodel.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});

  final countlist = Countmodel.Countlist();

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  String searchQuery = "";

  void _showAddStudentDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New Coder"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Student Name"),
              ),
              TextField(
                controller: _idController,
                decoration: InputDecoration(labelText: "Leetcode ID"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _nameController.clear();
                _idController.clear();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text.trim();
                final id = _idController.text.trim();

                if (name.isNotEmpty && id.isNotEmpty) {
                  setState(() {
                    widget.countlist.add(
                      Countmodel(
                        Student_name: name,
                        Leetcode_id: id,
                        count: 0,
                        ratings: 0,
                      ),
                    );
                  });

                  Navigator.of(context).pop();
                  _nameController.clear();
                  _idController.clear();
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  List<Countmodel> get filteredList {
    if (searchQuery.isEmpty) {
      return widget.countlist;
    } else {
      return widget.countlist
          .where((item) => (item.Student_name ?? '')
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, dd-MM-yyyy').format(now);

    return Scaffold(
      backgroundColor: Color(0Xffc8b1e4),
      appBar: AppBar(
        backgroundColor: Color(0xfff4effa),
        title: Text("Leet Track"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddStudentDialog,
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  prefixIcon: Icon(Icons.search, color: Colors.black, size: 20),
                  prefixIconConstraints:
                      BoxConstraints(maxHeight: 20, minWidth: 25),
                  border: InputBorder.none,
                  hintText: "Search coder",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30, bottom: 20),
                    child: Text(
                      "Today's Count  $formattedDate",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  for (var entry in filteredList.asMap().entries)
                    Countdisplay(countmodel: entry.value, index: entry.key),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
