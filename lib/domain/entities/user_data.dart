import 'package:equatable/equatable.dart';

class UserData extends Equatable {

  UserData({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.photoURL
  });
  final String uid;
  final String displayName;
  final String email;
  final String? photoURL;
  
  @override
  List<Object?> get props => [
    uid,
    displayName,
    email,
    photoURL
  ];

}