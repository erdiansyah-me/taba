import 'dart:convert';

import 'package:taba/data/models/GempaResponse.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<Gempa>> getListGempaInfoTerkini();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  static const bmkgBaseUrl = 'https://data.bmkg.go.id/DataMKG/TEWS';

  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<Gempa>> getListGempaInfoTerkini() async {
    final response = await client.get(Uri.parse('$bmkgBaseUrl/gempaterkini.json'));

    if (response.statusCode == 200) {
      return GempaResponse.fromJson(json.decode(response.body)).infogempa.gempa;
    } else {
      throw Exception("Get Data Gempa Failed");
    }
  }
  
}