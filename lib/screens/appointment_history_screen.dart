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
  void initState() {
    super.initState();
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> savedData = prefs.getStringList('appointments') ?? [];

    setState(() {
      _appointments = savedData.map((jsonStr) {
        final map = jsonDecode(jsonStr);
        return AppointmentModel.fromMap(map);
      }).toList().reversed.toList();
    });
  }

  Widget _buildAppointmentCard(AppointmentModel appointment) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, color: AppColors.primaryColor),
                const SizedBox(width: 8),
                Text(
                  appointment.fullName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Chip(
                  label: Text("${appointment.age} yrs"),
                  backgroundColor: AppColors.secondaryColor.withOpacity(0.2),
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.local_hospital, size: 18, color: Colors.grey),
                SizedBox(width: 6),
                Text("Speciality: ${appointment.speciality}", style: TextStyle(fontSize: 15)),
              ],
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                SizedBox(width: 6),
                Text("Date: ${appointment.appointmentDate}", style: TextStyle(fontSize: 15)),
              ],
            ),
            SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.description, size: 18, color: Colors.grey),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    "Symptoms: ${appointment.symptoms.isEmpty ? 'N/A' : appointment.symptoms}",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 60, color: Colors.grey),
          SizedBox(height: 10),
          Text(
            "No appointments found.",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previous Appointments'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: _appointments.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
        itemCount: _appointments.length,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemBuilder: (context, index) {
          return _buildAppointmentCard(_appointments[index]);
        },
      ),
    );
  }
}
