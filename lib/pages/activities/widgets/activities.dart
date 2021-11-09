// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:editable/editable.dart';

class ActivitiesWidget extends StatefulWidget {
  const ActivitiesWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ActivitiesWidgetState createState() => _ActivitiesWidgetState();
}

class _ActivitiesWidgetState extends State<ActivitiesWidget> {
  /// Create a Key for EditableState
  final _editableKey = GlobalKey<EditableState>();

  List rows = [
    {
      "name": 'James LongName Joe',
      "date": '23/09/2020',
      "month": 'June',
      "status": 'completed'
    },
    {
      "name": 'Daniel Paul',
      "month": 'March',
      "status": 'new',
      "date": '12/4/2020',
    },
    {
      "month": 'May',
      "name": 'Mark Zuckerberg',
      "date": '09/4/1993',
      "status": 'expert'
    },
    {
      "name": 'Jack',
      "status": 'legend',
      "date": '01/7/1820',
      "month": 'December',
    },
    {
      "name": 'Jack',
      "status": 'legend',
      "date": '01/7/1820',
      "month": 'December',
    },
    {
      "name": 'Jack',
      "status": 'legend',
      "date": '01/7/1820',
      "month": 'December',
    },
    {
      "name": 'Jack',
      "status": 'legend',
      "date": '01/7/1820',
      "month": 'December',
    },
    {
      "name": 'Jack',
      "status": 'legend',
      "date": '01/7/1820',
      "month": 'December',
    },
    {
      "name": 'Jack',
      "status": 'legend',
      "date": '01/7/1820',
      "month": 'December',
    },
    {
      "name": 'Jack',
      "status": 'legend',
      "date": '01/7/1820',
      "month": 'December',
    },
    {
      "name": 'Jack',
      "status": 'legend',
      "date": '01/7/1820',
      "month": 'December',
    },
    {
      "name": 'Jack',
      "status": 'legend',
      "date": '01/7/1820',
      "month": 'December',
    },
    {
      "name": 'Jack',
      "status": 'legend',
      "date": '01/7/1820',
      "month": 'December',
    },
    {
      "name": 'Jack',
      "status": 'legend',
      "date": '01/7/1820',
      "month": 'December',
    },
  ];
  List cols = [
    {"title": 'Name', 'widthFactor': 0.2, 'key': 'name', 'editable': false},
    {"title": 'Date', 'widthFactor': 0.2, 'key': 'date'},
    {"title": 'Month', 'widthFactor': 0.2, 'key': 'month'},
    {"title": 'Status', 'key': 'status'},
  ];

  /// Function to add a new row
  /// Using the global key assigined to Editable widget
  /// Access the current state of Editable
  void _addNewRow() {
    setState(() {
      _editableKey.currentState!.createRow();
    });
  }

  ///Print only edited rows.
  void _printEditedRows() {
    List editedRows = _editableKey.currentState!.editedRows;
    print(editedRows);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leadingWidth: 200,
      //   leading: TextButton.icon(
      //       onPressed: () => _addNewRow(),
      //       icon: const Icon(Icons.add),
      //       label: const Text(
      //         'Add',
      //         style: TextStyle(fontWeight: FontWeight.bold),
      //       )),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: TextButton(
      //           onPressed: () => _printEditedRows(),
      //           child: const Text('Print Edited Rows',
      //               style: TextStyle(fontWeight: FontWeight.bold))),
      //     )
      //   ],
      // ),
      body: Editable(
        key: _editableKey,
        columns: cols,
        rows: rows,
        zebraStripe: true,
        stripeColor1: Colors.blue.shade50,
        stripeColor2: Colors.grey.shade200,
        onRowSaved: (value) {
          print(value);
        },
        onSubmitted: (value) {
          print(value);
        },
        borderColor: Colors.blueGrey,
        tdStyle: const TextStyle(fontWeight: FontWeight.bold),
        trHeight: 80,
        thStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        thAlignment: TextAlign.center,
        thVertAlignment: CrossAxisAlignment.end,
        thPaddingBottom: 3,
        showSaveIcon: true,
        saveIconColor: Colors.black,
        showCreateButton: true,
        tdAlignment: TextAlign.left,
        tdEditableMaxLines: 100, // don't limit and allow data to wrap
        tdPaddingTop: 0,
        tdPaddingBottom: 14,
        tdPaddingLeft: 10,
        tdPaddingRight: 8,
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(0))),
      ),
    );
  }
}
