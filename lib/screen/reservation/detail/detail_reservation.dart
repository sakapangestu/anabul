import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';

import '../../../api/api_service.dart';
import '../../../component/app_bar/app_bar_tittle.dart';
import '../../../component/button/rounded/rounded_orange.dart';
import '../../../component/button/rounded/rounded_orange_disabled.dart';
import '../../../helper/global_colors.dart';
import '../../dashboard/dashboard_pageview.dart';

class DetailReservation extends StatefulWidget {
  final Map<String, dynamic> formData;

  const DetailReservation({super.key, required this.formData});

  @override
  __DetailReservationState createState() => __DetailReservationState();
}

class __DetailReservationState extends State<DetailReservation> {
  GlobalColors globalColors = GlobalColors();
  List<Map> petList = [];
  List<Map<String, dynamic>> petUserList = [];
  List<Map<String, dynamic>> servicesList = [];
  List<Map<String, dynamic>> productsList = [];
  List<Map<String, dynamic>> cageDetailList = [];
  Map<String, String?> _selectedPetUser = {};
  Map<String, String?> _selectedCageDetail = {};
  Map<String, String?> _selectedPetService = {};
  Map<String, String?> _selectedPetProduct = {};
  Map<String, String?> tempDataReservation = {};
  String? temporarySelectedService;
  String? temporarySelectedProduct;
  String? temporarySelectedPetUser;
  String? temporarySelectedCage;

  List<String> statusVaccine = ['Sudah', 'Belum'];
  List<String> statusFleaDisease = ['Iya', 'Tidak'];
  Map<String, List<Map>> serviceList = {};
  Map<String, List<Map>> productList = {};

  @override
  void initState() {
    super.initState();
    fetchDropdown();
    // print(fetchDropdown());
    for (int i = 0; i < widget.formData['qtyPet']; i++) {
      var petData = {};
      petData['pet_id'] = '';
      petData['weight'] = 0;
      petData['cage_detail_id'] = '';
      petData['vaccination'] = '';
      petData['flea_disease'] = '';
      petData['allergy'] = '';
      petData['another_disease'] = '';
      petData['reservation_services'] = [];
      petData['reservation_products'] = [];

      // Map<String, dynamic> petData = {
      //   'pet_id': '',
      //   'weight': '',
      //   'species_id': '',
      //   'cage_detail_id': '',
      //   'vaccination' : '',
      //   'food_allergy' : '',
      //   'flea_disease' : '',
      //   'another_disease' : '',
      //   'reservation_service': [],
      //   'reservation_product': [],
      // };
      petList.add(petData);

      String petName = 'Hewan ${i + 1}';
      serviceList[petName] = [];
      productList[petName] = [];
      _selectedPetUser[petName] = null;
    }
  }

  Future<void> fetchDropdown() async {
    var tempIdHotel = widget.formData['hotel_id'];
    try {
      List<Map<String, dynamic>> petUser = await TesSpecies.getPetUser();
      List<Map<String, dynamic>> petService =
          await TesSpecies.getService(tempIdHotel);
      List<Map<String, dynamic>> petProduct =
          await TesSpecies.getProduct(tempIdHotel);
      List<Map<String, dynamic>> cageDetail =
          await TesSpecies.getCage(tempIdHotel);

      setState(() {
        servicesList = petService;
        productsList = petProduct;
        petUserList = petUser;
        cageDetailList = cageDetail;
        // print("cage detail: $cageDetailList");
      });
    } catch (error) {
      print('Failed to fetch dropdown: $error');
    }
  }

  void addService(String petName) {
    setState(() {
      serviceList[petName]!.add({});
    });
  }

  void removeService(String petName, int index) {
    setState(() {
      serviceList[petName]!.removeAt(index);
    });
  }

  void addProduct(String petName) {
    setState(() {
      productList[petName]!.add({});
    });
  }

  void removeProduct(String petName, int index) {
    setState(() {
      productList[petName]!.removeAt(index);
    });
  }

  Future<void> _handleSubmit() async {
    for (int i = 0; i < petList.length; i++) {
      String petName = 'Hewan ${i + 1}';
      var tempStartDate = widget.formData['start_date'];
      var tempEndDate = widget.formData['end_date'];
      DateTime startDate = DateTime.parse(tempStartDate);
      DateTime endDate = DateTime.parse(tempEndDate);
      Duration difDate = endDate.difference(startDate);
      String tempDateLength = difDate.inDays.toString();
      Map<String, dynamic>? penitipanService =
          servicesList.firstWhere((service) => service['name'] == 'Penitipan');
      String tempIdService = penitipanService['id_service'];
      if (serviceList[petName]!.isEmpty) {
        var serviceData = {};
        serviceData['service_id'] = tempIdService;
        serviceData['quantity'] = int.parse(tempDateLength);
        serviceList[petName]!.add(serviceData);
        petList[i]['reservation_services'] = serviceList[petName]!;
      } else if (serviceList[petName]!.isNotEmpty) {
        var serviceData = {};
        serviceData['service_id'] = tempIdService;
        serviceData['quantity'] = int.parse(tempDateLength);
        serviceList[petName]!.add(serviceData);
        petList[i]['reservation_services'] = serviceList[petName]!;
      }

      if (productList[petName]!.isNotEmpty) {
        petList[i]['reservation_products'] = productList[petName]!;
      }
    }
    String tempHotelId = widget.formData['hotel_id'].toString();
    String tempUserId = widget.formData['user_id'].toString();
    String tempStartDate = widget.formData['start_date'].toString();
    String tempEndDate = widget.formData['end_date'].toString();
    String tempAgreement = widget.formData['agreement'].toString();
    String petLists = jsonEncode(petList);
    var newDataMap = {};
    newDataMap['hotel_id'] = tempHotelId;
    newDataMap['user_id'] = tempUserId;
    newDataMap['start_date'] = tempStartDate;
    newDataMap['end_date'] = tempEndDate;
    newDataMap['reservation_status'] = "Proses";
    newDataMap['agreement'] = tempAgreement.toString() == "true" ? true : false;
    newDataMap['reservation_details'] = petList;
    try {
      var resultReservasi = await TesSpecies.reservation(newDataMap);
      // print(newDataMap);
      // if (resultReservasi['status'] == true) ;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => DashboardPageView(
                    initialIndex: 0,
                  )));
    } catch (e) {
      print('Terjadi kesalahan saat mengirim data: $e');
    }
  }

  Widget buildServiceForm(String petName) {
    List<Map> services = serviceList[petName]!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          for (int i = 0; i < services.length; i++) ...[
            Text(
              'Layanan Tambahan ${i + 1}',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Layanan Tambahan",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                //pengecuali "Penitipan"
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: globalColors.textBlackBold),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFDC822A)),
                    ),
                  ),
                  hint: const Text('Layanan'),
                  value: _selectedPetService[services],
                  items: servicesList
                      .where((service) =>
                          service['name'].toString() != 'Penitipan')
                      .map((service) {
                    String id_service = service['id_service'].toString();
                    String name = service['name'].toString();
                    return DropdownMenuItem<String>(
                      value: id_service,
                      child: Text(name),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      services[i]['service_id'] = value;
                      temporarySelectedService = value!;
                      print("value set: $temporarySelectedService");
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Quantity",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      services[i]['quantity'] = int.parse(value);
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: globalColors.textBlackSmall),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: globalColors.bgOrange),
                    ),
                    hintText: "Masukkan Quantitiy",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () => removeService(petName, i),
              child: const Text('Hapus Layanan'),
            ),
          ],
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            height: 5.h,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: globalColors.borderLine, width: 0.5))),
            child: GestureDetector(
              onTap: () => addService(petName),
              child: const RoundedOrangeDisabled(
                title: "tambah layanan",
              ),
            ),
          ),
          // ElevatedButton(
          //   onPressed: () => addService(petName),
          //   child: Text('Tambah Layanan'),
          // ),
        ],
      ),
    );
  }

  Widget buildProductForm(String petName) {
    List<Map> products = productList[petName]!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          for (int i = 0; i < products.length; i++) ...[
            Text(
              'Makanan ${i + 1}',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Makanan Tambahan",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: globalColors.textBlackBold),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFDC822A)),
                    ),
                  ),
                  hint: const Text('Product'),
                  value: _selectedPetProduct[products],
                  items: productsList.map((product) {
                    String id_product = product['id_product'].toString();
                    String name = product['name'].toString();
                    return DropdownMenuItem<String>(
                      value: id_product,
                      child: Text(name),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    print("select produk : $_selectedPetProduct");
                    // print("value $value");
                    setState(() {
                      products[i]['product_id'] = value;
                      temporarySelectedProduct = value!;
                      print("value set: $temporarySelectedProduct");
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Quantity",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      products[i]['quantity'] = int.parse(value);
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: globalColors.textBlackSmall),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: globalColors.bgOrange),
                    ),
                    hintText: "Masukkan Quantitiy",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () => removeProduct(petName, i),
              child: const Text('Hapus Makanan'),
            ),
          ],
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            height: 5.h,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: globalColors.borderLine, width: 0.5))),
            child: GestureDetector(
              onTap: () => addProduct(petName),
              child: const RoundedOrangeDisabled(
                title: "tambah makanan",
              ),
            ),
          ),
          // ElevatedButton(
          //   onPressed: () => addService(petName),
          //   child: Text('Tambah Layanan'),
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Agreement: ${widget.formData['agreement']}");
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
            title: "Detail Reservasi",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
          child: Column(
            children: [
              for (int i = 0; i < petList.length; i++) ...[
                Text(
                  'Hewan ${i + 1}',
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hewan",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
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
                      hint: const Text('Pilih Hewan'),
                      value: _selectedPetUser[
                          petList], // Set initial value or use `null` to show an empty dropdown
                      items: petUserList.map((petUser) {
                        String idPet = petUser['id_pet'].toString();
                        String name = petUser['name'].toString();
                        return DropdownMenuItem<String>(
                          value: idPet,
                          child: Text(name),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        print("pet select: ${_selectedPetUser[petList]}");
                        setState(() {
                          petList[i]['pet_id'] = value;
                          temporarySelectedPetUser = value!;
                          print("value pet: $temporarySelectedProduct");
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
                      "Berat",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          petList[i]['weight'] = double.parse(value);
                        });
                      },
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
                          borderSide: BorderSide(color: globalColors.bgOrange),
                        ),
                        hintText: "Berat",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Jenis Kandang",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
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
                      hint: const Text('Pilih Kandang'),
                      value: _selectedCageDetail[
                          petList], // Set initial value or use `null` to show an empty dropdown
                      items: cageDetailList.map((cageDetail) {
                        String idCageSelected =
                            cageDetail['id_cage_detail'].toString();
                        String nameCageCategory =
                            cageDetail['cage_category']['name'].toString();
                        String nameCageType =
                            cageDetail['cage_type']['name'].toString();
                        return DropdownMenuItem<String>(
                          value: idCageSelected,
                          child: Text("$nameCageCategory - $nameCageType"),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          petList[i]['cage_detail_id'] = value;
                          temporarySelectedCage = value!;
                          // print("kandang dipilih : $temporarySelectedCage");
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 20, // Ubah ukuran container sesuai kebutuhan
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: statusVaccine.map((String vaccine) {
                          return Row(
                            // mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Radio<String>(
                                value: vaccine,
                                groupValue: petList[i]['vaccination'],
                                onChanged: (value) {
                                  setState(() {
                                    petList[i]['vaccination'] = value;
                                  });
                                },
                              ),
                              Text(vaccine),
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
                      "Penyakit Kutu",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 20, // Ubah ukuran container sesuai kebutuhan
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: statusFleaDisease.map((String allergy) {
                          return Row(
                            // mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Radio<String>(
                                value: allergy,
                                groupValue: petList[i]['flea_disease'],
                                onChanged: (value) {
                                  setState(() {
                                    petList[i]['flea_disease'] = value;
                                  });
                                },
                              ),
                              Text(allergy),
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          petList[i]['another_disease'] = value;
                        });
                      },
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
                          borderSide: BorderSide(color: globalColors.bgOrange),
                        ),
                        hintText: "Riwayat Penyakit ",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Riwayat Alergi",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          petList[i]['allergy'] = value;
                        });
                      },
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
                          borderSide: BorderSide(color: globalColors.bgOrange),
                        ),
                        hintText: "Riwayat Alergi",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        "Layanan",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Center(child: buildServiceForm('Hewan ${i + 1}')),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        "Makanan",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Center(child: buildProductForm('Hewan ${i + 1}')),
                  ],
                ),
                const SizedBox(height: 16),
              ],
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
            onTap: _handleSubmit,
            child: RoundedOrange(
              title: "Submit",
            ),
          ),
        ),
      ),
    );
  }
}
