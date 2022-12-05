import 'dart:convert';

import 'package:taba/data/models/gempa_response.dart';
import 'package:http/http.dart' as http;
import 'package:taba/data/models/p3k_list_response.dart';
import 'package:html/dom.dart' as dom;

abstract class RemoteDataSource {
  Future<List<Gempa>> getListGempaInfoTerkini();
  Future<List<P3kListResponse>> getP3kListResponse();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  static const bmkgBaseUrl = 'https://data.bmkg.go.id/DataMKG/TEWS';
  static const p3kListUrl =
      'https://id.wikihow.com/Kategori:P3K-dan-Keadaan-Darurat';
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<Gempa>> getListGempaInfoTerkini() async {
    final response =
        await client.get(Uri.parse('$bmkgBaseUrl/gempaterkini.json'));

    if (response.statusCode == 200) {
      return GempaResponse.fromJson(json.decode(response.body)).infogempa.gempa;
    } else {
      throw Exception("Get Data Gempa Failed");
    }
  }

  @override
  Future<List<P3kListResponse>> getP3kListResponse() async {
    final response = await client.get(Uri.parse(p3kListUrl));
    if (response.statusCode == 200) {
      dom.Document html = dom.Document.html(response.body);
      // final p3kItems = html
      //     .querySelectorAll('#cat_all div.cat_grid > div.responsive_thumb  ');
      List<P3kListResponse> items = [];

      List<String> titles = html
            .querySelectorAll('#cat_all div.responsive_thumb_title > p')
            .map((e) => e.innerHtml.trim())
            .toList();
      List<String> urlToDetails = html
            .querySelectorAll('#cat_all a')
            .map((e) => e.attributes['href']!)
            .toList();
      List<String> photoUrls = html
            .querySelectorAll('#cat_all div.content-spacer > img')
            .map((e) => e.attributes['data-src']!)
            .toList();
      items = List.generate(
            titles.length,
            (index) => P3kListResponse(
                title: titles[index],
                urlPhoto: photoUrls[index],
                linkToDetail: urlToDetails[index]));
      return items;
    } else {
      throw Exception('Data gagal diambil');
    }
  }
}
