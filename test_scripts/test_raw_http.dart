import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiKey = 'AIzaSyCp9KbNf8s_S11v0ceKSMoQuM1cL5GnviE';
// Try gemini-1.5-flash first
const String model = 'gemini-pro'; 

void main() async {
  print('Testing Raw HTTP Connection to $model...');
  final url = 'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$apiKey';
  
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': 'Hello'}
            ]
          }
        ]
      }),
    );
    
    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');
  } catch (e) {
    print('Error: $e');
  }
}
