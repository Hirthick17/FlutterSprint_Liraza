import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:io';

const String apiKey = 'AIzaSyCp9KbNf8s_S11v0ceKSMoQuM1cL5GnviE';
const String modelName = 'gemini-2.5-flash';

void main() async {
  print('Testing Gemini API with System Instruction...');
  
  try {
    final model = GenerativeModel(
      model: modelName,
      apiKey: apiKey,
      systemInstruction: Content.system('You are a helpful assistant.'),
    );

    final chat = model.startChat();
    print('Sending message...');
    final response = await chat.sendMessage(Content.text('Hello'));
    
    if (response.text != null) {
      print('SUCCESS: Response received with system instruction.');
      print('Response: ${response.text}');
      exit(0);
    } else {
      print('FAILURE: Empty response.');
      exit(1);
    }
  } catch (e) {
    print('FAILURE: Error occurred.');
    print(e);
    exit(1);
  }
}
