import 'package:flutter/material.dart';
import 'package:healthease/models/appointment_model.dart';
import 'package:healthease/screens/appointment_confirmation_screen.dart';
import 'package:healthease/theme/app_colors.dart';
import 'package:intl/intl.dart';

class AppointmentBookingScreen extends StatefulWidget {
  const AppointmentBookingScreen({super.key});

  @override
  State<AppointmentBookingScreen> createState() => _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _symptomsController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String _gender = 'Male';
  String _speciality = 'Cardiologist';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('MMMM dd, yyyy').format(picked);
      });
    }
  }

  void _confirmAppointment() {
    if (_formKey.currentState!.validate()) {
      AppointmentModel appointment = AppointmentModel(
        fullName: _nameController.text.trim(),
        age: int.parse(_ageController.text.trim()),
        gender: _gender,
        speciality: _speciality,
        appointmentDate: _dateController.text.trim(),
        symptoms: _symptomsController.text.trim(),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AppointmentConfirmationScreen(appointment: appointment)),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment Confirmed!')),
      );
    }
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Patient Details",
                      style: Theme.of(context).textTheme.titleLarge
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: _inputDecoration('Full Name', Icons.person),
                    validator: (value) => value!.isEmpty ? 'Name is required' : null,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration('Age', Icons.calendar_today),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Age is required';
                      final age = int.tryParse(value);
                      return (age == null || age <= 0) ? 'Enter a valid age' : null;
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _gender,
                    decoration: _inputDecoration('Gender', Icons.transgender),
                    items: ['Male', 'Female', 'Other']
                        .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                        .toList(),
                    onChanged: (val) => setState(() => _gender = val!),
                  ),
                  SizedBox(height: 30),
                  Text(
                      "Appointment Details",
                      style: Theme.of(context).textTheme.titleLarge
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _speciality,
                    decoration: _inputDecoration('Speciality', Icons.medical_services),
                    items: ['Cardiologist', 'Dentist', 'Dermatologist', 'Oncologist', 'Other']
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (val) => setState(() => _speciality = val!),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _dateController,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    decoration: _inputDecoration('Appointment Date', Icons.date_range).copyWith(
                      hintText: 'Select a date',
                    ),
                    validator: (value) => value!.isEmpty ? 'Date is required' : null,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _symptomsController,
                    maxLines: 3,
                    decoration: _inputDecoration('Symptoms', Icons.notes),
                    validator: (value) => value != null && value.trim().length < 5
                        ? 'Please describe your symptoms'
                        : null,
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: _confirmAppointment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        'Confirm Appointment',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
