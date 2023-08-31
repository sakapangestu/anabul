import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import '../../api/api_service.dart';
import '../../component/app_bar/app_bar_tittle.dart';
import '../../helper/global_colors.dart';

class MenuHelp extends StatefulWidget {
  const MenuHelp({super.key});

  @override
  _MenuHelpState createState() => _MenuHelpState();
}

class _MenuHelpState extends State<MenuHelp> {
  List<Map<String, dynamic>> menuHelp = [];
  List<bool> isExpandedList = [];
  GlobalColors globalColors = GlobalColors();

  @override
  void initState() {
    super.initState();
    fetchMenuHelp();
  }

  void _launchWhatsApp() async {
    final url = 'https://wa.me/6285872772318'; // Ganti dengan nomor telepon penerima yang dituju
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Tidak dapat membuka WhatsApp.");
    }
  }

  Future<void> fetchMenuHelp() async {
    final response = await http.get(
      Uri.parse('${BaseApi.baseUrlApi}app/question'),
    );
    var datas = jsonDecode(response.body);
    var question = datas['data']['data'];
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> listQuestion =
      List<Map<String, dynamic>>.from(question);
      List<bool> expandedList = List<bool>.filled(listQuestion.length, false);
      setState(() {
        menuHelp = listQuestion;
        isExpandedList = expandedList;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void togglePanel(int index) {
    setState(() {
      isExpandedList[index] = !isExpandedList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            title: "Bantuan",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Column(
            children: [
              Container(
                height: 50,
                margin: const EdgeInsets.only(bottom: 25),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/splash/app_logos_horizontal.png"),
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "Pertanyaan Seputar Anabul Hotel",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ExpansionPanelList(
                elevation: 1,
                animationDuration: const Duration(milliseconds: 300),
                dividerColor: Colors.grey.withOpacity(0.1),
                expandedHeaderPadding: const EdgeInsets.all(0),
                expansionCallback: (panelIndex, isExpanded) {
                  togglePanel(panelIndex);
                },
                children: menuHelp.map<ExpansionPanel>((dataHelp) {
                  final question = dataHelp['name'];
                  final answersList = dataHelp['answers'];
                  return ExpansionPanel(
                    headerBuilder: (context, isExpanded) => ListTile(
                      title: Text(
                        question,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: globalColors.textBlackBold,
                        ),
                      ),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
                      child: Column(
                        children: List.generate(answersList.length, (index) {
                          final answerData = answersList[index];
                          final answer = answerData['name'];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              answer,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                                color: globalColors.textBlackBold,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    isExpanded: isExpandedList[menuHelp.indexOf(dataHelp)],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 180,
        child: GestureDetector(
          onTap: () {
            _launchWhatsApp();
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: globalColors.bgOrangeDisabled,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 0.2, color: globalColors.bgOrange),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Ionicons.logo_whatsapp,
                  color: globalColors.bgOrange,
                  size: 18.sp,
                ),
                const SizedBox(width: 5),
                Text(
                  'Hubungi Kami',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: globalColors.bgOrange,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
