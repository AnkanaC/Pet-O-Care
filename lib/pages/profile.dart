import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PetProfilePage extends StatefulWidget {
  const PetProfilePage({super.key});

  @override
  State<PetProfilePage> createState() => _PetProfilePageState();
}

class _PetProfilePageState extends State<PetProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final uid = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance.collection('pets').add({
        ..._formData,
        'ownerId': uid,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pet profile saved')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pet Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField('name'),
              _buildTextField('species'),
              _buildTextField('breed'),
              _buildTextField('age'),
              _buildTextField('weight'),
              _buildTextField('gender'),
              _buildTextField('vaccination Status'),
              _buildTextField('allergies'),
              _buildTextField('medical History'),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _saveProfile, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String field) {
    return TextFormField(
      decoration: InputDecoration(labelText: field[0].toUpperCase() + field.substring(1)),
      onSaved: (value) => _formData[field] = value ?? '',
      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
    );
  }
}
