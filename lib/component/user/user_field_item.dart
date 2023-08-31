// import 'package:anabulhotel/helper/session.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../helper/global_colors.dart';
import '../../api/api_service.dart';

class UserFieldItem extends StatefulWidget {
  const UserFieldItem({
    Key? key,
  }) : super(key: key);

  @override
  _UserFieldItem createState() => _UserFieldItem();
}

class _UserFieldItem extends State<UserFieldItem> {
  final _nameController = TextEditingController();
  final _idCardController = TextEditingController();
  final _genderController = TextEditingController();
  final _numberPhoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  // void dispose() {
  //   // TODO: implement dispose
  //   _nameController.dispose();
  //   _idCardController.dispose();
  //   _genderController.dispose();
  //   _numberPhoneController.dispose();
  //   _emailController.dispose();
  //   _addressController.dispose();
  //   super.dispose();
  // }

  GlobalColors globalColors = GlobalColors();
  Color iconColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<Map<String, dynamic>?>(
        future: ApiService.getDataUser(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('No data'));
          } else {
            Map<String, dynamic>? data = snapshot.data!;
            // print(data);
            if (data != null) {
              _nameController.text = data['name'];
              _idCardController.text = data['nik'].toString();
              _genderController.text = data['gender'];
              _numberPhoneController.text = data['phone'].toString();
              _emailController.text = data['email'];
              _addressController.text = data['address'];
            }
            return Container(
              child: Column(
                children: [
                  //name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Nama",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        height: 40,
                        decoration: BoxDecoration(
                          // color: Color(0xFFD9D9D9).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Color(0xFFDC822A)),
                            ),
                            hintText: "Nama Lengkap",
                            fillColor: MaterialStateColor.resolveWith(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.focused)) {
                                return const Color(0xFFFFFFFF);
                              } else {
                                return const Color(0xFFD9D9D9).withOpacity(0.2);
                              }
                            }),
                            filled: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  //id card
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Nomor Identitas",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        height: 40,
                        decoration: BoxDecoration(
                          // color: Color(0xFFD9D9D9).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _idCardController,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Color(0xFFDC822A)),
                            ),
                            hintText: "Nomor Identitas",
                            fillColor: MaterialStateColor.resolveWith(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.focused)) {
                                return const Color(0xFFFFFFFF);
                              } else {
                                return const Color(0xFFD9D9D9).withOpacity(0.2);
                              }
                            }),
                            filled: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  //gender
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Jenis Kelamin",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        height: 40,
                        decoration: BoxDecoration(
                          // color: Color(0xFFD9D9D9).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _genderController,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Color(0xFFDC822A)),
                            ),
                            hintText: "Jenis Kelamin",
                            fillColor: MaterialStateColor.resolveWith(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.focused)) {
                                return const Color(0xFFFFFFFF);
                              } else {
                                return const Color(0xFFD9D9D9).withOpacity(0.2);
                              }
                            }),
                            filled: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  //number phone
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Nomor Handphone",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      //email
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        height: 40,
                        decoration: BoxDecoration(
                          // color: Color(0xFFD9D9D9).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _numberPhoneController,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Color(0xFFDC822A)),
                            ),
                            hintText: "Nomor Handphone",
                            fillColor: MaterialStateColor.resolveWith(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.focused)) {
                                return const Color(0xFFFFFFFF);
                              } else {
                                return const Color(0xFFD9D9D9).withOpacity(0.2);
                              }
                            }),
                            filled: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  //email
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Email",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      //email
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        height: 40,
                        decoration: BoxDecoration(
                          // color: Color(0xFFD9D9D9).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Color(0xFFDC822A)),
                            ),
                            hintText: "Email",
                            fillColor: MaterialStateColor.resolveWith(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.focused)) {
                                return const Color(0xFFFFFFFF);
                              } else {
                                return const Color(0xFFD9D9D9).withOpacity(0.2);
                              }
                            }),
                            filled: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  //address
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Alamat Lengkap",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        height: 40,
                        decoration: BoxDecoration(
                          // color: Color(0xFFD9D9D9).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Color(0xFFDC822A)),
                            ),
                            hintText: "Alamat Lengkap",
                            fillColor: MaterialStateColor.resolveWith(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.focused)) {
                                return const Color(0xFFFFFFFF);
                              } else {
                                return const Color(0xFFD9D9D9).withOpacity(0.2);
                              }
                            }),
                            filled: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
