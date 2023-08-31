import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../api/api_service.dart';
import '../../helper/global_colors.dart';
import '../../model/data.dart';
import '../../screen/dashboard/dashboard_pageview.dart';
import '../../screen/pet/detail/detail_pet.dart';

class PetList extends StatelessWidget {
  const PetList({Key? key, required this.pets,}) : super(key: key);
  final Pets pets;
  // final String age;

  @override
  Widget build(BuildContext context) {
    String defaultImagePet = BaseImage.getImagePet();
    GlobalColors globalColors = GlobalColors();
    // print("petsss: $pets");
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) {
              return DetailPet(
                pets: pets,
                defaultImage: defaultImagePet,
              );
            }),
          ),
        );
      },
      child: SizedBox(
        height: 80,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(100)),
                      color: globalColors.bgOrangeDisabled,
                      image: DecorationImage(
                          image: (pets.image != defaultImagePet) ? NetworkImage(pets.image) : NetworkImage("${defaultImagePet}default_pet.png"),
                          fit: BoxFit.cover
                      )
                  ),
                  // child: image != null ? null : Image(image: NetworkImage(image2))
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pets.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        pets.age,
                        style: TextStyle(
                          color: globalColors.textGray,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: SizedBox(
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 1.5, color: globalColors.borderLogout),
                              color: const Color(0xffF7DDC4).withOpacity(0.5)),
                          child: Center(
                            child: Icon(Ionicons.trash,
                                size: 24, color: globalColors.borderLogout),
                          ),
                        ),
                        onTap: () async {
                          Pet.deletePet(pets.id_pet).then((value) {
                            // jika penghapusan berhasil, Anda dapat menampilkan pesan sukses
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashboardPageView(
                                          initialIndex: 3,
                                        )));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                                  Text("Hewan Peliharaan berhasil dihapus"),
                            ));
                          }).catchError((error) {
                            // jika terjadi error saat penghapusan, Anda dapat menampilkan pesan error
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  "Gagal menghapus Hewan Peliharaan. Silakan coba lagi."),
                            ));
                          });
                        },
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
