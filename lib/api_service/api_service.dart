import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/auth_model/auth_model.dart';
import '../models/banner_response_model.dart';
import '../models/product_response_mdoel.dart';
import '../utils/hive.dart';

class ApiService {
  final Dio dio = Dio();
  static const String baseUrl = 'https://backend.sugarcakesweets.com/api/';

  Future<Authmodel?> signIn(String username, String password) async {
    final url = baseUrl + 'userLogin/';
    try {
      final response = await dio.post(
        url,
        data: {
          'username': username,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data != null && response.data['logindetails'] != null) {
          print('Login details: ${response.data['logindetails']}');
        }
        return authmodelFromJson(jsonEncode(response.data));
      } else {
        print('Failed to sign in: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  Future<ProductResponseModel?> getProducts() async {
    final url = baseUrl + 'getproducts/';
    try {
      final response = await dio.get(
        url,
        options: Options(headers: {
          'Authorization': 'Bearer ${AppHive().getToken()}',
          'Content-Type': 'application/json',
        }),
      );
      print(getProducts());
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data;
        print('db' * 100);
        print(data);
        return productResponseModelFromJson(jsonEncode(response.data));
      } else {
        print('-------Failed to fetch products:------ ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('--------Error fetching products: $e-------');
      return null;
    }
  }

  Future<BannerResponseModel?> fetchBannerData() async {
    final url = baseUrl + 'getCategory/';
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        print('-----------Banner data  successfully----------');
        return BannerResponseModel.fromJson(response.data);
      } else {
        print('--------Failed  banner. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print(' --------Error data banner: $e-----------');
      return null;
    }
  }
}
