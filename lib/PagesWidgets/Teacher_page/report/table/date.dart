import 'package:flutter/material.dart';

class YearMonthDropdown extends StatefulWidget {
  final void Function(int year, int month) onChanged;

  YearMonthDropdown({this.onChanged});

  @override
  _YearMonthDropdownState createState() => _YearMonthDropdownState();
}

class _YearMonthDropdownState extends State<YearMonthDropdown> {
  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<int>> yearItems = List.generate(
      DateTime.now().year - 1999,
      (index) => DropdownMenuItem(
        value: 2000 + index,
        child: Text('${2000 + index}'),
      ),
    );

    List<DropdownMenuItem<int>> monthItems = List.generate(
      12,
      (index) => DropdownMenuItem(
        value: index + 1,
        child: Text(
          '${index + 1}',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("الشهر  "),
        DropdownButton<int>(
          value: _selectedMonth,
          items: monthItems,
          onChanged: (value) {
            setState(() {
              _selectedMonth = value;
            });
            widget.onChanged(_selectedYear, _selectedMonth);
          },
        ),
        SizedBox(width: 16),
        Text("السنة   "),
        DropdownButton<int>(
          value: _selectedYear,
          items: yearItems,
          onChanged: (value) {
            setState(() {
              _selectedYear = value;
            });
            widget.onChanged(_selectedYear, _selectedMonth);
          },
        ),
      ],
    );
  }
}
