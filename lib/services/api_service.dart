import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<String> getOnboardingText() async {
    var url = Uri.parse('http://localhost:11434/api/generate');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "llama3",
        "prompt": "Generate a short notice for a fitness app using AI, between 5 to 10 words.",
        //fixme ?
        "stream": false,
      }),
    );

    print(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['response']; // Assuming the API returns the text in a 'text' field
    } else {
      throw Exception('Failed to generate text');
    }
  }
}
