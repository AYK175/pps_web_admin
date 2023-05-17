import 'package:flutter/material.dart';

class MyTable extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  MyTable({required this.data});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Age')),
        DataColumn(label: Text('Email')),
      ],
      rows: data
          .map(
            (item) => DataRow(
          cells: [
            DataCell(Text(item['name'])),
            DataCell(Text(item['age'].toString())),
            DataCell(Text(item['email'])),
          ],
        ),
      )
          .toList(),
    );
  }
}
