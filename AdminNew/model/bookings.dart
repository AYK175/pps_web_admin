class Bookings {
  String? userEmail;
  String? bookingEnd;
  String? userPhoneNumber;
  int? servicePrice;
  int? serviceDuration;
  String? bookingStart;
  String? serviceName;
  String? userId;
  String? serviceId;
  String? userName;

  Bookings(
      {this.userEmail,
        this.bookingEnd,
        this.userPhoneNumber,
        this.servicePrice,
        this.serviceDuration,
        this.bookingStart,
        this.serviceName,
        this.userId,
        this.serviceId,
        this.userName});

  Bookings.fromJson(Map<String, dynamic> json) {
    userEmail = json['userEmail'];
    bookingEnd = json['bookingEnd'];
    userPhoneNumber = json['userPhoneNumber'];
    servicePrice = json['servicePrice'];
    serviceDuration = json['serviceDuration'];
    bookingStart = json['bookingStart'];
    serviceName = json['serviceName'];
    userId = json['userId'];
    serviceId = json['serviceId'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userEmail'] = userEmail;
    data['bookingEnd'] = bookingEnd;
    data['userPhoneNumber'] = userPhoneNumber;
    data['servicePrice'] = servicePrice;
    data['serviceDuration'] = serviceDuration;
    data['bookingStart'] = bookingStart;
    data['serviceName'] = serviceName;
    data['userId'] = userId;
    data['serviceId'] = serviceId;
    data['userName'] = userName;
    return data;
  }
}