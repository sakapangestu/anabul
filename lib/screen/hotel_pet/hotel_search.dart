// import 'package:flutter/material.dart';
// import 'package:ionicons/ionicons.dart';

// import '../../api/api_service.dart';
// import '../../component/app_bar/app_bar_tittle.dart';
// import '../../helper/global_colors.dart';
// import '../hotel_pet/hotel_list.dart';

// class HotelSearch extends StatefulWidget {
//   const HotelSearch({Key? key}) : super(key: key);

//   @override
//   State<HotelSearch> createState() => _HotelSearchState();
// }

// class _HotelSearchState extends State<HotelSearch> {
//   final TextEditingController _searchController = TextEditingController();
//   List<Map<String, dynamic>> _hotelList = [];
//   List<Map<String, dynamic>> _filteredHotelList = [];
//   GlobalColors globalColors = GlobalColors();

//   @override
//   void initState() {
//     super.initState();
//     _fetchHotelList();
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchHotelList() async {
//     try {
//       List<Map<String, dynamic>> hotelList = await Hotel.getHotel();
//       // print("object data hotel: $hotelList");
//       setState(() {
//         _hotelList = hotelList;
//         _filteredHotelList =
//             hotelList; // Menetapkan daftar hotel awal ke daftar hotel yang difilter
//       });
//     } catch (e) {
//       print('Error: $e');
//       // Handle error
//     }
//   }

//   void _filterHotelList(String query) {
//     List<Map<String, dynamic>> filteredList = [];

//     if (query.isEmpty) {
//       filteredList = List<Map<String, dynamic>>.from(_hotelList);
//     } else {
//       filteredList = _hotelList.where((hotel) {
//         final String hotelName = hotel['name'].toString().toLowerCase();
//         final String cityName = hotel['city']['name'].toString().toLowerCase();
//         return hotelName.contains(query.toLowerCase()) ||
//             cityName.contains(query.toLowerCase());
//       }).toList();
//     }

//     setState(() {
//       _filteredHotelList = filteredList;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context, '/dashboardPageView');
//           },
//         ),
//         backgroundColor: const Color(0xffDC822A),
//         flexibleSpace: const SafeArea(
//           child: AppBarTitle(
//             title: "Pencarian Hotel",
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Container(
//             padding:
//                 const EdgeInsets.only(right: 24, left: 24, top: 15, bottom: 15),
//             decoration: BoxDecoration(
//                 // color: Colors.red,
//                 border: Border(
//                     bottom: BorderSide(
//                         width: 0.5, color: globalColors.borderLine))),
//             // color: Colors.red,
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                   color: globalColors.bgOrangeDisabled,
//                   // color: Color(0xFFD9D9D9).withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(width: 0.1, color: globalColors.bgOrange)),
//               alignment: Alignment.center,
//               child: TextField(
//                 controller: _searchController,
//                 onChanged: (query) => _filterHotelList(query),
//                 decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 20),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(color: globalColors.bgOrange),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: const BorderSide(color: Color(0xFFDC822A)),
//                   ),
//                   hintText: "Search",
//                   suffixIcon: Icon(
//                     Ionicons.search_outline,
//                     color: globalColors.textGray,
//                   ),
//                   filled: true,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _filteredHotelList.length,
//               itemBuilder: (context, index) {
//                 final hotel = _filteredHotelList[index];
//                 print("hotel search: $hotel");
//                 final reservation = hotel['reservations'];
//                 print("reserv : $reservation");
//                 return Container(
//                   decoration: BoxDecoration(
//                       border: Border(
//                           bottom: BorderSide(
//                               width: 0.5, color: globalColors.borderLine))),
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 2, horizontal: 24),
//                   child: HotelList(hotels: hotel),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../api/api_service.dart';
import '../../component/app_bar/app_bar_tittle.dart';
import '../../component/hotel_pet/hotel_pet_filter_slidding.dart';
import '../../helper/global_colors.dart';
import '../hotel_pet/hotel_list.dart';

class HotelSearch extends StatefulWidget {
  const HotelSearch({Key? key}) : super(key: key);

  @override
  State<HotelSearch> createState() => _HotelSearchState();
}

class _HotelSearchState extends State<HotelSearch> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _hotelList = [];
  List<Map<String, dynamic>> _filteredHotelList = [];
  GlobalColors globalColors = GlobalColors();
  String? selectedCityFilter;
  // bool _switchPanelCondition = false;
  PanelController pc = PanelController();

  @override
  void initState() {
    super.initState();
    _fetchHotelList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchHotelList() async {
    try {
      List<Map<String, dynamic>> hotelList = await Hotel.getHotel();
      // print("object data hotel: $hotelList");
      setState(() {
        _hotelList = hotelList;
        _filteredHotelList =
            hotelList; // Menetapkan daftar hotel awal ke daftar hotel yang difilter
      });
    } catch (e) {
      print('Error: $e');
      // Handle error
    }
  }

  // void _filterHotelList(String query) {
  //   List<Map<String, dynamic>> filteredList = [];

  //   if (query.isEmpty) {
  //     filteredList = List<Map<String, dynamic>>.from(_hotelList);
  //   } else {
  //     filteredList = _hotelList.where((hotel) {
  //       final String hotelName = hotel['name'].toString().toLowerCase();
  //       return hotelName.contains(query.toLowerCase());
  //     }).toList();
  //   }

  //   setState(() {
  //     _filteredHotelList = filteredList;
  //   });
  // }

  void _filterHotelList(String query) {
    List<Map<String, dynamic>> filteredList = [];

    if (query.isEmpty) {
      filteredList = List<Map<String, dynamic>>.from(_hotelList);
    } else {
      filteredList = _hotelList.where((hotel) {
        final String hotelName = hotel['name'].toString().toLowerCase();
        return hotelName.contains(query.toLowerCase());
      }).toList();
    }

    // Terapkan filter berdasarkan kota hotel (selectedCityFilter) jika ada yang dipilih
    if (selectedCityFilter != null && selectedCityFilter!.isNotEmpty) {
      filteredList = filteredList.where((hotel) {
        final String city = hotel['city'].toString().toLowerCase();
        return city.contains(selectedCityFilter!.toLowerCase());
      }).toList();
    }

    setState(() {
      _filteredHotelList = filteredList;
    });
  }

  Widget build(BuildContext context) {
    return SlidingUpPanel(
      panelBuilder: (ScrollController sc) {
        return HotelPetFilterSlidding(
          pc: pc,
          // onFilterApplied: (selectedCity) {
          //   setState(() {
          //     selectedCityFilter = selectedCity;
          //     // Di sini Anda dapat melakukan filtering kembali berdasarkan nilai city yang dipilih
          //     // dengan memanggil fungsi _filterHotelList(selectedCity);
          //   });
          // },
          onFilterApplied: (selectedCity) {
            setState(() {
              selectedCityFilter = selectedCity;
              _filterHotelList(_searchController
                  .text); // Panggil fungsi filter dengan kota terpilih
            });
          },
        );
      },
      controller: pc,
      isDraggable: true,
      maxHeight: 45.h,
      minHeight: 0,
      backdropEnabled: true,
      backdropTapClosesPanel: true,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      body: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, '/dashboardPageView');
            },
          ),
          backgroundColor: const Color(0xffDC822A),
          flexibleSpace: const SafeArea(
            child: AppBarTitle(
              title: "Pencarian Hotel",
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              decoration: BoxDecoration(
                  // color: Colors.red,
                  border: Border(
                      bottom: BorderSide(
                          width: 0.5, color: globalColors.borderLine))),
              // color: Colors.red,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          color: globalColors.bgOrangeDisabled,
                          // color: Color(0xFFD9D9D9).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              width: 0.1, color: globalColors.bgOrange)),
                      alignment: Alignment.center,
                      child: TextField(
                        controller: _searchController,
                        onChanged: (query) => _filterHotelList(query),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: globalColors.bgOrange),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xFFDC822A)),
                          ),
                          hintText: "Search",
                          suffixIcon: Icon(
                            Ionicons.search_outline,
                            color: globalColors.textGray,
                          ),
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: globalColors.bgOrangeDisabled,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(width: 1, color: globalColors.bgOrange)),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          pc.open();
                        });
                      },
                      child: Icon(
                        Ionicons.funnel_outline,
                        color: globalColors.iconGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   color: Colors.amber,
            //   height: 100,
            //   width: double.infinity,
            //   child: Text(selectedCityFilter ?? "Tidak ada kota dipilih"),
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredHotelList.length,
                itemBuilder: (context, index) {
                  final hotel = _filteredHotelList[index];
                  // print("hotel search: $hotel");
                  final reservation = hotel['reservations'];
                  // print("reserv : $reservation")
                  return Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 0.5, color: globalColors.borderLine))),
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 24),
                    child: HotelList(hotels: hotel),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
