// import 'package:anabulhotel/helper/session.dart';
// import 'package:anabulhotel/screen/dashboard/dashboard_pageview.dart';
// import 'package:anabulhotel/screen/forgot/forgot_email.dart';
// import 'package:anabulhotel/screen/login/signup.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../component/login/forgot_button.dart';
import '../../component/login/login_button.dart';
import '../../component/login/login_register_button.dart';
import '../../component/login/login_title.dart';
import '../../api/api_service.dart';
import '../../helper/session.dart';
import '../dashboard/dashboard_pageview.dart';
import '../dashboard/dashboard_pageview_staff.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<LoginScreen> {
  //controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _emailError = "";
  String _passwordError = "";
  bool _validateInputs() {
    bool isValid = true;
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
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
    return isValid;
  }

  Color iconColor = Colors.grey;
  Color iconColor1 = Colors.grey;
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoginTitle(title: "Login"),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(children: [
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
                        child: Focus(
                          onFocusChange: (hasFocus) {
                            if (hasFocus) {
                              iconColor = const Color(0xFFDC822A);
                            } else {
                              iconColor = Colors.grey;
                            }
                            setState(() {});
                          },
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
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
                              // focusColor: Colors.black,
                              prefixIcon: Icon(
                                Icons.email,
                                size: 20,
                                color: iconColor,
                              ),
                              hintText: "Email",
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
                      ),
                      const SizedBox(height: 2),
                      //error field email
                      Text(
                        _emailError,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
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
                                  iconColor1 = const Color(0xFFDC822A);
                                } else {
                                  iconColor1 = Colors.grey;
                                }
                                setState(() {});
                              },
                              child: TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
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
                                  prefixIcon: Icon(
                                    Icons.lock_rounded,
                                    size: 20,
                                    color: iconColor1,
                                  ),
                                  hintText: 'Password',
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
                                      color: iconColor1,
                                    ),
                                  ),
                                ),
                                obscureText: !_passwordVisible,
                                keyboardType: TextInputType.emailAddress,
                              )),
                          //error field password
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _passwordError,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ]),
                ),
              ]),
            ),
            const SizedBox(height: 5),
            const ForgotButton(title: "Lupa Password?"),
            // GestureDetector(
            //   onTap: () async {
            //     String email = _emailController.text.trim();
            //     String password = _passwordController.text.trim();
            //     print(email);
            //     print(password);
            //     if (_validateInputs()){
            //       var result = await ApiService.loginUser(email, password);
            //       print(result);
            //       if (result != null) {
            //         SessionManager.saveToken(result);
            //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardPageView()));
            //       } else {
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           const SnackBar(content: Center(child: Text('Gagal Login'))),
            //         );
            //       }
            //     }
            //   },
            //   child: const LoginButton(title: "Login",),
            // ),
            GestureDetector(
              onTap: () async {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();
                // String? fcmToken = await FirebaseMessaging.instance.getToken();
                print(email);
                print(password);
                // print("token fcm: $fcmToken");
                if (_validateInputs()) {
                  var result =
                      // await ApiService.loginUser(email, password, fcmToken!);
                      await ApiService.loginUser(email, password);
                  print(result);
                  // if (result['status'] == true) {
                  //   String? fcmToken =
                  //       await FirebaseMessaging.instance.getToken();
                  //   String token = result['data']['token'];
                  //   String idUser = result['data']['id'];
                  //   print("object id: $idUser");
                  //   print("token user: $fcmToken");
                  //   await ApiService.tokenDevice(idUser, fcmToken!);
                  // }
                  if (result['status'] == true) {
                    SessionManager.saveToken(result);
                    String role = result['data']
                        ['role']; // Mendapatkan nilai peran dari hasil login
                    print("role : $role");
                    if (role == 'Customer') {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashboardPageView(
                                    initialIndex: 0,
                                  )));
                    } else if (role == 'Staff') {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DashboardPageViewStaff())); // Ganti 'DashboardStaff' dengan halaman yang sesuai untuk dashboard staff
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Center(child: Text('Gagal Login'))),
                    );
                  }
                }
              },
              child: const LoginButton(title: "Login"),
            ),
            const RegisterButton(title: "Daftar Sekarang!"),
          ],
        ),
      ),
    );
  }
}
