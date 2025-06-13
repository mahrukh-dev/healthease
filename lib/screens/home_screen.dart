import 'package:flutter/material.dart';
import 'package:healthease/screens/appointment_booking_screen.dart';
import 'package:healthease/screens/appointment_history_screen.dart';
import 'package:healthease/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("HealthEase"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.local_hospital,
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'HealthEase',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home_filled),
              title: Text('Home'),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Book Appointment'),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AppointmentBookingScreen())
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Appointment History'),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AppointmentHistoryScreen())
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to HealthEase',
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AppointmentBookingScreen())
                  );
                },
                child: Text('Book Appointment'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  padding: EdgeInsets.symmetric(horizontal:30, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
