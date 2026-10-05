import 'package:dio/dio.dart';

class DioConnector {
 static final dio = Dio(
  BaseOptions(
    baseUrl: "https://dashboard.nepalschoolfootballleague.com/api/",
    headers: {
      "Accept" :"application/json",
      "Content_Type": "application/json",
      
    }
  )
 );
}