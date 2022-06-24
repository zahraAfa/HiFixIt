import 'package:flutter/material.dart';
import 'package:hifixit/app/controllers/utils.dart';

class MessageField {
  static final String createdAt = 'createdAt';
}

class Message {
  final String userId;
  final String userPicture;
  final String email;
  final String message;
  final DateTime createdAt;
  final String userType; //cust, tech

  const Message({
    required this.userId,
    required this.userPicture,
    required this.email,
    required this.message,
    required this.createdAt,
    required this.userType,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
        userId: json['userId'],
        userPicture: json['userPhoto'],
        email: json['email'],
        message: json['message'],
        userType: json['userType'],
        createdAt: Utils.toDateTime(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'userPhoto': userPicture,
        'email': email,
        'message': message,
        'userType': userType,
        'createdAt': Utils.fromDateTimeToJson(createdAt),
      };
}
