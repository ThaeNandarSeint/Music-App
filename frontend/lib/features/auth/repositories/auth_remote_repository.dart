import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthRemoteRepository {
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await http.post(
      Uri.parse('${dotenv.env['API_URL']}/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );
  }

  Future<void> login({required String email, required String password}) async {
    await http.post(
      Uri.parse('${dotenv.env['API_URL']}/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
  }
}
