// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../api/api_service.dart';
import '../../component/button/rounded/plus_rounded_orange.dart';
import '../../helper/global_colors.dart';

class MultipleSelectionPage extends StatefulWidget {
  final Map<String, dynamic> formData;

  MultipleSelectionPage({required this.formData});

  @override
  _MultipleSelectionPageState createState() => _MultipleSelectionPageState();
}

class _MultipleSelectionPageState extends State<MultipleSelectionPage> {
  GlobalColors globalColors = GlobalColors();
  List<String> qtyPetTotal = [];
  Map<String, TextEditingController> nameControllers = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.formData['qtyPet']; i++) {
      String petIndex = 'Hewan ${i + 1}';
      qtyPetTotal.add(petIndex);
      nameControllers[petIndex] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (var controller in nameControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleSubmit() {
    List<Map<String, dynamic>> petDataList = [];

    for (var petIndex in qtyPetTotal) {
      String name = nameControllers[petIndex]!.text;

      Map<String, dynamic> petData = {
        'nama': name,
      };

      petDataList.add(petData);
    }

    Map<String, dynamic> formReservation = {
      'hotel_id': widget.formData['hotel_id'],
      'user_id': widget.formData['user_id'],
      'start_date': widget.formData['start_date'],
      'end_date': widget.formData['end_date'],
      'reservation_status': widget.formData['reservation_status'],
      'agreement': widget.formData['agreement'],
      'reservation_detail': petDataList,
    };
    print("reservation tes : $formReservation");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Reservation'),
      ),
      body: ListView.builder(
        itemCount: qtyPetTotal.length,
        itemBuilder: (context, index) {
          final petIndex = qtyPetTotal[index];
          return Card(
            child: ListTile(
              title: Center(child: Text("$petIndex")),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "nama",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: nameControllers[petIndex],
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: globalColors.textBlackSmall),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: globalColors.bgOrange),
                          ),
                          hintText: "nama",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleSubmit,
        child: const Icon(Icons.check),
      ),
    );
  }
}
