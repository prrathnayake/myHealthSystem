import 'package:e_health/resources/api_methods.dart';
import 'package:e_health/screens/hospitals_screen/components/hospital_card.dart';
import 'package:flutter/material.dart';

class HospitalsScreen extends StatefulWidget {
  const HospitalsScreen({super.key});

  @override
  State<HospitalsScreen> createState() => _HospitalsScreenState();
}

class _HospitalsScreenState extends State<HospitalsScreen> {
  List? hospitals;
  bool isLoading = false;

  @override
  void initState() {
    getHospitals();
    super.initState();
  }

  getHospitals() async {
    setState(() {
      isLoading = true;
    });
    List data = await APImethods().getHospitals();

    setState(() {
      hospitals = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: hospitals == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: hospitals!
                      .map((singleDoctor) =>
                          HorizontalHospitalCard(hospital: singleDoctor))
                      .toList(),
                ),
              ),
      ),
    );
  }
}
