import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../constant/string.dart';

class CharacterAPI {
  late Dio dio;

  CharacterAPI() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,

      connectTimeout: 10 * 1000, // 60 seconds,
      receiveTimeout: 10 * 1000,
    );
    dio = Dio(baseOptions);
  }

   Future<List<dynamic>?>? fetchCharacters() async {
    try {
      Response response = await dio.get("characters");
        return response.data;      
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }
   Future<List<dynamic>?>? fetchQuotes(String characterName) async {
    try {
      Response response = await dio.get(
        "quote",
        queryParameters: {'author': characterName},
      );
      return response.data;      
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }

}
