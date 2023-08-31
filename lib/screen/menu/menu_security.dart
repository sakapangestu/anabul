// import 'package:anabulhotel/api/api_service.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/api_service.dart';
import '../../component/app_bar/app_bar_tittle.dart';
import '../../component/button/rectangle/rectangle_orange.dart';
import '../../component/login/slidding_send_email.dart';
import '../../helper/global_colors.dart';
import 'menu_panel_success_security.dart';

class MenuSecurity extends StatefulWidget {
  @override
  _MenuSecurityState createState() => _MenuSecurityState();
}

class _MenuSecurityState extends State<MenuSecurity> {
  GlobalColors globalColors = GlobalColors();
  PanelController pc = PanelController();
  final _passwordOldController = TextEditingController();
  final _passwordNewController = TextEditingController();
  final _passwordNewConfirmController = TextEditingController();
  Color iconColorPasswordOld = Colors.grey;
  Color iconColorPassword = Colors.grey;
  Color iconColorConfirmPassword = Colors.grey;
  bool _passwordOldVisible = false;
  bool _passwordNewVisible = false;
  bool _passwordNewConfirmVisible = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordOldController.dispose();
    _passwordNewController.dispose();
    _passwordNewConfirmController.dispose();
    super.dispose();
  }

  String _passwordOldError = "";
  String _passwordNewError = "";
  String _passwordNewConfirmError = "";
  bool _validateInputs() {
    bool isValid = true;
    // validasi password
    if (_passwordOldController.text.trim().isEmpty) {
      setState(() {
        _passwordOldError = "Password lama harus diisi";
      });
      isValid = false;
    } else {
      setState(() {
        _passwordOldError = "";
      });
    }
    // validasi password
    if (_passwordNewController.text.trim().isEmpty) {
      setState(() {
        _passwordNewError = "Password baru harus diisi";
      });
      isValid = false;
    } else if (_passwordNewController.text.trim().length < 8) {
      setState(() {
        _passwordNewError = "Password kurang dari 8 karakter";
      });
      isValid = false;
    } else {
      setState(() {
        _passwordNewError = "";
      });
    }
    // validasi confirm password
    if (_passwordNewConfirmController.text.trim().isEmpty) {
      setState(() {
        _passwordNewConfirmError = "Password Konfirmasi baru harus diisi";
      });
      isValid = false;
    } else if (_passwordNewConfirmController.text.trim() !=
        _passwordNewController.text.trim()) {
      setState(() {
        _passwordNewConfirmError = "Password baru yang dimasukan tidak sesuai";
      });
      isValid = false;
    } else {
      setState(() {
        _passwordNewConfirmError = "";
      });
    }
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      panelBuilder: (ScrollController sc) => MenuPanelSuccessSecurity(
        pc: pc,
      ),
      controller: pc,
      isDraggable: true,
      maxHeight: 30.h,
      minHeight: 0,
      backdropEnabled: true,
      backdropTapClosesPanel: false,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      body: Scaffold(
        resizeToAvoidBottomInset: true,
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
              title: "Keamanan",
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Ganti Password",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 15),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 0.5, color: globalColors.textBlackBold))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Password Lama",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    //email
                    Container(
                      child: Focus(
                          onFocusChange: (hasFocus) {
                            if (hasFocus) {
                              iconColorPasswordOld = const Color(0xFFDC822A);
                            } else {
                              iconColorPasswordOld = Colors.grey;
                            }
                            setState(() {});
                          },
                          child: TextFormField(
                            controller: _passwordOldController,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                // borderSide: const BorderSide(
                                //     color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Color(0xFFDC822A)),
                              ),
                              focusColor: Colors.white,
                              hintText: 'Password Lama',
                              fillColor: MaterialStateColor.resolveWith(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.focused)) {
                                  return const Color(0xFFFFFFFF);
                                } else {
                                  return const Color(0xFFFFFFFF);
                                }
                              }),
                              filled: true,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordOldVisible = !_passwordOldVisible;
                                  });
                                },
                                icon: Icon(
                                  _passwordOldVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: iconColorPasswordOld,
                                ),
                              ),
                            ),
                            obscureText: !_passwordOldVisible,
                            keyboardType: TextInputType.emailAddress,
                          )),
                    ),
                    const SizedBox(height: 2),
                    //password field email
                    Text(
                      _passwordOldError,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Password Baru",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  //email
                  Container(
                    child: Focus(
                        onFocusChange: (hasFocus) {
                          if (hasFocus) {
                            iconColorConfirmPassword = const Color(0xFFDC822A);
                          } else {
                            iconColorConfirmPassword = Colors.grey;
                          }
                          setState(() {});
                        },
                        child: TextFormField(
                          controller: _passwordNewController,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              // borderSide: const BorderSide(
                              //     color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Color(0xFFDC822A)),
                            ),
                            focusColor: Colors.white,
                            hintText: 'Password Baru',
                            fillColor: MaterialStateColor.resolveWith(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.focused)) {
                                return const Color(0xFFFFFFFF);
                              } else {
                                return const Color(0xFFFFFFFF);
                              }
                            }),
                            filled: true,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _passwordNewVisible = !_passwordNewVisible;
                                });
                              },
                              icon: Icon(
                                _passwordNewVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: iconColorConfirmPassword,
                              ),
                            ),
                          ),
                          obscureText: !_passwordNewVisible,
                          keyboardType: TextInputType.emailAddress,
                        )),
                  ),
                  const SizedBox(height: 2),
                  //password field email
                  Text(
                    _passwordNewError,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Konfirmasi Password Baru",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  //email
                  Container(
                    child: Focus(
                        onFocusChange: (hasFocus) {
                          if (hasFocus) {
                            iconColorPassword = const Color(0xFFDC822A);
                          } else {
                            iconColorPassword = Colors.grey;
                          }
                          setState(() {});
                        },
                        child: TextFormField(
                          controller: _passwordNewConfirmController,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              // borderSide: const BorderSide(
                              //     color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Color(0xFFDC822A)),
                            ),
                            focusColor: Colors.white,
                            hintText: 'Konfirmasi Password Baru',
                            fillColor: MaterialStateColor.resolveWith(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.focused)) {
                                return const Color(0xFFFFFFFF);
                              } else {
                                return const Color(0xFFFFFFFF);
                              }
                            }),
                            filled: true,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _passwordNewConfirmVisible =
                                      !_passwordNewConfirmVisible;
                                });
                              },
                              icon: Icon(
                                _passwordNewConfirmVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: iconColorPassword,
                              ),
                            ),
                          ),
                          obscureText: !_passwordNewConfirmVisible,
                          keyboardType: TextInputType.emailAddress,
                        )),
                  ),
                  const SizedBox(height: 2),
                  //password field email
                  Text(
                    _passwordNewConfirmError,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
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
                pc.open();
                // if (_validateInputs()) {
                //   try {
                //     final passOld = _passwordOldController.text.trim();
                //     final passNew = _passwordNewController.text.trim();
                //     final passNewConf =
                //         _passwordNewConfirmController.text.trim();

                // print(
                //     "pass old: $passOld, pass new: $passNew, pass new conf: $passNewConf");
                // final result = await ApiService.changePassword(
                //     passOld, passNew, passNewConf);
                // print("result change: $result");
                // if (result['status'] == true) {
                //   pc.open();
                // }
                // await ApiService.createPet(namePet, speciesId, genderPet, favFood, birthPet, selectedImage);
                // if (_validateInputs()) {
                //   var result = await ApiService.createPet(namePet, speciesId, genderPet, favFood, birthPet, selectedImage);
                //   print(result);
                //   setState(() {
                //     _switchPanelCondition = true;
                //     pc.open();
                //   });
                // }
                // } catch (e) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text('$e')),
                //   );
                // }
                // }
              },
              child: const RectangleOrange(
                title: "Submit",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
