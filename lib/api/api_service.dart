import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../helper/session.dart';
import '../model/data.dart';

class BaseUrl {
  static const String baseUrl =
      'https://e8c4-2404-8000-1031-a15-b494-d75f-4abd-4e00.ngrok-free.app/';
}

class BaseImage {
  static getImagePet() {
    const imageUrl = '${BaseUrl.baseUrl}pet/profile/';
    return imageUrl;
  }

  static getImageCondition() {
    const imageUrl = '${BaseUrl.baseUrl}pet/condition/';
    return imageUrl;
  }

  static getImageUser() {
    const imageUrl = '${BaseUrl.baseUrl}user/profile/';
    return imageUrl;
  }

  static getImageHotel() {
    const imageUrl = '${BaseUrl.baseUrl}hotel/profile/';
    return imageUrl;
  }

  static getHotelAlbums() {
    const imageUrl = '${BaseUrl.baseUrl}hotel/album/';
    return imageUrl;
  }
}

class BaseApi {
  static const String baseUrlApi = '${BaseUrl.baseUrl}api/';
}

class Address {
  static Future<List<Map<String, dynamic>>> getProvince() async {
    final response =
        await http.get(Uri.parse('${BaseApi.baseUrlApi}province/all'));

    var datas = jsonDecode(response.body);
    var province = datas['data']['data'];
    if (response.statusCode == 200) {
      final dataProv = List<Map<String, dynamic>>.from(province);
      return dataProv;
    } else {
      throw Exception('Failed to load province data');
    }
  }

  static Future<List<Map<String, dynamic>>> getCity(int? provinceId) async {
    print("provinsi id: $provinceId");
    final response = await http
        .get(Uri.parse('${BaseApi.baseUrlApi}city/all?provinceId=$provinceId'));

    var datas = jsonDecode(response.body);
    var city = datas['data']['data'];
    if (response.statusCode == 200) {
      final dataCity = List<Map<String, dynamic>>.from(city);
      return dataCity;
    } else {
      throw Exception('Failed to load city data');
    }
  }

  static Future<List<Map<String, dynamic>>> getDistrict(int? cityId) async {
    final response = await http
        .get(Uri.parse('${BaseApi.baseUrlApi}district/all?cityId=$cityId'));

    var datas = jsonDecode(response.body);
    var district = datas['data']['data'];
    if (response.statusCode == 200) {
      final datadistrict = List<Map<String, dynamic>>.from(district);
      return datadistrict;
    } else {
      throw Exception('Failed to load distritct data');
    }
  }

  static Future<List<Map<String, dynamic>>> getSubDistrict(
      int? districtId) async {
    final response = await http.get(Uri.parse(
        '${BaseApi.baseUrlApi}subdistrict/all?districtId=$districtId'));

    var datas = jsonDecode(response.body);
    var district = datas['data']['data'];
    if (response.statusCode == 200) {
      final dataSubDistrict = List<Map<String, dynamic>>.from(district);
      return dataSubDistrict;
    } else {
      throw Exception('Failed to load subdistrict data');
    }
  }
}

class Pet {
  static Future<List<Classes>> getClass() async {
    final response =
        await http.post(Uri.parse('${BaseApi.baseUrlApi}class/all'));

    var datas = jsonDecode(response.body);
    // print(datas);
    var data = datas["data"]["data"];
    // print(data);
    var paginate = datas["data"]["paginate"];

    if (response.statusCode == 200) {
      var listClasses = (data as List).map((i) => Classes.fromJson(i)).toList();
      // print("ini data apa : $listClasses");
      return listClasses;
    } else {
      throw Exception('Failed to load Posts');
    }
  }

  static Future<List<Category>> getCategory(String idClass) async {
    final response = await http
        .get(Uri.parse('${BaseApi.baseUrlApi}category/all?classId=$idClass'));

    var datas = jsonDecode(response.body);
    // print(datas);
    var data = datas["data"]["data"];
    // print(data);
    var paginate = datas["data"]["paginate"];

    if (response.statusCode == 200) {
      // var getPostsData = json.decode(data) as List;
      var listCategory =
          (data as List).map((i) => Category.fromJson(i)).toList();
      print(listCategory);
      // var filteredCategory = listCategory
      //     .where((category) => category.id_class == idClass)
      //     .toList();
      return listCategory;
    } else {
      throw Exception('Failed to load Posts');
    }
  }

  static Future<List<Map<String, dynamic>>> getSpeciesTes(
      String idCategory) async {
    final response = await http.get(
      Uri.parse('${BaseApi.baseUrlApi}species/all?categoryId=$idCategory'),
    );

    var datas = jsonDecode(response.body);
    var data = datas["data"]["data"];

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> listSpecies =
          List<Map<String, dynamic>>.from(data);
      return listSpecies;
    } else {
      throw Exception('Failed to load species');
    }
  }

  static Future<List<Species>> getSpecies(String idCategory) async {
    final response = await http.get(
        Uri.parse('${BaseApi.baseUrlApi}species/all?categoryId=$idCategory'));

    var datas = jsonDecode(response.body);
    // print(datas);
    var data = datas["data"]["data"];
    // print(data);
    var paginate = datas["data"]["paginate"];

    if (response.statusCode == 200) {
      var listSpecies = (data as List).map((i) => Species.fromJson(i)).toList();
      return listSpecies;
    } else {
      throw Exception('Failed to load Posts');
    }
  }

  static Future<List<Pets>> fetchPet() async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    // print(token);
    final response =
        await http.get(Uri.parse('${BaseApi.baseUrlApi}pet/all'), headers: {
      'Authorization': '$token',
    });
    var datas = jsonDecode(response.body);
    // print(datas);
    var pet = datas["data"]["data"];
    // print(pet);
    var paginate = datas["data"]["paginate"];

    if (response.statusCode == 200) {
      // var getPostsData = json.decode(data) as List;
      var listPets = (pet as List).map((i) => Pets.fromJson(i)).toList();
      return listPets;
    } else {
      throw Exception('Failed to load Posts');
    }
  }

  static Future<void> deletePet(String id_pet) async {
    // print("object")
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    // print(token);
    final response = await http
        .delete(Uri.parse('${BaseApi.baseUrlApi}pet/delete/$id_pet'), headers: {
      'Authorization': '$token',
    });
    if (response.statusCode != 200) {
      throw Exception('Failed to load Posts ${response.statusCode}');
    }
    return;
  }

  static Future<Map<String, dynamic>> createPetCondition(
      String reservationDetailId,
      String idCondition,
      String description,
      File? selectedImage) async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${BaseApi.baseUrlApi}petCondition/add'),
    );
    request.headers['Authorization'] = token;

    request.fields['reservation_detail_id'] = reservationDetailId;
    request.fields['status'] = 'Diterima';
    request.fields['condition_id'] = idCondition;
    request.fields['title'] = "Notifikasi Hewan";
    request.fields['description'] = description;

    if (selectedImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        selectedImage.path,
      ));
    }

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();
    print("response condition : $responseBody");

    if (response.statusCode == 201) {
      print('Data berhasil dikirim');
    } else {
      print('Gagal mengirim data. Status code: ${response.statusCode}');
    }

    return {
      'statusCode': response.statusCode,
      'responseBody': responseBody,
    };
  }

  static Future<List<Pets>> createPet(
      int id_pet,
      String name_pet,
      String class_name,
      String category_name,
      String species_name,
      String gender_pet,
      String birth_pet,
      String fav_food) async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    // print(token);
    final response =
        await http.post(Uri.parse('${BaseApi.baseUrlApi}pet/add'), headers: {
      'Authorization': '$token',
    }, body: {
      'id_pet': id_pet.toString(),
      'name_pet': name_pet,
      'class_name': class_name.toString(),
      'category_name': category_name.toString(),
      'species_name': species_name.toString(),
      'gender_pet': gender_pet,
      'birth_pet': birth_pet,
      'fav_food': fav_food,
    });
    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Hewan Gagal Ditambahkan');
    }
  }
}

class ApiService {
  static Future<void> logout(String token) async {
    final response = await http
        .post(Uri.parse('${BaseApi.baseUrlApi}auth/logout'), headers: {
      'Authorization': token,
    });

    if (response.statusCode == 200) {
      print('Logout successful');
    } else {
      throw Exception('Failed to logout');
    }
  }

  static Future<Map<String, dynamic>> changePassword(
      String passwordOld, String passwordNew, String passwordNewConf) async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final response = await http
        .put(Uri.parse('${BaseApi.baseUrlApi}user/changepass'), headers: {
      'Authorization': '$token',
    }, body: {
      'old_password': passwordOld,
      'new_password': passwordNew,
      'confirm_password': passwordNewConf,
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Password Gagal Diubah');
    }
  }

  static Future<Map<String, dynamic>> loginUser(
      String email, String password) async {
    final response =
        await http.post(Uri.parse('${BaseApi.baseUrlApi}auth/login'), body: {
      'email': email,
      'password': password,
      // 'device_token': tokenFcm,
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Login Gagal');
    }
  }

  static Future<void> tokenDevice(String idUser, String tokenFCM) async {
    print("token fcm: $tokenFCM");
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final response = await http
        .put(Uri.parse('${BaseApi.baseUrlApi}auth/save/deviceId'), headers: {
      'Authorization': '$token',
    }, body: {
      'user_id': idUser.toString(),
      'device_token': tokenFCM.toString(),
    });
    print("response: $response");
    print("object token : ${response.body}");

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print("token data: $responseData");
    } else {
      throw Exception('token gagal diubah');
    }
  }

  static Future<Map<String, dynamic>> registerUser(
      String name, String email, String password) async {
    final response =
        await http.post(Uri.parse('${BaseApi.baseUrlApi}auth/register'), body: {
      'name': name,
      'email': email,
      'password': password,
    });

    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Registrasi Gagal');
    }
  }

  static Future<Map<String, dynamic>> registerAuthUser(
      String name, String email, String password) async {
    final response = await http
        .post(Uri.parse('${BaseApi.baseUrlApi}auth/registerUser'), body: {
      'name': name,
      'email': email,
      'password': password,
    });

    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Registrasi Gagal');
    }
  }

  static Future<Map<String, dynamic>> getDataUser() async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final response = await http
        .get(Uri.parse('${BaseApi.baseUrlApi}user/profile'), headers: {
      'Authorization': '$token',
    });
    // print(response.body);
    var datas = jsonDecode(response.body);
    // print(datas);
    if (response.statusCode == 200) {
      var user = datas["data"];
      return user;
    } else {
      throw Exception('Gagal mendapatkan data user');
    }
  }

  static Future<Map<String, dynamic>> updateUser(
      String id,
      String name,
      int nik,
      String birth_date,
      String gender,
      int phone,
      String email,
      String address,
      String province,
      String city,
      String district,
      String subdistrict,
      File? selectedImage) async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse('${BaseApi.baseUrlApi}user/profile'),
    );

    request.headers['Authorization'] = token;

    // Add form fields
    request.fields['id'] = id;
    request.fields['name'] = name;
    request.fields['nik'] = nik.toString();
    // request.fields['birth'] = birth_date;
    request.fields['birth_date'] = birth_date;
    request.fields['gender'] = gender;
    request.fields['phone'] = phone.toString();
    request.fields['email'] = email;
    request.fields['address'] = address;
    request.fields['province_id'] = province.toString();
    request.fields['city_id'] = city.toString();
    request.fields['district_id'] = district.toString();
    request.fields['subdistrict_id'] = subdistrict.toString();

    if (selectedImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          selectedImage.path,
        ),
      );
    }

    // final response = await http.put(
    //     Uri.parse('${BaseApi.baseUrl}user/profile'),
    //     headers: {
    //       'Authorization': '$token',
    //     },
    //     body: {
    //       'id' : id.toString(),
    //       'name': name,
    //       'nik': nik.toString(),
    //       'gender': gender.toString(),
    //       'phone': phone.toString(),
    //       'email': email,
    //       'address': address,
    //     }
    // );

    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    // print("respone : $responseString");

    if (response.statusCode == 200) {
      final responseData = json.decode(responseString);
      // print("user : $responseData");
      return responseData;
    } else {
      throw Exception('Data user gagal diubah');
    }
    // var datas = jsonDecode(response.body);
    // // print(datas);
    // if (response.statusCode == 200) {
    //   final user = datas;
    //   return user;
    // } else {
    //   throw Exception('Gagal mengubah data user');
    // }
  }

  static Future<List<Pets>> getDataPet() async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    // print(token);
    final response =
        await http.get(Uri.parse('${BaseApi.baseUrlApi}pet/all'), headers: {
      'Authorization': '$token',
    });
    var datas = jsonDecode(response.body);
    // print(datas);
    var pet = datas["data"]["data"];
    print(pet);
    var paginate = datas["data"]["paginate"];

    if (response.statusCode == 200) {
      // var getPostsData = json.decode(data) as List;
      var listPets = (pet as List).map((i) => Pets.fromJson(i)).toList();
      return listPets;
    } else {
      throw Exception('Failed to load Posts');
    }
  }

  static Future<Map<String, dynamic>> createPet(
      String name_pet,
      String species_id,
      String gender_pet,
      String fav_food,
      String birth_pet,
      File? selectedImage) async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final user_id = data['data']['id'];
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${BaseApi.baseUrlApi}pet/add'),
    );

    request.headers['Authorization'] = token;

    // Add form fields
    request.fields['name'] = name_pet;
    request.fields['user_id'] = user_id;
    request.fields['species_id'] = species_id;
    request.fields['gender'] = gender_pet;
    request.fields['birth_date'] = birth_pet;
    request.fields['favorite_food'] = fav_food;

    // Add image file if selected
    if (selectedImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          selectedImage.path,
        ),
      );
    }

    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    // print("respone : $responseString");

    if (response.statusCode == 201) {
      final responseData = json.decode(responseString);
      // print("hewan : $responseData");
      return responseData;
    } else {
      throw Exception('Hewan Gagal Ditambahkan');
    }
  }

  static Future<Map<String, dynamic>> updatePet(
      String id_pet,
      String name_pet,
      String species_id,
      String gender_pet,
      String fav_food,
      String birth_pet,
      File? selectedImage) async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final user_id = data['data']['id'];
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse('${BaseApi.baseUrlApi}pet/update'),
    );

    request.headers['Authorization'] = token;

    // Add form fields
    request.fields['name'] = name_pet;
    request.fields['id_pet'] = id_pet;
    request.fields['user_id'] = user_id;
    request.fields['species_id'] = species_id;
    request.fields['gender'] = gender_pet;
    request.fields['birth_date'] = birth_pet.toString();
    request.fields['favorite_food'] = fav_food;

    // Add image file if selected
    if (selectedImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          selectedImage.path,
        ),
      );
    }

    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    print("respone : $responseString");

    if (response.statusCode == 200) {
      final responseData = json.decode(responseString);
      print("hewan : $responseData");
      return responseData;
    } else {
      print("error");
      throw Exception('Hewan Gagal Ditambahkan');
    }
  }
}

class History {
  static Future<List<Map<String, dynamic>>> getNotificationConditions() async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final idUser = data['data']['id'];
    final response = await http.get(
        Uri.parse('${BaseApi.baseUrlApi}petCondition/all?userId=$idUser'),
        headers: {'Authorization': '$token'});

    var datas = jsonDecode(response.body);
    print("datas: $datas");
    var pet = datas['data']['data'];
    print("object notif: $pet");
    if (response.statusCode == 200) {
      // var data = jsonDecode(response.body);
      // var petConditions = datas['data'];
      return List<Map<String, dynamic>>.from(pet);
    } else {
      throw Exception('Failed to load pet conditions');
    }
  }

  static Future<List<Map<String, dynamic>>> getHistoryNotification() async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final idUser = data['data']['id'];
    // print("status : $status");
    final response = await http.get(
        Uri.parse(
            '${BaseApi.baseUrlApi}reservationNotification/all?userId=$idUser'),
        headers: {'Authorization': '$token'});

    var datas = jsonDecode(response.body);
    // print("datas: $datas");
    var notifHistory = datas['data']['data'];
    print("object pet: $notifHistory");
    if (response.statusCode == 200) {
      // var data = jsonDecode(response.body);
      // var petConditions = datas['data'];
      return List<Map<String, dynamic>>.from(notifHistory);
    } else {
      throw Exception('Failed to load pet conditions');
    }
  }

  static Future<List<Map<String, dynamic>>> getHistoryReservation(
      String status) async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final idUser = data['data']['id'];
    // print("status : $status");
    final response = await http.get(
        Uri.parse(
            '${BaseApi.baseUrlApi}reservation/all?userId=$idUser&reservationStatus=$status'),
        headers: {'Authorization': '$token'});

    var datas = jsonDecode(response.body);
    // print("datas: $datas");
    var pet = datas['data']['data'];
    // print("object pet: $pet");
    if (response.statusCode == 200) {
      // var data = jsonDecode(response.body);
      // var petConditions = datas['data'];
      return List<Map<String, dynamic>>.from(pet);
    } else {
      throw Exception('Failed to load pet conditions');
    }
  }

  static Future<List<Map<String, dynamic>>> getHistorySafeKeeping(
      String status) async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final idUser = data['data']['id'];
    print("status : $status");
    final response = await http.get(
        Uri.parse(
            '${BaseApi.baseUrlApi}reservation/all?userId=$idUser&checkinStatus=$status'),
        headers: {'Authorization': '$token'});

    var datas = jsonDecode(response.body);
    // print("datas: $datas");
    var pet = datas['data']['data'];
    // print("object pet: $pet");
    if (response.statusCode == 200) {
      // var data = jsonDecode(response.body);
      // var petConditions = datas['data'];
      return List<Map<String, dynamic>>.from(pet);
    } else {
      throw Exception('Failed to load pet conditions');
    }
  }

  static Future<List<Map<String, dynamic>>> getHistoryPayment(
      String status) async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final idUser = data['data']['id'];
    // print("status : $status");
    final response = await http.get(
        Uri.parse(
            '${BaseApi.baseUrlApi}reservation/all?userId=$idUser&paymentStatus=$status'),
        headers: {'Authorization': '$token'});

    var datas = jsonDecode(response.body);
    // print("datas: $datas");
    var pet = datas['data']['data'];
    // print("object pet: $pet");
    if (response.statusCode == 200) {
      // var data = jsonDecode(response.body);
      // var petConditions = datas['data'];
      return List<Map<String, dynamic>>.from(pet);
    } else {
      throw Exception('Failed to load pet conditions');
    }
  }

  static Future<Map<String, dynamic>> getHistoryBill(
      String idReservation) async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final response = await http.get(
        Uri.parse(
            '${BaseApi.baseUrlApi}reservation/bill?reservationId=$idReservation'),
        headers: {
          'Authorization': '$token',
        });
    // print(response.body);
    var datas = jsonDecode(response.body);
    // print(datas);
    if (response.statusCode == 200) {
      var bill = datas["data"];
      return bill;
    } else {
      throw Exception('Gagal mendapatkan history tagihan');
    }
  }
}

class TesSpecies {
  static Future<List<Map<String, dynamic>>> getPetConditions(
      String reservationDetailId) async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final response = await http.get(
        Uri.parse(
            '${BaseApi.baseUrlApi}petCondition/all?reservationDetailId=$reservationDetailId'),
        headers: {'Authorization': '$token'});

    var datas = jsonDecode(response.body);
    print("datas: $datas");
    var pet = datas['data']['data'];
    print("object pet: $pet");
    if (response.statusCode == 200) {
      // var data = jsonDecode(response.body);
      // var petConditions = datas['data'];
      return List<Map<String, dynamic>>.from(pet);
    } else {
      throw Exception('Failed to load pet conditions');
    }
  }

  static Future<List<Map<String, dynamic>>> getPetCondition() async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final response = await http.get(
        Uri.parse('${BaseApi.baseUrlApi}reservationDetail/all'),
        headers: {'Authorization': '$token'});
    var datas = jsonDecode(response.body);
    var pet = datas['data']['data'];

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> listPetCondition =
          List<Map<String, dynamic>>.from(pet);
      // print("ini isinya apa : $listPetCondition");
      return listPetCondition;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<Map<String, dynamic>>> getPet() async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final response = await http.get(Uri.parse('${BaseApi.baseUrlApi}pet/all'),
        headers: {'Authorization': '$token'});
    var datas = jsonDecode(response.body);
    // print("pet datas: $datas");
    var pet = datas['data']['data'];
    print("pets: $pet");

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> listPet = List<Map<String, dynamic>>.from(pet);
      print("ini isinya apa : $listPet");
      return listPet;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<Map<String, dynamic>>> getService(String idHotel) async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final response = await http.get(
        Uri.parse('${BaseApi.baseUrlApi}service/all?hotel_id=$idHotel'),
        headers: {'Authorization': '$token'});
    // print("response data $response");

    if (response.statusCode == 200) {
      var datas = jsonDecode(response.body);
      var data = datas["data"]["data"];
      // print("service data : $datas");
      // print("datas: $data");

      if (data is List) {
        List<Map<String, dynamic>> listService =
            List<Map<String, dynamic>>.from(data);
        print("service data: $listService");
        return listService;
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to load species');
    }
  }

  static Future<List<Map<String, dynamic>>> getProduct(String idHotel) async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final response = await http.get(
        Uri.parse('${BaseApi.baseUrlApi}product/all?hotel_id=$idHotel'),
        headers: {'Authorization': '$token'});
    // print("response data $response");

    if (response.statusCode == 200) {
      var datas = jsonDecode(response.body);
      var data = datas["data"]["data"];
      // print("product data : $datas");
      // print("datas: $data");

      if (data is List) {
        List<Map<String, dynamic>> listProduct =
            List<Map<String, dynamic>>.from(data);
        // print("Product data: $listProduct");
        return listProduct;
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to load species');
    }
  }

  static Future<List<Map<String, dynamic>>> getCage(String idHotel) async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final response = await http.get(
        Uri.parse(
            '${BaseApi.baseUrlApi}cageDetail/all?hotel_id=$idHotel&cageStatus=Kosong'),
        headers: {'Authorization': '$token'});
    // print("response data $response");

    if (response.statusCode == 200) {
      var datas = jsonDecode(response.body);
      var data = datas["data"]["data"];
      // print("cage data : $datas");
      // print("datas: $data");

      if (data is List) {
        List<Map<String, dynamic>> listCage =
            List<Map<String, dynamic>>.from(data);
        // print("Product data: $listProduct");
        return listCage;
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to load species');
    }
  }

  static Future<List<Map<String, dynamic>>> getSpecies() async {
    final response =
        await http.get(Uri.parse('${BaseApi.baseUrlApi}species/all'));
    var datas = jsonDecode(response.body);
    var data = datas['data']['data'];

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> listSpecies =
          List<Map<String, dynamic>>.from(data);
      // print("ini isinya apa : $listSpecies");
      return listSpecies;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<Map<String, dynamic>>> getDescription() async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final response = await http.get(
        Uri.parse('${BaseApi.baseUrlApi}condition/all'),
        headers: {'Authorization': '$token'});
    var datas = jsonDecode(response.body);
    // print("desc datas: $datas");
    var desc = datas['data']['data'];
    // print("desc data: $data");

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> listDesc =
          List<Map<String, dynamic>>.from(desc);
      // print("ini isinya apa : $listDesc");
      return listDesc;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<void> reservation(Map newDataMap) async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final response = await http.post(
      Uri.parse('${BaseApi.baseUrlApi}reservation/add'),
      headers: {'Authorization': '$token', "Content-Type": "application/json"},
      body: jsonEncode(newDataMap),
    );
    // print("isi response body apa: ${response.body}");
    var datas = jsonDecode(response.body);
    var dataku = datas['data'];
    // print("isi datas apa: $datas");
    print("isi dataku apa: $dataku");

    if (response.statusCode == 201) {
      print('Data berhasil dikirim');
    } else {
      print('Gagal mengirim data. Status code: ${response.statusCode}');
    }
  }

  static Future<List<Map<String, dynamic>>> getPetUser() async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];

    final response =
        await http.get(Uri.parse('${BaseApi.baseUrlApi}pet/all'), headers: {
      'Authorization': '$token',
    });

    var datas = jsonDecode(response.body);
    var pet = datas["data"]["data"];
    print("pet: $pet");

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> listPets =
          List<Map<String, dynamic>>.from(pet);
      print("pet user: $listPets");
      return listPets;
    } else {
      throw Exception('Failed to load pets');
    }
  }

  static Future<Map<String, dynamic>> reservationPetHotel(
      Map<String, dynamic> reservationData) async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final response = await http.post(
        Uri.parse('${BaseApi.baseUrlApi}reservation/add'),
        body: json.encode(reservationData),
        headers: {
          'Authorization': '$token',
        });
    print("response reservasi : $response");

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print("reservasi : $responseData");
      return responseData;
    } else {
      throw Exception('Reservasi Gagal Boss');
    }
  }
}

class Hotel {
  static Future<Map<String, dynamic>> detailHotelRecomendation(
      String idHotel) async {
    final response =
        await http.get(Uri.parse('${BaseApi.baseUrlApi}hotel/show/$idHotel'));
    print("tested respone:${response}");
    final datas = json.decode(response.body);
    print("tested apa 2: $datas");
    final data = datas['data'];
    print("isi tes aas2: $data");
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception('data gagal di get');
    }
  }

  static Future<List<Map<String, dynamic>>> getHotel() async {
    final response = await http.get(
      Uri.parse('${BaseApi.baseUrlApi}hotel/all'),
    );
    var datas = jsonDecode(response.body);
    var data = datas['data']['data'];
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> listHotel =
          List<Map<String, dynamic>>.from(data);
      return listHotel;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<Map<String, dynamic>>> getHotelRecomendation() async {
    final response = await http.get(
      Uri.parse('${BaseApi.baseUrlApi}hotel/top'),
    );
    var datas = jsonDecode(response.body);
    // print("object datas: $datas");
    var data = datas['data'];
    // print("object data: $data");
    // return data;
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> listTopHotel =
          List<Map<String, dynamic>>.from(data);
      return listTopHotel;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<Map<String, dynamic>> getRoomStatus(String idHotel) async {
    final response = await http.get(Uri.parse(
        '${BaseApi.baseUrlApi}cageDetail/listStatus?hotel_id=$idHotel'));
    print("response 2:${response}");
    final datas = json.decode(response.body);
    print("isi apa 2: $datas");
    final data = datas['data'];
    print("isi apa aas2: $data");
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception('data gagal di get');
    }
  }

  static Future<List<Map<String, dynamic>>> getHistoryReservation() async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final userId = data['data']['id'];
    // print("user id: $userId");
    final response = await http.post(
        Uri.parse(
            '${BaseApi.baseUrlApi}reservation/all?userId=$userId&reservationStatus=Diterima'),
        headers: {
          'Authorization': '$token',
        });
    var datas = jsonDecode(response.body);
    // print("datas history: $datas");
    var history = datas['data']['data'];
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> listHotel =
          List<Map<String, dynamic>>.from(history);
      return listHotel;
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class Dashboard {
  static Future<Map<String, dynamic>> getDashboardTotalPet() async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final response = await http.get(
        Uri.parse('${BaseApi.baseUrlApi}dashboard/staff/totalPet'),
        headers: {
          'Authorization': '$token',
        });
    // print(response.body);
    final datas = jsonDecode(response.body);
    // print("data yang saya tes: $datas");
    if (response.statusCode == 200) {
      var totalPet = datas["data"];
      print("totalPet: $totalPet");
      return totalPet;
    } else {
      throw Exception('Gagal mendapatkan total pet');
    }
  }

  static Future<List<Map<String, dynamic>>> getDashboardStaff() async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final response = await http.get(
        Uri.parse('${BaseApi.baseUrlApi}dashboard/staff/pet'),
        headers: {'Authorization': '$token'});
    var datas = jsonDecode(response.body);
    var dashboardStaff = datas['data']['data'];

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> listPetCondition =
          List<Map<String, dynamic>>.from(dashboardStaff);
      // print("ini isinya apa : $listPetCondition");
      return listPetCondition;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<Map<String, dynamic>>> getDashboardStaffStatus(
      String statusPet) async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final response = await http.get(
        Uri.parse(
            '${BaseApi.baseUrlApi}dashboard/staff/petByStatus?checkinStatus=$statusPet'),
        headers: {'Authorization': '$token'});
    var datas = jsonDecode(response.body);
    var dashboardStaffStatus = datas['data']['data'];

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> listPetCondition =
          List<Map<String, dynamic>>.from(dashboardStaffStatus);
      // print("ini isinya apa : $listPetCondition");
      return listPetCondition;
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class Rating {
  static Future<List<Map<String, dynamic>>> getRatingHotel(
      String hotelId) async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final response = await http.get(
        Uri.parse('${BaseApi.baseUrlApi}rating/all?hotel_id=$hotelId'),
        headers: {'Authorization': '$token'});
    var datas = jsonDecode(response.body);
    print("object datas: $datas");
    var about = datas['data']['data'];
    // print("object rating: $about");
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> listAbout =
          List<Map<String, dynamic>>.from(about);
      return listAbout;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<Map<String, dynamic>> createRatingHotel(
      String reservationId, int rate, String comment) async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final idUser = data['data']['id'];
    final response = await http.post(
      Uri.parse('${BaseApi.baseUrlApi}rating/add'),
      headers: {'Authorization': '$token'},
      body: {
        'reservation_id': reservationId,
        'star': rate.toString(), // Convert rate to string
        'comment': comment,
        'user_id': idUser,
      },
    );
    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      // print("hewan : $responseData");
      return responseData;
    } else {
      throw Exception('Hewan Gagal Ditambahkan');
    }
  }
}

class Menu {
  static Future<List<Map<String, dynamic>>> getMenuAbout() async {
    final response = await http.get(
      Uri.parse('${BaseApi.baseUrlApi}app/about'),
    );
    var datas = jsonDecode(response.body);
    var about = datas['data']['data'];
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> listAbout =
          List<Map<String, dynamic>>.from(about);
      return listAbout;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<Map<String, dynamic>>> getMenuHelp() async {
    final response = await http.get(
      Uri.parse('${BaseApi.baseUrlApi}app/question'),
    );
    var datas = jsonDecode(response.body);
    print("object help: $datas");
    var question = datas['data']['data'];
    print("object help: $question");
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> listQuestion =
          List<Map<String, dynamic>>.from(question);
      return listQuestion;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
