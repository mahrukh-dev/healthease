import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthease/models/appointment_model.dart';
import 'package:healthease/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentHistoryScreen extends StatefulWidget {
  const AppointmentHistoryScreen({super.key});

  @override
  State<AppointmentHistoryScreen> createState() => _AppointmentHistoryScreenState();
}

class _AppointmentHistoryScreenState extends State<AppointmentHistoryScreen> {

  List<AppointmentModel> _appointments = [];

  @override
  void initState(){
    super.initState();
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> savedData = prefs.getStringList('appointments') ?? [];

    setState(() {
      _appointments = savedData.map((jsonStr){
        final map = jsonDecode(jsonStr);
        return AppointmentModel.fromMap(map);
      }).toList().reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previous Appointments'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: _appointments.isEmpty
          ?  Center(
              child: Text(
                "No appointments found.",
                style: TextStyle(fontSize: 18),
              ),
          ) :
      ListView.builder(
        itemCount: _appointments.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context,index) {
          final appointment = _appointments[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(appointment.fullName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Speciality: ${appointment.speciality}"),
                  Text("Date: ${appointment.appointmentDate}"),
                  Text("Symptoms: ${appointment.symptoms.isEmpty ? 'N/A' : appointment.symptoms}"),
                ],
              ),
              trailing: Text("${appointment.age} yrs"),
            ),
          );
        },
      ),
    );
  }
}
