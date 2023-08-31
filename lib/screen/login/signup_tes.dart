// import 'package:anabulhotel/component/register/register_title.dart';
// import 'package:anabulhotel/api/api_service.dart';
// import 'package:anabulhotel/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/api_service.dart';
import '../../component/register/register_button.dart';
import '../../component/register/register_title.dart';

class SignUpTes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SignUpTes> {
  //controller
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  String _emailError = "";
  String _nameError = "";
  String _passwordError = "";
  String _passwordConfirmError = "";
  bool _validateInputs() {
    bool isValid = true;
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    // validasi email
    if (_nameController.text.trim().isEmpty) {
      setState(() {
        _nameError = "Nama harus diisi";
      });
      isValid = false;
      // } else if (!regex.hasMatch(_nameController.text.trim())) {
      //   setState(() {
      //     _nameError = "Nama tidak valid";
      //   });
      //   isValid = false;
    } else {
      setState(() {
        _nameError = "";
      });
    }
    // validasi email
    if (_emailController.text.trim().isEmpty) {
      setState(() {
        _emailError = "Email harus diisi";
      });
      isValid = false;
    } else if (!regex.hasMatch(_emailController.text.trim())) {
      setState(() {
        _emailError = "Email tidak valid";
      });
      isValid = false;
    } else {
      setState(() {
        _emailError = "";
      });
    }
    // validasi password
    if (_passwordController.text.trim().isEmpty) {
      setState(() {
        _passwordError = "Password harus diisi";
      });
      isValid = false;
    } else if (_passwordController.text.trim().length < 8) {
      setState(() {
        _passwordError = "Password kurang dari 8 karakter";
      });
      isValid = false;
    } else {
      setState(() {
        _passwordError = "";
      });
    }
    // validasi confirm password
    if (_passwordConfirmController.text.trim().isEmpty) {
      setState(() {
        _passwordConfirmError = "Password Konfirmasi harus diisi";
      });
      isValid = false;
    } else if (_passwordConfirmController.text.trim() !=
        _passwordController.text.trim()) {
      setState(() {
        _passwordConfirmError = "Password yang dimasukan tidak sesuai";
      });
      isValid = false;
    } else {
      setState(() {
        _passwordConfirmError = "";
      });
    }
    return isValid;
  }

  Color iconColorPassword = Colors.grey;
  Color iconColorConfirmPassword = Colors.grey;
  bool _passwordVisible = false;
  bool _passwordConfirmVisible = false;

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RegisterTitle(title: "Pendaftaran Akun"),
            SizedBox(height: 20),
            Column(
              children: [
                Container(
                  height: 80,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //label email
                        const Text(
                          "Nama",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 5),
                        //field email
                        Expanded(
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                // borderSide: const BorderSide(
                                //     color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Color(0xFFDC822A)),
                              ),
                              hintText: "Masukkan Nama Anda",
                              fillColor: MaterialStateColor.resolveWith(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.focused)) {
                                  return const Color(0xFFFFFFFF);
                                } else {
                                  return const Color(0xFFD9D9D9)
                                      .withOpacity(0.2);
                                }
                              }),
                              filled: true,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        //error field email
                        Text(
                          _nameError,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ]),
                ),
                Container(
                  height: 80,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //label email
                        const Text(
                          "Email",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 5),
                        //field email
                        Expanded(
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                // borderSide: const BorderSide(
                                //     color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Color(0xFFDC822A)),
                              ),
                              hintText: "Masukkan Email Anda",
                              fillColor: MaterialStateColor.resolveWith(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.focused)) {
                                  return const Color(0xFFFFFFFF);
                                } else {
                                  return const Color(0xFFD9D9D9)
                                      .withOpacity(0.2);
                                }
                              }),
                              filled: true,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        //error field email
                        Text(
                          _emailError,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ]),
                ),
                Container(
                  height: 80,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //label password
                        const Text(
                          "Password",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 5),
                        //field password
                        Expanded(
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
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    // borderSide: const BorderSide(
                                    //     color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Color(0xFFDC822A)),
                                  ),
                                  focusColor: Colors.white,
                                  hintText: 'Masukkan Password',
                                  fillColor: MaterialStateColor.resolveWith(
                                      (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.focused)) {
                                      return const Color(0xFFFFFFFF);
                                    } else {
                                      return const Color(0xFFD9D9D9)
                                          .withOpacity(0.2);
                                    }
                                  }),
                                  filled: true,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: iconColorPassword,
                                    ),
                                  ),
                                ),
                                obscureText: !_passwordVisible,
                                keyboardType: TextInputType.emailAddress,
                              )),
                          //error field password
                        ),
                        Text(
                          _passwordError,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ]),
                ),
                Container(
                  height: 80,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //label password
                        const Text(
                          "Password Konfirmasi",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 5),
                        //field password
                        Expanded(
                          child: Focus(
                              onFocusChange: (hasFocus) {
                                if (hasFocus) {
                                  iconColorConfirmPassword =
                                      const Color(0xFFDC822A);
                                } else {
                                  iconColorConfirmPassword = Colors.grey;
                                }
                                setState(() {});
                              },
                              child: TextFormField(
                                controller: _passwordConfirmController,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    // borderSide: const BorderSide(
                                    //     color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Color(0xFFDC822A)),
                                  ),
                                  focusColor: Colors.white,
                                  hintText: 'Masukkan Password Konfirmasi',
                                  fillColor: MaterialStateColor.resolveWith(
                                      (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.focused)) {
                                      return const Color(0xFFFFFFFF);
                                    } else {
                                      return const Color(0xFFD9D9D9)
                                          .withOpacity(0.2);
                                    }
                                  }),
                                  filled: true,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _passwordConfirmVisible =
                                            !_passwordConfirmVisible;
                                      });
                                    },
                                    icon: Icon(
                                      _passwordConfirmVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: iconColorConfirmPassword,
                                    ),
                                  ),
                                ),
                                obscureText: !_passwordConfirmVisible,
                                keyboardType: TextInputType.emailAddress,
                              )),
                          //error field password
                        ),
                        Text(
                          _passwordConfirmError,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ]),
                ),
              ],
            ),
            GestureDetector(
              onTap: () async {
                String name = _nameController.text.trim();
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();

                // print(name);
                // print(email);
                // print(password);
                //
                // print(_validateInputs());
                if (_validateInputs()) {
                  var result =
                      await ApiService.registerUser(name, email, password);
                  print(result);
                  // print(result.status);
                  if (result != null) {
                    Navigator.pushNamed(context, '/login');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Email sudah ada')),
                    );
                  }
                }
              },
              child: RegisterButton(title: "Daftar"),
            ),
          ],
        ),
      ),
    );
  }
}
