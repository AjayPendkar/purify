import 'package:gsheets/gsheets.dart';

class GoogleSheetsService {
  static const _credentials = r'''
  {
    "type": "service_account",
    "project_id": "purify-412805",
    "private_key_id": "c6a2fef4d77cff5c5b5d8c9e9c9c9c9c",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDK3p+nX+LNhz0B\n-----END PRIVATE KEY-----\n",
    "client_email": "purify@purify-412805.iam.gserviceaccount.com",
    "client_id": "117317595154907988763",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/purify%40purify-412805.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
  ''';
  
  static const _spreadsheetId = '1xdtFXiK816MZ4m632S6HIK1aqGtdoWDhhRgsE4ICmlA';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future<void> init() async {
    try {
      final ss = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await ss.worksheetByTitle('UserInfo');
      print('Sheet initialized successfully');
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<void> registerNewUser(String phone) async {
    if (_userSheet == null) {
      print('Sheet not initialized');
      return;
    }
    
    try {
      final newRow = [
        phone,           // Phone
        '',             // Name
        '',             // Gender
        '',             // DOB
        '',             // Health Issues
        '',             // Wake Up Time
        DateTime.now().toIso8601String(), // Created At
      ];
      await _userSheet!.values.appendRow(newRow);
      print('New user registered with phone: $phone');
    } catch (e) {
      print('Register Error: $e');
    }
  }

  static Future<bool> isPhoneRegistered(String phone) async {
    if (_userSheet == null) return false;
    try {
      final phoneNumbers = await _userSheet!.values.column(1);
      return phoneNumbers.contains(phone);
    } catch (e) {
      print('Check Phone Error: $e');
      return false;
    }
  }

  static Future<Map<String, dynamic>?> getUserByPhone(String phone) async {
    if (_userSheet == null) return null;
    try {
      final phoneNumbers = await _userSheet!.values.column(1);
      final rowIndex = phoneNumbers.indexOf(phone);
      if (rowIndex != -1) {
        final userData = await _userSheet!.values.row(rowIndex + 1);
        return {
          'phone': userData[0],
          'name': userData[1],
          'gender': userData[2],
          'dob': userData[3],
          'healthIssues': userData[4],
          'wakeUpTime': userData[5],
          'createdAt': userData[6],
        };
      }
    } catch (e) {
      print('Fetch Error: $e');
    }
    return null;
  }

  static Future<void> insertUser({
    required String phone,
    required String name,
    required String gender,
    required String dob,
    required List<String> healthIssues,
    required String wakeUpTime,
  }) async {
    if (_userSheet == null) return;
    
    try {
      final phoneNumbers = await _userSheet!.values.column(1);
      final rowIndex = phoneNumbers.indexOf(phone);
      
      final newRow = [
        phone,
        name,
        gender,
        dob,
        healthIssues.join(', '),
        wakeUpTime,
        DateTime.now().toIso8601String(),
      ];

      if (rowIndex != -1) {
        // Update existing user
        await _userSheet!.values.insertRow(rowIndex + 1, newRow);
      } else {
        // Add new user
        await _userSheet!.values.appendRow(newRow);
      }
    } catch (e) {
      print('Insert Error: $e');
    }
  }
} 