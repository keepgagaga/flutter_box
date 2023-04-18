import 'package:flutter/material.dart';

class CustomForm extends StatefulWidget {
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  Widget build(context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your name.';
              }
              return null;
            },
            onSaved: (value) {},
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'email'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email.';
              }
              return null;
            },
            onSaved: (value) {},
          ),
        ],
      ),
    );
  }
}
