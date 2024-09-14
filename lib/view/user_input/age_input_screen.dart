import 'package:bodybuilderaiapp/view/user_input/body_type_input_screen.dart';
import 'package:flutter/material.dart';

class AgeInputScreen extends StatefulWidget {
  const AgeInputScreen({super.key});

  @override
  State<AgeInputScreen> createState() => _AgeInputScreenState();
}

class _AgeInputScreenState extends State<AgeInputScreen> {
  String selectedAgeRange = '18-29';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Age Range'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedAgeRange,
              onChanged: (String? newValue) {
                setState(() {
                  selectedAgeRange = newValue!;
                });
              },
              items: <String>['18-29', '30-39', '40-49', '50-59', '60+']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BodyTypeInputScreen(),
                  ),
                );*/
              },
              child: Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
