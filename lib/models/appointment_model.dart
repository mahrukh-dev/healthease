class AppointmentModel {
  String fullName;
  int age;
  String gender;
  String speciality;
  String appointmentDate;
  String symptoms;

  AppointmentModel({
      required this.fullName,
      required this.age,
      required this.gender,
      required this.speciality,
      required this.appointmentDate,
      required this.symptoms,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'age': age,
      'gender': gender,
      'speciality': speciality,
      'appointmentDate': appointmentDate,
      'symptoms': symptoms,
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
        fullName: map['fullName'],
        age: map['age'],
        gender: map['gender'],
        speciality: map['speciality'],
        appointmentDate: map['appointmentDate'],
        symptoms: map['symptoms']
    );
  }
}