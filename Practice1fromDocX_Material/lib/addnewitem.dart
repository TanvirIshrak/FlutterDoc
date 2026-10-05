import 'package:flutter/material.dart';

class AddNewItem extends StatefulWidget {
  const AddNewItem({super.key});

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  // List of data
  List<String> items = [];
  int count = 0;
  bool snackBarVisible = false;
  // add new item to the list
  void addItem() {
    setState(() {
      items.insert(0, 'New Item: $count');
      count++;
      snackBarVisible = true;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(
          const SnackBar(
            content: Text('New item added!'),
            duration: Duration(seconds: 2),
          ),
        ).closed.then((reason) {
          if (mounted) {
            setState(() {
              snackBarVisible = false;
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Item Page')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.label),
            title: Text(items[index]),
          );
        },
      ),

      // button click korle snackbar show korbe and button slightly uopore uthbe
      // sncakbar neme gele button abar niche chole asbe ei function add kora hoyece
      floatingActionButton: AnimatedPadding(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(
          bottom: snackBarVisible ? 70 : 0,
        ),
        child: FloatingActionButton(
        onPressed: () {
          addItem();
        },
        tooltip: 'Add New Item',
        child: const Icon(Icons.add),
      ),
    )
    );
  }
}
