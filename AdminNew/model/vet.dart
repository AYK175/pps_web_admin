class Vets {
  String? profileStatus;
  String? profileType;
  String? profileUnapprovalReason;
  String? vetLiceance;
  String? cnic;
  String? description;
  String? email;
  String? name;
  String? phoneNumber;
  String? profileImg;
  String? qualification;
  String? specialization;
  String? uid;
  String? year;
  String? price;

  Vets(
      {this.profileStatus,
        this.profileType,
        this.profileUnapprovalReason,
        this.vetLiceance,
        this.cnic,
        this.description,
        this.email,
        this.name,
        this.phoneNumber,
        this.profileImg,
        this.qualification,
        this.specialization,
        this.uid,
        this.year});

  Vets.fromJson(Map<String, dynamic> json) {
    profileStatus = json['ProfileStatus'];
    profileType = json['ProfileType'];
    profileUnapprovalReason = json['ProfileUnapprovalReason'];
    vetLiceance = json['VetLiceance'];
    cnic = json['cnic'];
    description = json['description'];
    email = json['email'];
    name = json['name'];
    phoneNumber = json['phone number'];
    profileImg = json['profileImg'];
    qualification = json['qualification'];
    specialization = json['specialization'];
    uid = json['uid'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['ProfileStatus'] = profileStatus;
    data['ProfileType'] = profileType;
    data['ProfileUnapprovalReason'] = profileUnapprovalReason;
    data['VetLiceance'] = vetLiceance;
    data['cnic'] = cnic;
    data['description'] = description;
    data['email'] = email;
    data['name'] = name;
    data['phone number'] = phoneNumber;
    data['profileImg'] = profileImg;
    data['qualification'] = qualification;
    data['specialization'] = specialization;
    data['uid'] = uid;
    data['year'] = year;
    return data;
  }
}