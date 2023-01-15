import 'package:e_health/resources/api_methods.dart';
import 'package:e_health/screens/doctors_screen/components/doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  List? doctors;
  bool isLoading = false;

  @override
  void initState() {
    getDoctors();
    super.initState();
  }

  getDoctors() async {
    setState(() {
      isLoading = true;
    });
    List data = await APImethods().getDoctors();

    setState(() {
      doctors = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: doctors == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: doctors!
                      .map((singleDoctor) =>
                          HorizontalDoctorCard(doctor: singleDoctor))
                      .toList(),
                ),
              ),
      ),
    );
  }
}
