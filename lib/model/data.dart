import 'package:intl/intl.dart';

class Classes {
  String id_class;
  String name;

  Classes({required this.id_class, required this.name});

  factory Classes.fromJson(Map<String, dynamic> json) {
    return Classes(id_class: json['id_class'], name: json['name']);
  }
}

class Category {
  String id_category;
  String name;
  String id_class;

  Category({required this.id_category, required this.name, required this.id_class});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id_category: json['id_category'].toString(),
        name: json['name'].toString(),
        id_class: json['id_class'].toString(),
    );
  }
}

class Species {
  String name;
  String id_species;
  String id_category;

  Species({required this.name, required this.id_species, required this.id_category});

  factory Species.fromJson(Map<String, dynamic> json) {
    return Species(
      id_species: json['id_species'].toString(),
      name: json['name'].toString(),
      id_category: json['id_category'].toString(),
    );
  }
}

class Pets {
  String id_pet;
  String name;
  String user_id;
  String age;
  String class_id;
  String species_id;
  String category_id;
  String class_name;
  String species_name;
  String category_name;
  String birth_date;
  String gender;
  String vaccination;
  String allergy;
  String flea_disease;
  String another_disease;
  String fav_food;
  String image;

  Pets({
    required this.id_pet,
    required this.name,
    required this.user_id,
    required this.age,
    required this.class_id,
    required this.species_id,
    required this.category_id,
    required this.class_name,
    required this.species_name,
    required this.category_name,
    required this.birth_date,
    required this.gender,
    required this.vaccination,
    required this.allergy,
    required this.flea_disease,
    required this.another_disease,
    required this.fav_food,
    required this.image,
  });

  factory Pets.fromJson(Map<String, dynamic> json) {
    DateTime birthDate = DateTime.parse(json['birth_date'].toString());
    int ageInYears = DateTime.now().year - birthDate.year;
    int ageInMonths = DateTime.now().month - birthDate.month;

    if (DateTime.now().day < birthDate.day) {
      ageInMonths--;
    }

    String ageText = '';

    if (ageInYears < 1) {
      if (ageInMonths < 1) {
        // Umur kurang dari 1 bulan
        ageText = '${birthDate.difference(DateTime.now()).inDays.abs()} hari';
        ageText = ageText.replaceAll("-", "");
        ageText = 'Umur $ageText';
        // print(ageText);
      } else {
        // Umur kurang dari 1 tahun
        ageText = '${ageInMonths} bulan';
        ageText = 'Umur $ageText';
        // print(ageText);
      }
    } else {
      // Umur lebih dari 1 tahun
      ageText = '${ageInYears} tahun';
      ageText = 'Umur $ageText';
      // print(ageText);
    }

    DateTime parsedDateOfBirth = DateTime.parse(json['birth_date']);
    String dateOfBirth = DateFormat('dd/MM/yyyy').format(parsedDateOfBirth).toUpperCase();

    return Pets(
      id_pet: json['id_pet'].toString(),
      name: json['name'].toString(),
      user_id: json['user_id'].toString(),
      age: ageText,
      species_name: json['species']['name'].toString(),
      species_id: json['species_id'].toString(),
      category_name: json['species']['category']['name'].toString(),
      category_id: json['species']['category_id'].toString(),
      class_name: json['species']['category']['class']['name'].toString(),
      class_id: json['species']['category']['class_id'].toString(),
      birth_date: dateOfBirth.toString(),
      gender: json['gender'].toString(),
      vaccination: json['vaccination'].toString(),
      allergy: json['allergy'].toString(),
      flea_disease: json['flea_disease'].toString(),
      another_disease: json['another_disease'].toString(),
      fav_food: json['favorite_food'].toString(),
      image: json['image'].toString(),
    );
  }
}