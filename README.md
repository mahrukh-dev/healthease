# healthease

App where patients can book appointment and data is stored loccally using SharedPreferences

## Home Screen
- Displays a welcome message: "Welcome to HealthEase"
- A button: Book Appointment
- Tapping it navigates to the Appointment Booking Screen

## Appointment Booking Screen
- Form fields: Full Name, Age, Gender, Speciality, Appointment Date, Symptoms
- Ensure form validation is in place
- A button: Confirm Appointment
- On tap, validate the form and navigate to the confirmation screen with entered details.
- Used TextEditingController for form handling
- Use Flutter's built-in DatePicker

## Appointment Confirmation Screen
- Show all entered details
- Show a "Back to Home" button
- Store appointment details in SharedPreferences
   
## Appointments History screen
- Show all previous appointments from local data stored using shared preferences

## Features Implemented:
- Used Provider for state management
- Created a simple model class AppointmentModel to manage appointment data
- Applied basic theming by implement AppColors class
