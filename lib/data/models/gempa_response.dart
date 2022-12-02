// To parse this JSON data, do
//
//     final gempaResponse = gempaResponseFromJson(jsonString);

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:taba/domain/entities/gempa_entity.dart';

GempaResponse gempaResponseFromJson(String str) =>
    GempaResponse.fromJson(json.decode(str));

String gempaResponseToJson(GempaResponse data) => json.encode(data.toJson());

class GempaResponse extends Equatable {
  GempaResponse({
    required this.infogempa,
  });

  final Infogempa infogempa;

  factory GempaResponse.fromJson(Map<String, dynamic> json) => GempaResponse(
        infogempa: Infogempa.fromJson(json["Infogempa"]),
      );

  Map<String, dynamic> toJson() => {
        "Infogempa": infogempa.toJson(),
      };

  @override
  List<Object?> get props => [infogempa];
}

class Infogempa extends Equatable {
  Infogempa({
    required this.gempa,
  });

  final List<Gempa> gempa;

  factory Infogempa.fromJson(Map<String, dynamic> json) => Infogempa(
        gempa: List<Gempa>.from(json["gempa"].map((x) => Gempa.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "gempa": List<dynamic>.from(gempa.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [gempa];
}

class Gempa extends Equatable {
  Gempa({
    required this.tanggal,
    required this.jam,
    required this.dateTime,
    required this.coordinates,
    required this.lintang,
    required this.bujur,
    required this.magnitude,
    required this.kedalaman,
    required this.wilayah,
    required this.potensi,
  });

  final String tanggal;
  final String jam;
  final DateTime dateTime;
  final String coordinates;
  final String lintang;
  final String bujur;
  final String magnitude;
  final String kedalaman;
  final String wilayah;
  final String potensi;

  factory Gempa.fromJson(Map<String, dynamic> json) => Gempa(
        tanggal: json["Tanggal"],
        jam: json["Jam"],
        dateTime: DateTime.parse(json["DateTime"]),
        coordinates: json["Coordinates"],
        lintang: json["Lintang"],
        bujur: json["Bujur"],
        magnitude: json["Magnitude"],
        kedalaman: json["Kedalaman"],
        wilayah: json["Wilayah"],
        potensi: json["Potensi"],
      );

  Map<String, dynamic> toJson() => {
        "Tanggal": tanggal,
        "Jam": jam,
        "DateTime": dateTime.toIso8601String(),
        "Coordinates": coordinates,
        "Lintang": lintang,
        "Bujur": bujur,
        "Magnitude": magnitude,
        "Kedalaman": kedalaman,
        "Wilayah": wilayah,
        "Potensi": potensi,
      };

  GempaEntity toEntity() {
    return GempaEntity(
      tanggal: this.tanggal,
      jam: this.jam,
      dateTime: this.dateTime,
      coordinates: this.coordinates,
      lintang: this.lintang,
      bujur: this.bujur,
      magnitude: this.magnitude,
      kedalaman: this.kedalaman,
      wilayah: this.wilayah,
      potensi: this.potensi,
    );
  }

  @override
  List<Object?> get props => [
        tanggal,
        jam,
        dateTime,
        coordinates,
        lintang,
        bujur,
        magnitude,
        kedalaman,
        wilayah,
        potensi,
      ];
}
