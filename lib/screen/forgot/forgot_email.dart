// import 'package:anabulhotel/component/button/rounded/rounded_orange.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
// import 'package:anabulhotel/screen/forgot/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../api/api_service.dart';
import '../../component/button/rounded/rounded_orange.dart';
import '../../component/button/rounded/rounded_orange_disabled.dart';
import '../../component/login/login_button.dart';
import '../../component/login/slidding_send_email.dart';
import 'package:http/http.dart' as http;

import '../../helper/global_colors.dart';

class ForgotEmail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<ForgotEmail> {
  //controller
  final _emailController = TextEditingController();
  String? emailConf;
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
    _emailController.dispose();
    super.dispose();
  }

  Widget initWidget() {
    GlobalColors globalColors = GlobalColors();
    PanelController pc = PanelController();

    return SlidingUpPanel(
      panelBuilder: (ScrollController sc) => UserPanelSendEmail(
        pc: pc,
        email: _emailController.text.toString(),
      ),
      controller: pc,
      isDraggable: true,
      maxHeight: 35.h,
      minHeight: 0,
      backdropEnabled: true,
      backdropTapClosesPanel: true,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      body: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          child: SingleChildScrollView(
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
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Email",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          //email
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: globalColors.textBlackSmall),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: globalColors.bgOrange),
                              ),
                              hintText: "example@email.com",
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
                      onTap: () async {
                        final tempEmailForgot = _emailController.text.trim();
                        print("email: $tempEmailForgot");
                        final url =
                            Uri.parse('${BaseApi.baseUrlApi}auth/forgotpass');
                        try {
                          final response = await http.post(
                            url,
                            body: {'email': tempEmailForgot},
                          );
                          if (response.statusCode == 200) {
                            print('API request successful');
                            Navigator.pushNamed(context, '/login');
                          } else {
                            print(
                                'API request failed with status code: ${response.statusCode}');
                          }
                        } catch (e) {
                          print('Error making API request: $e');
                        }
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
        ),
      ),
    );
  }
}
