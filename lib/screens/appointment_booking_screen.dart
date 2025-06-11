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
      initialDate: DateTime.now()
    );
    if (picked != null){
      setState(() {
        _dateController.text = DateFormat('MMMM dd, yyyy').format(picked);
      });
    }
  }
  
  void _confirmAppointment() {
    if(_formKey.currentState!.validate()){
      AppointmentModel appointment = AppointmentModel(
          fullName: _nameController.text.trim(), 
          age: int.parse(_ageController.text.trim()), 
          gender: _gender, 
          speciality: _speciality, 
          appointmentDate: _dateController.text.trim(), 
          symptoms: _symptomsController.text.trim()
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AppointmentConfirmationScreen(appointment: appointment)),
      );
    }
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) => value!.isEmpty ? 'Name is required' : null,
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Age is required';
                  }
                  final age = int.tryParse(value);
                  return (age == null || age <=0 ) ? 'Enter a valid age' : null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _gender,
                items: ['Male', 'Female', 'Other'].map((g)=> DropdownMenuItem(value: g, child: Text(g))).toList(),
                onChanged: (val) => setState(() => _gender = val!),
                decoration: InputDecoration(labelText: 'Gender'),
              ),
              DropdownButtonFormField<String>(
                value: _speciality,
                items: ['Cardiologist', 'Dentist', 'Dermatologist', 'Oncologist', 'Other'].map((s)=> DropdownMenuItem(value: s, child: Text(s))).toList(),
                onChanged: (val) => setState(() => _speciality = val!),
                decoration: InputDecoration(labelText: 'Speciality'),
              ),
              TextFormField(
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                    labelText: 'Appointment Date',
                    suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () => _selectDate(context),
                validator: (value) => value!.isEmpty ? 'Date is required' : null,
              ),
              TextFormField(
                controller: _symptomsController,
                maxLines: 3,
                decoration: InputDecoration(labelText: 'Symptoms'),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                  onPressed: _confirmAppointment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text('Confirm Appointment'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
