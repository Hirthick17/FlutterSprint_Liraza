import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiKey = 'AIzaSyCp9KbNf8s_S11v0ceKSMoQuM1cL5GnviE';

void main() async {
  print('Listing Available Models...');
  final url = 'https://generativelanguage.googleapis.com/v1beta/models?key=$apiKey';
  
  try {
    final response = await http.get(Uri.parse(url));
    
    print('Status: ${response.statusCode}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final models = data['models'];
      if (models != null) {
        for (var m in models) {
          print('Found: ${m['name']}');
        }
      } else {
        print('No models found in response.');
        print(response.body); // Print body just in case
      }
    } else {
      print('Error Body: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
