import 'package:dio/dio.dart';

class ApiServices {
  ApiServices._();

  static Future<dynamic> logIn(String email, String password) {
    try {
      return Dio().post('https://localhost:44318/api/v1/users/login', data: {
        'email': email,
        'password': password,
        'returnSecureToken': true
      });
    } catch (e) {
      throw Exception('Log In failed');
    }
  }

  static Future<dynamic> loadListStorage(
      int page, int size, String jwt, String address) {
    try {
      return Dio().get(
          'https://localhost:44318/api/v1/storages?Address=$address&page=$page&size=$size',
          options: Options(headers: {
            'Authorization': 'bearer ' + jwt,
            'Content-Type': "application/json",
            'Accept': 'application/json',
          }));
    } catch (e) {
      throw Exception('Unathorized');
    }
  }

  static Future<dynamic> loadListFeedback(
      int page, int size, String jwt, int idStorage) {
    try {
      return Dio().get(
          'https://localhost:44318/api/v1/feedbacks?StorageId=$idStorage&page=$page&size=$size',
          options: Options(headers: {
            'Authorization': 'bearer ' + jwt,
            'Content-Type': "application/json",
            'Accept': 'application/json',
          }));
    } catch (e) {
      throw Exception('Unathorized');
    }
  }

  static Future<dynamic> loadListOrder(int page, int size, String jwt) {
    try {
      return Dio()
          .get('https://localhost:44318/api/v1/orders?$page=1&size=$size',
              options: Options(headers: {
                'Authorization': 'bearer ' + jwt,
                'Content-Type': "application/json",
                'Accept': 'application/json',
              }));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<dynamic> loadShelves(
      int page, int size, String jwt, int storageId) {
    try {
      return Dio().get(
          'https://localhost:44318/api/v1/shelves?StorageId=$storageId&page=$page&size=$size',
          options: Options(headers: {
            'Authorization': 'bearer ' + jwt,
            'Content-Type': "application/json",
            'Accept': 'application/json',
          }));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<dynamic> loadFeedback(
      int page, int size, String jwt, int storageId) {
    try {
      return Dio().get(
          'https://localhost:44318/api/v1/feedbacks?StorageId=${storageId.toString()}page=$page&size=$size',
          options: Options(headers: {
            'Authorization': 'bearer ' + jwt,
            'Content-Type': "application/json",
            'Accept': 'application/json',
          }));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<dynamic> loadDeatailShelf(String jwt, int shelfId) {
    try {
      return Dio().get('https://localhost:44318/api/v1/shelves/$shelfId',
          options: Options(headers: {
            'Authorization': 'bearer ' + jwt,
            'Content-Type': "application/json",
            'Accept': 'application/json',
          }));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<dynamic> updateInfo(
      String name, String address, String phone, String jwt, String imageUrl) {
    try {
      return Dio().put('https://localhost:44318/api/v1/users/updateprofile',
          data: {
            'name': name,
            'address': address,
            'phone': phone,
            'avatarUrl': imageUrl
          },
          options: Options(headers: {
            'Authorization': 'bearer ' + jwt,
            'Content-Type': "application/json",
            'Accept': 'application/json',
          }));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<dynamic> changePassword(
      String password, String oldPassword, String confirmPassword, String jwt) {
    try {
      return Dio().post('https://localhost:44318/api/v1/users/changepassword',
          data: {
            'oldPassword': oldPassword,
            'newPassword': password,
            'confirmPassword': confirmPassword
          },
          options: Options(headers: {
            'Authorization': 'bearer ' + jwt,
            'Content-Type': "application/json",
            'Accept': 'application/json',
          }));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<dynamic> signUp(
      String role,
      String email,
      String password,
      String confirmPassword,
      String name,
      String phone,
      String address,
      String avatarUrl) {
    try {
      return Dio().post('https://localhost:44318/api/v1/users/signup', data: {
        "email": email,
        "password": password,
        "name": name,
        "address": address,
        "phone": phone,
        "roleName": role,
        'avatar': avatarUrl
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<dynamic> addStorage(
      String name,
      String address,
      String description,
      int shelvesQuantity,
      int smallBoxPrice,
      int bigBoxPrice,
      List<Map<String, dynamic>> images,
      String jwt) {
    try {
      return Dio().post('https://localhost:44318/api/v1/storages',
          data: {
            "name": name,
            "address": address,
            "description": description,
            "shelvesQuantity": shelvesQuantity,
            "smallBoxPrice": smallBoxPrice,
            "bigBoxPrice": bigBoxPrice,
            "images": images
          },
          options: Options(headers: {
            'Authorization': 'bearer ' + jwt,
            'Content-Type': "application/json",
            // 'Accept': 'application/json',
          }));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<dynamic> addShelf(int idStorage, String jwt) {
    try {
      return Dio().post('https://localhost:44318/api/v1/shelves',
          data: {
            "storageId": idStorage,
          },
          options: Options(headers: {
            'Authorization': 'bearer ' + jwt,
            'Content-Type': "application/json",
            // 'Accept': 'application/json',
          }));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<dynamic> updateStorage(
      int idStorage,
      String name,
      String address,
      String description,
      double smallBoxPrice,
      double bigBoxPrice,
      List<Map<String, dynamic>> images,
      String jwt) {
    try {
      return Dio().put(
          'https://localhost:44318/api/v1/storages/${idStorage.toString()}',
          data: {
            "name": name,
            "address": address,
            "description": description,
            "priceFrom": smallBoxPrice,
            "priceTo": bigBoxPrice,
            "images": images
          },
          options: Options(headers: {
            'Authorization': 'bearer ' + jwt,
            'Content-Type': "application/json",
            'Accept': 'application/json',
          }));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<dynamic> deleteStorage(int idStorage, String jwt) {
    try {
      return Dio().delete(
          'https://localhost:44318/api/v1/storages/${idStorage.toString()}',
          options: Options(headers: {
            'Authorization': 'bearer ' + jwt,
            'Content-Type': "application/json",
            'Accept': 'application/json',
          }));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<dynamic> deleteShelf(int idShelf, String jwt) {
    try {
      return Dio().delete('https://localhost:44318/api/v1/shelves/$idShelf',
          options: Options(headers: {
            'Authorization': 'bearer ' + jwt,
            'Content-Type': "application/json",
            'Accept': 'application/json',
          }));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<dynamic> postFeedback(
      int idStorage, String jwt, int idOrder, double rating, String comment) {
    try {
      return Dio().post('https://localhost:44318/api/v1/feedbacks',
          data: {
            "storageId": idStorage,
            "orderId": idOrder,
            "rating": rating,
            "comment": comment,
          },
          options: Options(headers: {
            'Authorization': 'bearer ' + jwt,
            'Content-Type': "application/json",
            // 'Accept': 'application/json',
          }));
    } catch (e) {
      throw Exception('Feedback failed');
    }
  }

  static Future<dynamic> importBoxes(
      String jwt, List<Map<String, dynamic>> listResult) {
    try {
      return Dio().post('https://localhost:44318/api/v1/order-details',
          data: {"orderDetails": listResult},
          options: Options(headers: {
            'Authorization': 'bearer ' + jwt,
            'Content-Type': "application/json",
            // 'Accept': 'application/json',
          }));
    } catch (e) {
      throw Exception('Feedback failed');
    }
  }

  static Future<dynamic> updateFeedBack(
      int idStorage, String jwt, int idOrder, double rating, String comment) {
    try {
      return Dio().put(
          'https://localhost:44318/api/v1/feedbacks?orderId=${idOrder.toString()}&storageId=${idStorage.toString()}',
          data: {
            "storageId": idStorage,
            "orderId": idOrder,
            "rating": rating,
            "comment": comment,
          },
          options: Options(headers: {
            'Authorization': 'bearer ' + jwt,
            'Content-Type': "application/json",
            'Accept': 'application/json',
          }));
    } catch (e) {
      throw Exception('Feedback failed');
    }
  }

  static Future<dynamic> payment(
      double totalPrice,
      int months,
      int smallBoxQuantity,
      int bigBoxQuantity,
      double smallBoxPrice,
      double bigBoxPrice,
      DateTime datePickUp,
      int idStorage,
      String jwt) {
    try {
      return Dio().post('https://localhost:44318/api/v1/orders',
          data: {
            "storageId": idStorage,
            "total": totalPrice,
            "months": months,
            "smallBoxQuantity": smallBoxQuantity,
            "smallBoxPrice": smallBoxPrice,
            "pickupTime": datePickUp.toIso8601String(),
            "bigBoxQuantity": bigBoxQuantity,
            "bigBoxPrice": bigBoxPrice
          },
          options: Options(headers: {
            'Authorization': 'bearer ' + jwt,
            'Content-Type': "application/json",
            'Accept': 'application/json',
          }));
    } catch (e) {
      throw Exception('Payment in failed');
    }
  }

  static Future<dynamic> getStorage(String jwt, int storageId) {
    try {
      return Dio().get('https://localhost:44318/api/v1/storages/$storageId',
          options: Options(headers: {
            'Authorization': 'bearer ' + jwt,
            'Content-Type': "application/json",
            'Accept': 'application/json',
          }));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<dynamic> getOrder(String jwt, int orderId) {
    try {
      return Dio().get('https://localhost:44318/api/v1/orders/$orderId',
          options: Options(headers: {
            'Authorization': 'bearer ' + jwt,
            'Content-Type': "application/json",
            'Accept': 'application/json',
          }));
    } catch (e) {
      throw Exception(e);
    }
  }
}
