import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:io';

const String apiKey = 'AIzaSyCp9KbNf8s_S11v0ceKSMoQuM1cL5GnviE';
const String modelName = 'gemini-2.5-flash';

void main() async {
  print('Testing Gemini API Connection with $modelName...');
  
  try {
    final model = GenerativeModel(
      model: modelName,
      apiKey: apiKey,
    );

    final chat = model.startChat();
    print('Sending test message: "Hello"');
    final response = await chat.sendMessage(Content.text('Hello'));
    
    if (response.text != null) {
      print('SUCCESS: Received response!');
      print('Response: ${response.text}');
      exit(0);
    } else {
      print('FAILURE: Response was empty.');
      exit(1);
    }
  } catch (e) {
    print('FAILURE: Error occurred.');
    print(e);
    exit(1);
  }
}
