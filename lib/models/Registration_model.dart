class RegistrationData {
  String full_name;
  String email;
  String password;
  String address;
  String age;
  String gender;
  String phoneNumber;
  String membership;

  RegistrationData({
    this.full_name = '',
    this.email = '',
    this.password = '',
    this.address = '',
    this.age = '',
    this.gender = '',
    this.phoneNumber = '',
    this.membership = '',
  });
  @override
  String toString() {
    return 'RegistrationData{full_name: $full_name, email: $email, password: $password, fullAddress: $address, age: $age, gender: $gender, phoneNumber: $phoneNumber, membershipId: $membership}';
  }
}
