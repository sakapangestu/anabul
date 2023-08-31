import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../helper/global_colors.dart';

class DateRangeTes extends StatefulWidget {
  @override
  _DateRangeTesState createState() => _DateRangeTesState();
}

class _DateRangeTesState extends State<DateRangeTes> {
  DateTime? _selectedStartDay;
  DateTime? _selectedEndDay;
  GlobalColors globalColors = GlobalColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Calendar with Date Range Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: globalColors.bgOrangeDisabled,
                border: Border.all(width: 1, color: globalColors.bgOrange.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                // setelah memilih start day, end day akan muncul pada tampilan kalender
                selectedDayPredicate: (day) => _selectedEndDay != null
                    ? day.isAfter(_selectedStartDay!.subtract(const Duration(days: 1))) &&
                    day.isBefore(_selectedEndDay!.add(const Duration(days: 1)))
                    : day == _selectedStartDay,
                onDaySelected: (selectedDay, focusedDay) {
                  if (_selectedStartDay == null ||
                      (_selectedEndDay != null &&
                          selectedDay.isBefore(_selectedStartDay!))) {
                    setState(() {
                      _selectedStartDay = selectedDay;
                      _selectedEndDay = null;
                    });
                  } else if (_selectedEndDay == null ||
                      selectedDay.isAfter(_selectedStartDay!)) {
                    setState(() {
                      _selectedEndDay = selectedDay;
                    });
                  } else {
                    setState(() {
                      _selectedEndDay = null;
                    });
                  }
                },
                // properti lain untuk menampilkan kalender
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: globalColors.bgOrange,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  selectedTextStyle: const TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    // color: Colors.red,
                    shape: BoxShape.rectangle,
                    border: Border.all(width: 1, color: globalColors.bgOrange),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  todayTextStyle: TextStyle(color: globalColors.bgOrange),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                ),
                calendarBuilders: CalendarBuilders(
                  selectedBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: globalColors.bgOrange,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Text(
                      date.day.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  // builder lainnya
                ),
              ),
            ),
            const SizedBox(height: 20),
            _selectedStartDay != null && _selectedEndDay != null
                ? Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tanggal Masuk",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: globalColors.textBlackSmall, width: 1),
                        ),
                        child:
                        Text(
                          '${_selectedStartDay.toString()}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tanggal Keluar",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: globalColors.textBlackSmall, width: 1),
                        ),
                        child:
                        Text(
                          '${_selectedEndDay.toString()}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tanggal Masuk",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: globalColors.textBlackSmall),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: globalColors.bgOrange),
                          ),
                          hintText: "Tanggal Masuk",
                          enabled: true
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tanggal Keluar",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: globalColors.textBlackSmall),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: globalColors.bgOrange),
                          ),
                          hintText: "Tanggal Keluar",
                          enabled: true
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

