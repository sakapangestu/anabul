// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../api/api_service.dart';
import '../../component/button/rounded/plus_rounded_orange.dart';
import '../../helper/global_colors.dart';

class ReservationTes extends StatefulWidget {
  final Map<String, dynamic> formData;

  ReservationTes({required this.formData});

  @override
  _ReservationTesState createState() => _ReservationTesState();
}

class _ReservationTesState extends State<ReservationTes> {
  GlobalColors globalColors = GlobalColors();
  List<String> qtyPetTotal = [];
  List<Map<String, dynamic>> serviceList = [];
  Map<String, String?> _selectedService = {};
  List<Map<String, dynamic>> speciesList = [];
  List<Map<String, dynamic>> petUserList = [];
  List<String> statusVaccine = ['Sudah', 'Belum'];
  List<String> statusAllergy = ['Iya', 'Tidak'];
  Map<String, String?> selectedStatusVaccine = {};
  Map<String, String?> selectedStatusAllergy = {};
  Map<String, String?> _selectedSpecies = {};
  Map<String, String?> _selectedPet = {};
  Map<String, TextEditingController> diseaseHistoryControllers = {};
  Map<String, List<Map<String, dynamic>>> serviceReservationList = {};
  String? temporarySelectedSpecies;
  String? temporarySelectedStatusVaccine;
  List<Map<String, dynamic>> additionalServices = [];
  Map<String, List<Map<String, dynamic>>> additionalServiceReservationList = {};

  @override
  void initState() {
    super.initState();
    fetchDropdown();
    for (int i = 0; i < widget.formData['qtyPet']; i++) {
      String petIndex = 'Hewan ${i + 1}';
      qtyPetTotal.add(petIndex);
      diseaseHistoryControllers[petIndex] = TextEditingController();
      // _qtyPetServiceController[petName] = TextEditingController();
      selectedStatusVaccine[petIndex] = null;
      selectedStatusAllergy[petIndex] = null;
      _selectedSpecies[petIndex] = null;
      _selectedPet[petIndex] = null;
      _selectedService[petIndex] = null;
      additionalServiceReservationList[petIndex] = [];
      Map<String, dynamic> serviceStatic = {
        'service_id': "ID Penitipan",
        'quantity': "End date - Start date",
        'satuan': "malam",
      };

      additionalServiceReservationList[petIndex]?.add(serviceStatic);
    }

    print("TEXT $additionalServiceReservationList");
  }

  Future<void> fetchDropdown() async {
    try {
      List<Map<String, dynamic>> species = await TesSpecies.getSpecies();
      List<Map<String, dynamic>> petUser = await TesSpecies.getPetUser();
      List<Map<String, dynamic>> petService =
          await TesSpecies.getService(widget.formData['hotel_id']);
      // Map<String, dynamic> petService = await TesSpecies.fetchData();
      // print("service: $petService");
      setState(() {
        speciesList = species;
        serviceList = petService;
        petUserList = petUser;
        // print("species: $petUserList");
      });
    } catch (error) {
      print('Failed to fetch dropdown: $error');
    }
  }

  @override
  void dispose() {
    for (var controller in diseaseHistoryControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addService() {
    Map<String, dynamic> newService = {
      'layanan': null,
      'quantity': null,
    };
    setState(() {
      additionalServices.add(newService);
    });
  }

  void _handleSubmit() {
    List<Map<String, dynamic>> serviceReservationList = [];

    for (var petIndex in qtyPetTotal) {
      String? petService = _selectedService[petIndex];

      Map<String, dynamic> serviceData = {
        'service_id': "ID Penitipan",
        'quantity': "End date - Start date",
        'satuan': "malam",
      };

      serviceReservationList.add(serviceData);
    }
    print(serviceReservationList);

    // Menambahkan data dari layanan tambahan
    for (var service in additionalServices) {
      String? layanan = service['id_service'];
      String? quantity = service['quantity'];

      Map<String, dynamic> serviceData = {
        'service_id': layanan,
        'quantity': quantity,
        'satuan': 'malam',
      };

      serviceReservationList.add(serviceData);
    }

    List<Map<String, dynamic>> petDataList = [];

    for (var petIndex in qtyPetTotal) {
      String diseaseHistory = diseaseHistoryControllers[petIndex]!.text;
      String? statusVaccine = selectedStatusVaccine[petIndex];
      String? statusAllergy = selectedStatusAllergy[petIndex];
      String? species = _selectedSpecies[petIndex];
      String? pet = _selectedPet[petIndex];

      Map<String, dynamic> petData = {
        'jenis hewan': species!,
        'hewan': pet!,
        'Vaksinasi': statusVaccine!,
        'Alergi': statusAllergy!,
        'Riwayat Penyakit Lain': diseaseHistory,
        'Layanan': serviceReservationList,
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
    print(qtyPetTotal);
    // List<Widget> formWidgets = [];
    // Formulir tambahan untuk layanan
    // for (int i = 0; i < additionalServices.length; i++) {
    //   Map<String, dynamic> service = additionalServices[i];
    //   String? layanan = service['id_service'];
    //   String? quantity = service['quantity'];
    //
    //   Widget additionalServiceForm = Card(
    //     child: ListTile(
    //       title: Text('Layanan Tambahan ${i + 1}'),
    //       subtitle: Column(
    //         children: [
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               const Text(
    //                 "Layanan",
    //                 textAlign: TextAlign.start,
    //                 style: TextStyle(
    //                     fontSize: 12,
    //                     fontWeight: FontWeight.w600
    //                 ),
    //               ),
    //               const SizedBox(height: 5),
    //               DropdownButtonFormField<String>(
    //                 decoration: InputDecoration(
    //                   contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    //                   enabledBorder: OutlineInputBorder(
    //                     borderRadius: BorderRadius.circular(8),
    //                     borderSide: BorderSide(color: globalColors.textBlackBold),
    //                   ),
    //                   focusedBorder: OutlineInputBorder(
    //                     borderRadius: BorderRadius.circular(8),
    //                     borderSide: const BorderSide(color: Color(0xFFDC822A)),
    //                   ),
    //                 ),
    //                 hint: const Text('Jenis Hewan'),
    //                 value: layanan,
    //                 items: serviceList.map((service) {
    //                   String id = service['id_service'].toString();
    //                   String name = service['name'].toString();
    //                   return DropdownMenuItem<String>(
    //                     value: id,
    //                     child: Text(name),
    //                   );
    //                 }).toList(),
    //                 onChanged: (String? value) {
    //                   setState(() {
    //                     service['id_service'] = value;
    //                   });
    //                 },
    //               ),
    //             ],
    //           ),
    //           const SizedBox(height: 16),
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               const Text(
    //                 "Quantitiy",
    //                 textAlign: TextAlign.start,
    //                 style: TextStyle(
    //                     fontSize: 12,
    //                     fontWeight: FontWeight.w600
    //                 ),
    //               ),
    //               const SizedBox(height: 5),
    //               TextField(
    //                 controller: TextEditingController(text: quantity),
    //                 onChanged: (value) {
    //                   service['quantity'] = value;
    //                 },
    //                 decoration: InputDecoration(
    //                   contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    //                   enabledBorder: OutlineInputBorder(
    //                     borderRadius: BorderRadius.circular(8),
    //                     borderSide: BorderSide(color: globalColors.textBlackSmall),
    //                   ),
    //                   focusedBorder: OutlineInputBorder(
    //                     borderRadius: BorderRadius.circular(8),
    //                     borderSide: BorderSide(color: globalColors.bgOrange),
    //                   ),
    //                   hintText: "Riwayat Penyakit ",
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    //
    //   formWidgets.add(additionalServiceForm);
    // }
    //
    // // Tombol "Tambah Layanan"
    // Widget addServiceButton = ElevatedButton(
    //   onPressed: _addService,
    //   child: Text('Tambah Layanan'),
    // );
    //
    // formWidgets.add(addServiceButton);

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
                        "Jenis Hewan",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: globalColors.textBlackBold),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xFFDC822A)),
                          ),
                        ),
                        hint: const Text('Jenis Hewan'),
                        value: _selectedSpecies[
                            petIndex], // Set initial value or use `null` to show an empty dropdown
                        items: speciesList.map((species) {
                          String id_species = species['id_species'].toString();
                          String name = species['name'].toString();
                          return DropdownMenuItem<String>(
                            value: id_species,
                            child: Text(name),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _selectedSpecies[petIndex] = value;
                            temporarySelectedSpecies = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hewan",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: globalColors.textBlackBold),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xFFDC822A)),
                          ),
                        ),
                        hint: const Text('Hewan'),
                        value: _selectedPet[
                            petIndex], // Set initial value or use `null` to show an empty dropdown
                        items: petUserList.map((petUser) {
                          String idPet = petUser['id_pet'].toString();
                          String name = petUser['name'].toString();
                          return DropdownMenuItem<String>(
                            value: idPet,
                            child: Text(name),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _selectedPet[petIndex] =
                                value; // Mengubah nilai jenis kelamin saat dipilih
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Status Vaksinasi",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 20, // Ubah ukuran container sesuai kebutuhan
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: statusVaccine.map((gender) {
                            return Row(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Radio<String>(
                                  value: gender,
                                  groupValue: selectedStatusVaccine[petIndex],
                                  onChanged: (value) {
                                    setState(() {
                                      selectedStatusVaccine[petIndex] = value;
                                    });
                                  },
                                ),
                                Text(gender),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Status Alergi",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 20, // Ubah ukuran container sesuai kebutuhan
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: statusAllergy.map((gender) {
                            return Row(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Radio<String>(
                                  value: gender,
                                  groupValue: selectedStatusAllergy[petIndex],
                                  onChanged: (value) {
                                    setState(() {
                                      selectedStatusAllergy[petIndex] = value;
                                    });
                                  },
                                ),
                                Text(gender),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Riwayat Penyakit Lain",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: diseaseHistoryControllers[petIndex],
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
                          hintText: "Riwayat Penyakit ",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                      height: 150,
                      padding: EdgeInsets.all(2.0.w),
                      child: ListView.builder(
                          itemCount: additionalServiceReservationList[petIndex]
                              ?.length,
                          itemBuilder: (context, index) {
                            final serviceIndex =
                                additionalServiceReservationList[index];
                            print(serviceIndex);
                            return Card(
                              child: ListTile(
                                title: Center(child: Text("Service")),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Layanan",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })),
                  // )
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
