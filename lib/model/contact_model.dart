class ContactModel {
  String firstName;
  String id;
  String lastName;
  String email;
  String notes;
  String phone;
  List picture;

  ContactModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.notes,
    required this.phone,
    required this.picture,
    required this.id,
  });

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['_id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      notes: map['notes'] as String,
      phone: map['phone'] as String,
      picture: map['picture'] ?? [],
    );
  }

  //*Data Example
  //"firstName": "Herma",
  //"lastName": "Sauer",
  //"email": "Verda_Hickle@Ocie.biz",
  //"notes": "Oman",
  //"phone": "0.33784882305189967",
  //"picture": [
  //  "https://img.freepik.com/free-photo/pleasant-looking-serious-man-stands-profile-has-confident-expression-wears-casual-white-t-shirt_273609-16959.jpg"
  //]
}
