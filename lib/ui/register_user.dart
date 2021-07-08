import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
      ),
      body: Center(
          child: Column(
        children: [
          TextFormField(),
          TextFormField(),
          ElevatedButton(
            child: Text("Register"),
            onPressed: () {},
          )
        ],
      )),
    );
  }
}
