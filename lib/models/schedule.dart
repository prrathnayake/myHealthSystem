import 'dart:ffi';

class Schedule {
  final int scheduleID;
  final int doctorID;
  final int patientID;
  final int hospitalID;
  final String scheduledDate;
  final String updateDate;
  final String appointmentDate;
  final String? description;

  const Schedule({
    required this.scheduleID,
    required this.doctorID,
    required this.patientID,
    required this.hospitalID,
    required this.scheduledDate,
    required this.updateDate,
    required this.appointmentDate,
    required this.description,
  });

  static Schedule fromJson(json) => Schedule(
        scheduleID: json['scheduleID'],
        doctorID: json['doctorID'],
        patientID: json['patientID'],
        hospitalID: json['hospitalID'],
        scheduledDate: json['scheduledDate'],
        updateDate: json['updateDate'],
        appointmentDate: json['appointmentDate'],
        description: json['description'],
      );
}
