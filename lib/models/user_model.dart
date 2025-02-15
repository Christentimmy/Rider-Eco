// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String? email;
  final String? phoneNumber;
  final String? firstName;
  final String? lastName;
  final String? dob;
  final String? address;
  final String? profilePicture;
  final bool? isEmailVerified;
  final bool? isPhoneNumberVerified;
  final DateTime? createdAt;
  final String? role;
  final bool? profileCompleted;
  final String? status;

  UserModel({
    required this.email,
    required this.phoneNumber,
    this.firstName,
    this.lastName,
    this.dob,
    this.address,
    this.profilePicture,
    required this.isEmailVerified,
    required this.isPhoneNumberVerified,
    required this.createdAt,
    required this.role,
    required this.profileCompleted,
    required this.status,
  });

  // Factory constructor to create an instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? "",
      phoneNumber: json['phone_number'] ?? "",
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      dob: json['dob'] ?? "",
      address: json['address'] ?? "",
      profilePicture: json['profile_picture'] ?? "",
      isEmailVerified: json['is_email_verified'] ?? "",
      isPhoneNumberVerified: json['is_phone_number_verified'] ?? "",
      createdAt: DateTime.parse(json['created_At'] ?? ""),
      role: json['role'] ?? "",
      profileCompleted: json['profile_completed'] ?? "",
      status: json['status'] ?? "",
    );
  }

  // Convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email ?? "",
      'phone_number': phoneNumber ?? "",
      'first_name': firstName ?? "",
      'last_name': lastName ?? "",
      'dob': dob ?? "",
      'address': address ?? "",
      'profile_picture': profilePicture ?? "",
      'is_email_verified': isEmailVerified ?? "",
      'is_phone_number_verified': isPhoneNumberVerified ?? "",
      'created_At': createdAt?.toIso8601String() ?? "",
      'role': role ?? "",
      'profile_completed': profileCompleted ?? "",
      'status': status ?? "",
    };
  }

  @override
  String toString() {
    return 'UserModel(email: $email, phoneNumber: $phoneNumber, firstName: $firstName, lastName: $lastName, dob: $dob, address: $address, profilePicture: $profilePicture, isEmailVerified: $isEmailVerified, isPhoneNumberVerified: $isPhoneNumberVerified, createdAt: $createdAt, role: $role, profileCompleted: $profileCompleted, status: $status)';
  }
}
