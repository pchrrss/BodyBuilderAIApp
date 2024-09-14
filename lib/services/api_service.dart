import 'package:bodybuilderaiapp/view/user_input/user_input_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<String> generateFitnessPlan(UserInputModel userInput) async {
    final fitnessPlanRequest = userInput.generateFitnessPlanRequest();
    print(fitnessPlanRequest);
    var url = Uri.parse('http://localhost:11434/api/generate');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "llama3",
        "prompt": fitnessPlanRequest,
        //fixme ?
        "stream": false,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['response'];
    } else {
      throw Exception('Failed to generate text');
    }
  }
}
