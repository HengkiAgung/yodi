import "user_model.dart";

class Seller {
  late User? user;

  Seller({
    required this.user,
  });

  Seller.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    return data;
  }
}
