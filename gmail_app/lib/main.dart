import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final controllerName = TextEditingController();
  final controllerTo = TextEditingController();
  final controllerFrom = TextEditingController();
  final controllerSubject = TextEditingController();
  final controllerMessage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Launch Email'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            buildTextField(title: 'Name', controller: controllerName),
            SizedBox(
              height: 8,
            ),
            buildTextField(title: 'From', controller: controllerFrom),
            SizedBox(
              height: 8,
            ),
            buildTextField(title: 'To', controller: controllerTo),
            SizedBox(
              height: 8,
            ),
            buildTextField(title: 'Subject', controller: controllerSubject),
            SizedBox(
              height: 8,
            ),
            buildTextField(
                title: 'Message', controller: controllerMessage, maxLines: 8),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    textStyle: TextStyle(fontSize: 20)),
                child: Text('SEND'),
                onPressed: () => sendEmail(
                    name: controllerName.text,
                    toEmail: controllerTo.text,
                    fromEmail: controllerFrom.text,
                    message: controllerMessage.text,
                    subject: controllerSubject.text)
                //   launchEmail(
                //        toEmail: controllerTo.text,
                //       subject: controllerSubject.text,
                //       message: controllerMessage.text),
                //
                ),
          ],
        ),
      ),
    );
  }

  // Future launchEmail({
  //   @required String toEmail,
  //   @required String subject,
  //   @required String message,
  // }) async {
  //   final Url =
  //       'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';
  //   if (await canLaunch(Url)) {
  //     await launch(Url);
  //   }
  // }
  Future sendEmail({
    @required String name,
    @required String fromEmail,
    @required String toEmail,
    @required String subject,
    @required String message,
  }) async {
    final serviceId = 'service_qk6asfe';
    final templateId = 'template_vnvl2hm';
    final userId = 'user_t2YYJqobM7zI2dT6ovAQJ';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json'
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'to_name': name,
          'user_email': fromEmail,
          'to_email': toEmail,
          'user_subject': subject,
          'user_message': message,
        }
      }),
    );
    print(response.body);
  }

  Widget buildTextField({
    @required String title,
    @required TextEditingController controller,
    int maxLines = 1,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(border: OutlineInputBorder()),
          )
        ],
      );
}
