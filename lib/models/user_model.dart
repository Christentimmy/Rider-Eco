
class UserModel {
  final String? id;
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
  String? password;

  UserModel({
    this.id,
    this.email,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.dob,
    this.address,
    this.profilePicture,
    this.isEmailVerified,
    this.isPhoneNumberVerified,
    this.createdAt,
    this.role,
    this.profileCompleted,
    this.status,
    this.password,
  });


  factory UserModel.fromJson(json) {
    return UserModel(
      id: json['_id'] ?? "", 
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
    final Map<String, dynamic> data = {};

    if (email?.isNotEmpty == true) {
      data['email'] = email!;
    }
    if (phoneNumber?.isNotEmpty == true) {
      data['phone_number'] = phoneNumber!;
    }
    if (firstName?.isNotEmpty == true) {
      data['first_name'] = firstName!;
    }
    if (lastName?.isNotEmpty == true) {
      data['last_name'] = lastName!;
    }
    if (dob?.isNotEmpty == true) {
      data['dob'] = dob!;
    }
    if (address?.isNotEmpty == true) {
      data['address'] = address!;
    }
    if (profilePicture?.isNotEmpty == true) {
      data['profile_picture'] = profilePicture!;
    }
    if (isEmailVerified != null) {
      data['is_email_verified'] = isEmailVerified!;
    }
    if (isPhoneNumberVerified != null) {
      data['is_phone_number_verified'] = isPhoneNumberVerified!;
    }
    if (createdAt != null) {
      data['created_At'] = createdAt!.toIso8601String();
    }
    if (role?.isNotEmpty == true) {
      data['role'] = role!;
    }
    if (profileCompleted != null) {
      data['profile_completed'] = profileCompleted!;
    }
    if (status?.isNotEmpty == true) {
      data['status'] = status!;
    }
    if (password?.isNotEmpty == true) {
      data['password'] = password!;
    }

    return data;
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, phoneNumber: $phoneNumber, firstName: $firstName, lastName: $lastName, dob: $dob, address: $address, profilePicture: $profilePicture, isEmailVerified: $isEmailVerified, isPhoneNumberVerified: $isPhoneNumberVerified, createdAt: $createdAt, role: $role, profileCompleted: $profileCompleted, status: $status)';
  }
}
