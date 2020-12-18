import 'dart:convert';

class Profile {
  String id;
  String nama, harga, stok;

  Profile({this.id, this.nama, this.harga, this.stok});

  factory Profile.fromJson(Map<String, dynamic> map) {
    return Profile(
      id: map["id"],
      nama: map["nama"],
      harga: map["harga"],
      stok: map["stok"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "nama": nama, "harga": harga, "stok": stok};
  }

  @override
  String toString() {
    return 'Profile{id: $id, nama: $nama, harga: $harga, stok: $stok}';
  }
}

List<Profile> profileFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Profile>.from(data.map((item) => Profile.fromJson(item)));
}

String profileToJson(Profile data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
