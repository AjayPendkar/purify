import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:async' show TimeoutException;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:purify/features/auth/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/connectivity_service.dart';

class ApiClient extends GetxService {
  final String baseUrl;
  final SharedPreferences sharedPreferences;
  static final String noInternetMessage = 'Connection failed';
  final int timeoutInSeconds = 30;

  late String token;
  late Map<String, String> _mainHeaders;

  ApiClient({
    required this.baseUrl,
    required this.sharedPreferences,
  }) {
    token = sharedPreferences.getString('token') ?? '';
    updateHeader(token);
  }

  void updateHeader(String token) {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }

  String get _baseUrl {
    if (Platform.isAndroid) {
      return baseUrl.replaceAll('localhost', '10.0.2.2');
    }
    return baseUrl;
  }

  // GET Request
  Future<Response> getData(
    String uri, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      if (query != null) {
        uri += '?' + _encodeQueryParameters(query);
      }
      
      _logRequest('GET', uri, headers: headers);
      
      final response = await http.get(
        Uri.parse(_baseUrl + uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      
      return handleResponse(response, uri);
    } catch (e) {
      return handleError(e, uri);
    }
  }

  // POST Request
  Future<Response> postData(
    String uri,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    try {
      final url = Uri.parse(baseUrl + uri);
      print('Attempting to connect to: $url');
      
      final response = await http.post(
        url,
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(
        Duration(seconds: timeoutInSeconds),
        onTimeout: () {
          throw TimeoutException('Connection timed out');
        },
      );
      
      return handleResponse(response, uri);
    } catch (e) {
      print('Error in postData: $e');
      if (e.toString().contains('Connection refused')) {
        return Response(
          statusCode: -1,
          statusText: 'Server not reachable',
          body: {'message': 'Unable to connect to server. Please check if server is running.'}
        );
      }
      return Response(
        statusCode: -1,
        statusText: 'Connection error',
        body: {'message': e.toString()}
      );
    }
  }

  // PUT Request
  Future<Response> putData(
    String uri,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    try {
      _logRequest('PUT', uri, body: body, headers: headers);
      
      final response = await http.put(
        Uri.parse(_baseUrl + uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      
      return handleResponse(response, uri);
    } catch (e) {
      return handleError(e, uri);
    }
  }

  // DELETE Request
  Future<Response> deleteData(
    String uri, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {
      _logRequest('DELETE', uri, body: body, headers: headers);
      
      final response = await http.delete(
        Uri.parse(_baseUrl + uri),
        headers: headers ?? _mainHeaders,
        body: body != null ? jsonEncode(body) : null,
      ).timeout(Duration(seconds: timeoutInSeconds));
      
      return handleResponse(response, uri);
    } catch (e) {
      return handleError(e, uri);
    }
  }

  // PATCH Request
  Future<Response> patchData(
    String uri,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    try {
      _logRequest('PATCH', uri, body: body, headers: headers);
      
      final response = await http.patch(
        Uri.parse(_baseUrl + uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      
      return handleResponse(response, uri);
    } catch (e) {
      return handleError(e, uri);
    }
  }

  // Handle Response
  Future<Response> handleResponse(http.Response response, String uri) async {
    if (!Get.find<ConnectivityService>().isConnected) {
      return Response(
        statusCode: -1,
        statusText: 'No Internet Connection',
        body: {'message': 'Please check your internet connection'},
      );
    }

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
    
    if (response.statusCode == 401) {
      Get.find<AuthService>().handleTokenExpiration();
    }

    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {
      body = response.body;
    }

    return Response(
      body: body,
      bodyString: response.body.toString(),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
  }

  // Handle Error
  Response handleError(dynamic error, String uri) {
    _logError(uri, error);
    
    if (error ) {
      if (error.toString().contains('Connection refused')) {
        return Response(
          statusCode: -1,
          statusText: 'Server is not reachable',
          body: {'message': 'Unable to connect to server. Please try again later.'}
        );
      }
      return Response(
        statusCode: -1, 
        statusText: 'Connection error',
        body: {'message': 'Network connection error'}
      );
    }
    
    return Response(
      statusCode: -1, 
      statusText: error.toString(),
      body: {'message': 'An unexpected error occurred'}
    );
  }

  // Utility Methods
  String _encodeQueryParameters(Map<String, dynamic> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');
  }

  void _handleUnauthorized() {
    // Clear token and navigate to login
    sharedPreferences.remove('token');
    Get.offAllNamed('/login');
  }

  // Logging Methods
  void _logRequest(String method, String uri, {dynamic body, Map<String, String>? headers}) {
    print('====> $method Request: $uri');
    if (body != null) print('====> Body: $body');
    print('====> Headers: ${headers ?? _mainHeaders}');
  }

  void _logError(String uri, dynamic error) {
    print('====> Error: [$uri] ${error.toString()}');
  }

  void setToken(String token) {
    this.token = token;
    updateHeader(token);
  }
} 