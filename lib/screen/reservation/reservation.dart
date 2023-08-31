// import 'package:anabulhotel/api/api_service.dart';
// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/component/button/rounded/rounded_orange_disabled.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
// import 'package:anabulhotel/helper/session.dart';
// import 'package:anabulhotel/screen/reservation/detail/detail_reservation.dart';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:latlong2/latlong.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../api/api_service.dart';
import '../../component/app_bar/app_bar_tittle.dart';
import '../../component/button/rounded/rounded_orange_disabled.dart';
import '../../helper/global_colors.dart';
import '../../helper/session.dart';
import '../tes/tesService.dart';
import 'detail/detail_reservation.dart';

class Reservation extends StatefulWidget {
  const Reservation({Key? key, required this.hotels}) : super(key: key);
  final Map hotels;

  @override
  State<Reservation> createState() => _Reservation();
}

class _Reservation extends State<Reservation> {
  GlobalColors globalColors = GlobalColors();
  final TextEditingController _clockIn = TextEditingController();
  final TextEditingController _clockOut = TextEditingController();
  final TextEditingController _reservationName = TextEditingController();
  final TextEditingController _identityNumber = TextEditingController();
  final TextEditingController _qtyPetController = TextEditingController();
  DateTime? _selectedStartDay;
  DateTime? _selectedEndDay;
  DateTime? _startDate; // Tanggal masuk
  DateTime? _endDate; // Tanggal keluar
  int _currentValue = 0;
  String _qtyError = " ";
  List<Map<String, dynamic>> petList = [];

  bool isChecked = false;
  bool _isContainerVisible = false;

  void _toggleContainerVisibility() {
    setState(() {
      _isContainerVisible = !_isContainerVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPetData();
  }

  Future<void> fetchPetData() async {
    try {
      final List<Map<String, dynamic>> pets = await TesSpecies.getPetUser();
      setState(() {
        petList = pets;
      });
    } catch (e) {
      // Handle error
      print('Error fetching pet data: $e');
    }
  }

  bool _validateInputs() {
    bool isValid = true;
    // validasi jumlah hewan
    if (_qtyPetController.text.trim().isEmpty) {
      setState(() {
        _qtyError = "Jumlah harus diisi";
      });
      isValid = false;
    } else {
      setState(() {
        _qtyError = "";
      });
    }

    return isValid;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _clockIn.dispose();
    _clockOut.dispose();
    _reservationName.dispose();
    _identityNumber.dispose();
    _qtyPetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("tes pet: ${petList.length}");
    var regulations = widget.hotels['regulations'];
    print("ini apa: ${widget.hotels['regulations']}");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xffDC822A),
        flexibleSpace: const SafeArea(
          child: AppBarTitle(
            title: "Reservasi",
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
          child: Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: globalColors.bgOrangeDisabled,
                              border: Border.all(
                                  width: 1,
                                  color:
                                      globalColors.bgOrange.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: TableCalendar(
                              firstDay: DateTime.now(),
                              lastDay: DateTime.utc(2030, 3, 14),
                              focusedDay: DateTime.now(),
                              selectedDayPredicate: (day) => _endDate != null
                                  ? day.isAfter(_startDate!
                                          .subtract(const Duration(days: 1))) &&
                                      day.isBefore(_endDate!
                                          .add(const Duration(days: 1)))
                                  : day == _startDate,
                              onDaySelected: (selectedDay, focusedDay) {
                                if (_startDate == null ||
                                    selectedDay.isBefore(DateTime.now())) {
                                  setState(() {
                                    _startDate = DateTime.now();
                                    _endDate = null;
                                  });
                                } else if (_endDate == null ||
                                    selectedDay.isAfter(_startDate!)) {
                                  setState(() {
                                    _endDate = selectedDay;
                                  });
                                } else {
                                  setState(() {
                                    _endDate = null;
                                  });
                                }

                                if (_startDate != null) {
                                  String formattedStartDate =
                                      DateFormat('dd-MM-yyyy')
                                          .format(_startDate!);
                                  // print('Selected Start Day: $formattedStartDate');
                                }
                                if (_endDate != null) {
                                  String formattedEndDate =
                                      DateFormat('dd-MM-yyyy')
                                          .format(_endDate!);
                                  // print('Selected End Day: $formattedEndDate');
                                }
                              },
                              // properti lain untuk menampilkan kalender
                              calendarStyle: CalendarStyle(
                                selectedDecoration: BoxDecoration(
                                  color: globalColors.bgOrange,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                selectedTextStyle:
                                    const TextStyle(color: Colors.white),
                                todayDecoration: BoxDecoration(
                                  color: globalColors.bgOrange,
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                      width: 1, color: globalColors.bgOrange),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                todayTextStyle:
                                    TextStyle(color: globalColors.textWhite),
                              ),
                              headerStyle: const HeaderStyle(
                                  formatButtonVisible: false,
                                  titleCentered: true),
                              calendarBuilders: CalendarBuilders(
                                selectedBuilder: (context, date, events) =>
                                    Container(
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
                          // const SizedBox(height: 20),
                          _startDate != null && _endDate != null
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Tanggal Masuk",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: const EdgeInsets.only(
                                                top: 15,
                                                bottom: 15,
                                                left: 15,
                                                right: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: globalColors
                                                      .textBlackSmall,
                                                  width: 1),
                                            ),
                                            child: Text(
                                              _startDate != null
                                                  ? DateFormat('dd-MM-yyyy')
                                                      .format(_startDate!)
                                                  : '',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Tanggal Keluar",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: const EdgeInsets.only(
                                                top: 15,
                                                bottom: 15,
                                                left: 15,
                                                right: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: globalColors
                                                      .textBlackSmall,
                                                  width: 1),
                                            ),
                                            child: Text(
                                              _endDate != null
                                                  ? DateFormat('dd-MM-yyyy')
                                                      .format(_endDate!)
                                                  : '',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Tanggal Masuk",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          TextField(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                    color: globalColors
                                                        .textBlackSmall),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                    color:
                                                        globalColors.bgOrange),
                                              ),
                                              hintText: "Tanggal Masuk",
                                              enabled: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Tanggal Keluar",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          TextField(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                    color: globalColors
                                                        .textBlackSmall),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                    color:
                                                        globalColors.bgOrange),
                                              ),
                                              hintText: "Tanggal Keluar",
                                              enabled: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Hewan Yang Dititipkan",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: const Icon(Icons.remove_circle),
                                  onPressed: () {
                                    setState(() {
                                      _currentValue = _currentValue > 0
                                          ? _currentValue - 1
                                          : 0;
                                      _qtyPetController.text =
                                          _currentValue.toString();
                                      // print("ini apa: ${_currentValue}");
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 7,
                                child: TextField(
                                  controller: _qtyPetController,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color: globalColors.textBlackSmall),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color: globalColors.bgOrange),
                                    ),
                                    hintText: "Hewan",
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _currentValue = int.tryParse(value) ?? 0;
                                      // print(_currentValue);
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: IconButton(
                                    icon: const Icon(Icons.add_circle_outlined),
                                    onPressed: () {
                                      setState(() {
                                        if (petList.isEmpty) {
                                          Container(
                                            child: const Text("haloo"),
                                          );
                                          Fluttertoast.showToast(
                                            msg:
                                                'Belum ada data hewan. Silahkan tambahkan hewan anda terlebih dahulu',
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            backgroundColor: Colors.white,
                                            textColor: Colors.red,
                                            fontSize: 16.0,
                                          );
                                        } else if (_currentValue <
                                            petList.length) {
                                          _currentValue++;
                                          _qtyPetController.text =
                                              _currentValue.toString();
                                        }
                                        // print(_currentValue);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _qtyError,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Aturan Pet Hotel",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: _toggleContainerVisibility,
                                child: const Text('Tampilkan Peraturan'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (_isContainerVisible)
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: (regulations.isNotEmpty)
                        ? MediaQuery.of(context).size.height
                        : 150,
                    // margin: const EdgeInsets.symmetric(
                    //     horizontal: 20, vertical: 100),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color(0xFFF7DDC4),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: _toggleContainerVisibility,
                              child: const Icon(
                                Icons.close,
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      "Aturan Hotel",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "${widget.hotels['name']}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              // color: Colors.amber,
                              child: (regulations.isNotEmpty)
                                  ? SingleChildScrollView(
                                      child: Column(
                                        children: List.generate(
                                            regulations.length, (index) {
                                          var regulation = regulations[index];
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Text(
                                              regulation['description'],
                                              textAlign: TextAlign.justify,
                                              maxLines: 12,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          );
                                        }),
                                      ),
                                    )
                                  : Text(
                                      "Belum Ada Aturan",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: globalColors.textBlackBold),
                                    )),
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 9.h,
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: globalColors.borderLine, width: 0.5))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: GestureDetector(
            onTap: () async {
              final int _qtyPet = int.parse(_qtyPetController.text);
              final bool tempAgreement = isChecked;
              final String tempHotelId = widget.hotels['id_hotel'];
              final String? temporaryStartDate =
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(_startDate!);
              final String? temporaryEndDate =
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(_endDate!);
              Map<String, dynamic>? dataUser = await SessionManager.getData();
              final String temporaryIdUser = dataUser!['data']['id'];
              print("id:$temporaryIdUser");
              // if (petList.length == 0 || dataUser.isEmpty || petList.isEmpty) {
              //   Fluttertoast.showToast(
              //     msg: 'Login Terlebih Dahulu',
              //     toastLength: Toast.LENGTH_LONG,
              //     gravity: ToastGravity.CENTER,
              //     backgroundColor: Colors.red.withOpacity(0.4),
              //     textColor: Colors.white,
              //     fontSize: 16.0, // Ubah ukuran font menjadi 24.0
              //   );
              //   // ignore: unnecessary_null_comparison, unrelated_type_equality_checks
              // }
              if (_validateInputs()) {
                if (tempAgreement == true) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailReservation(formData: {
                        'qtyPet': _qtyPet,
                        'hotel_id': tempHotelId,
                        'user_id': temporaryIdUser,
                        'start_date': temporaryStartDate,
                        'end_date': temporaryEndDate,
                        'reservation_status': "Proses",
                        'agreement': tempAgreement,
                        // tambahkan data lain yang ingin Anda kirim
                      }),
                    ),
                  );
                } else {
                  // ignore: use_build_context_synchronously
                  Fluttertoast.showToast(
                    msg: 'Baca Aturan ${widget.hotels['name']} Terlebih Dahulu',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0, // Ubah ukuran font menjadi 24.0
                  );
                }
              }
            },
            child: const RoundedOrangeDisabled(
              title: "Selanjutnya",
            ),
          ),
        ),
      ),
    );
  }
}
