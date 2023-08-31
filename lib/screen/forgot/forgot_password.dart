// import 'package:anabulhotel/component/button/rounded/rounded_orange.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';

import '../../component/button/rounded/rounded_orange.dart';
import '../../component/button/rounded/rounded_orange_disabled.dart';
import '../../component/login/login_button.dart';
import '../../helper/global_colors.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<ForgotPassword> {
  //controller
  // final _emailController = TextEditingController();
  final _passwordNewController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  Color iconColorEmail = Colors.grey;
  Color iconColorPassword = Colors.grey;
  Color iconColorConfirmPassword = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _emailController.dispose();
    _passwordNewController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  Widget initWidget() {
    GlobalColors globalColors = GlobalColors();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 120, bottom: 20),
                        child: Image.asset(
                          "assets/splash/app_logos.png",
                          scale: 8,
                        )),
                  ],
                ),
                const Text(
                  "Lupa Password",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // const SizedBox(height: 16),
                  // Column  (
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     const Text(
                  //       "Email",
                  //       textAlign: TextAlign.start,
                  //       style: TextStyle(
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w600
                  //       ),
                  //     ),
                  //     const SizedBox(height: 5),
                  //     //email
                  //     TextField(
                  //       controller: _emailController,
                  //       decoration: InputDecoration(
                  //         contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  //         enabledBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(8),
                  //           borderSide: BorderSide(color: globalColors.textBlackSmall),
                  //         ),
                  //         focusedBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(8),
                  //           borderSide: BorderSide(color: globalColors.bgOrange),
                  //         ),
                  //         hintText: "example@email.com",
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Password Baru",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      //email
                      TextField(
                        controller: _passwordNewController,
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
                          hintText: "Password Baru",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Konfirmasi Password Baru",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      //email
                      TextField(
                        controller: _passwordConfirmController,
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
                          hintText: "Konfirmasi Password Baru",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginScreen()),
                    // );
                  },
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(top: 30),
                    child: const RoundedOrange(
                      title: "Simpan",
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(top: 10),
                    child: const RoundedOrangeDisabled(
                      title: "Kembali Ke Login",
                    ),
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
