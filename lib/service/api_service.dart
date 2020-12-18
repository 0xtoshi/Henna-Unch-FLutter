import 'package:http/http.dart' show Client;

import '../models/profile.dart';

class ApiService {
  final String baseUrl = "https://5fd7016f9dd0db0017ee8acf.mockapi.io";
  Client client = Client();

  Future<List<Profile>> getProfiles() async {
    final response = await client.get("$baseUrl/data");
    if (response.statusCode == 200) {
      return profileFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createProfile(Profile data) async {
    final response = await client.post(
      "$baseUrl/data",
      headers: {"content-type": "application/json"},
      body: profileToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProfile(Profile data) async {
    final response = await client.put(
      "$baseUrl/data/${data.id}",
      headers: {"content-type": "application/json"},
      body: profileToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteProfile(int id) async {
    final response = await client.delete(
      "$baseUrl/data/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
