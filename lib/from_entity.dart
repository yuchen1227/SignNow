/// firstName : ""
/// lastName : ""
/// email : ""

class FromEntity {
  String firstName;
  String lastName;
  String email;

  FromEntity({
      this.firstName, 
      this.lastName, 
      this.email});

  FromEntity.fromJson(dynamic json) {
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["firstName"] = firstName;
    map["lastName"] = lastName;
    map["email"] = email;
    return map;
  }

}