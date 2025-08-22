import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app/core/models/error_response.dart';
import 'package:music_app/features/auth/model/auth_response.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/features/user/model/get_current_user_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

@riverpod
AuthService authService(Ref ref) => AuthService();

class AuthService {
  Future<Either<ErrorResponse, AuthResponse>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return Left(
          ErrorResponse(message: data['message'] ?? 'Registration failed'),
        );
      }
      return Right(AuthResponse.fromJson(data));
    } catch (e) {
      return Left(ErrorResponse(message: 'Registration failed'));
    }
  }

  Future<Either<ErrorResponse, AuthResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return Left(ErrorResponse(message: data['message'] ?? 'Login failed'));
      }
      return Right(AuthResponse.fromJson(data));
    } catch (e) {
      return Left(ErrorResponse(message: 'Login failed'));
    }
  }

  Future<Either<ErrorResponse, GetCurrentUserResponse>> getCurrentUser(
    String token,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('${dotenv.env['API_URL']}/auth/me'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return Left(
          ErrorResponse(message: data['message'] ?? 'Failed to fetch profile'),
        );
      }
      return Right(GetCurrentUserResponse.fromJson(data));
    } catch (e) {
      return Left(ErrorResponse(message: 'Failed to fetch profile'));
    }
  }
}
