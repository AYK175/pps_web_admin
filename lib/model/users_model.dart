class Users {
  String? cNIC;
  String? email;
  String? firstname;
  String? lastname;
  String? phnumber;
  String? profileImg;
  String? uid;
  int? wallet;

  Users(
      {this.cNIC,
        this.email,
        this.firstname,
        this.lastname,
        this.phnumber,
        this.profileImg,
        this.uid,
        this.wallet});

  Users.fromJson(Map<String, dynamic> json) {
    cNIC = json['CNIC'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phnumber = json['phnumber'];
    profileImg = json['profileImg'];
    uid = json['uid'];
    wallet = json['wallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['CNIC'] = cNIC;
    data['email'] = email;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['phnumber'] = phnumber;
    data['profileImg'] = profileImg;
    data['uid'] = uid;
    data['wallet'] = wallet;
    return data;
  }
}
