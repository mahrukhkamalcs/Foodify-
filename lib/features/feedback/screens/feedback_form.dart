import 'package:flutter/material.dart';

class FeedbackForm extends StatefulWidget {
  static const routeName = '/feedback';
  const FeedbackForm({Key? key}) : super(key: key);

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  String name = '', email = '', message = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Feedback submitted successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feedback')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (v) => v!.isEmpty ? 'Enter your name' : null,
              onSaved: (v) => name = v!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (v) => v!.contains('@') ? null : 'Invalid email',
              onSaved: (v) => email = v!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Message'),
              validator: (v) => v!.isEmpty ? 'Enter a message' : null,
              onSaved: (v) => message = v!,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Submit'),
            ),
          ]),
        ),
      ),
    );
  }
}
