import 'dart:io';

import 'package:dio/dio.dart';
import 'package:todo_app/enviroment/env.dart';


Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      responseType: ResponseType.json,
      contentType: ContentType.json.toString(),
      headers: {
        'Accept': 'application/json',
      },
      baseUrl: Env.supabaseUrl + "/table",
    )
);