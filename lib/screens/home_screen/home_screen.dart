import 'dart:convert';

import 'package:bordered_text/bordered_text.dart';
import 'package:e_health/components/bottombar.dart';
import 'package:e_health/resources/api_methods.dart';
import 'package:e_health/screens/disease_predic_screen/disease_predic_screen.dart';
import 'package:e_health/screens/home_screen/components/doctor_card.dart';
import 'package:e_health/screens/home_screen/components/hospital_card.dart';
import 'package:e_health/screens/prescription_sreen/prescription_sreen.dart';
import 'package:e_health/utils/colors.dart';
import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Map<String, dynamic> userCredentials = {'username': ' '};
  List? doctors;
  List? hospitals;
  bool isLoading = false;

  @override
  void initState() {
    getData();
    getDoctors();
    getHospitals();
    super.initState();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString('userCredentials');

    setState(() {
      userCredentials = jsonDecode(json!);
    });
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Hi, ${userCredentials['username']} 👋',
                    style: TextStyles.textHeader1
                        .copyWith(fontSize: 40, color: CustomColors.black),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'How can we help you today?',
                    style: TextStyles.textHeader2
                        .copyWith(fontSize: 30, color: CustomColors.black),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const BottomBar(
                                passIndex: 2,
                              )));
                    },
                    child: Container(
                      width: 180,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: const AssetImage(
                              'assets/images/appointment_bg.png'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              CustomColors.lightBlue.withOpacity(1),
                              BlendMode.dstATop),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Stack(
                          children: [
                            BorderedText(
                              strokeColor: CustomColors.black,
                              strokeWidth: 2,
                              child: Text(
                                "Appointments",
                                style: TextStyles.textHeader2.copyWith(
                                    fontSize: 25, color: CustomColors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const PrescriptionScreen()));
                    },
                    child: Container(
                      width: 180,
                      height: 160,
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: const AssetImage(
                              'assets/images/e_prescription.png'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              CustomColors.lightBlue.withOpacity(1),
                              BlendMode.dstATop),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: BorderedText(
                          strokeColor: CustomColors.black,
                          strokeWidth: 2,
                          child: Text(
                            "E-Prescriptions",
                            style: TextStyles.textHeader2.copyWith(
                                fontSize: 25, color: CustomColors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DiseasePredicScreen()));
                    },
                    child: Text(
                      'For quick checkup use our AI',
                      style: TextStyles.textHeader1
                          .copyWith(fontSize: 25, color: CustomColors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Popular Doctors',
                    style: TextStyles.textHeader1
                        .copyWith(fontSize: 25, color: CustomColors.black),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: doctors == null
                      ? const Center(child: CircularProgressIndicator())
                      : Row(
                          children: doctors!
                              .map((singleDoctor) =>
                                  DoctorCard(doctor: singleDoctor))
                              .toList(),
                        ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Popular Hospitals',
                    style: TextStyles.textHeader1
                        .copyWith(fontSize: 25, color: CustomColors.black),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: hospitals == null
                      ? const Center(child: CircularProgressIndicator())
                      : Row(
                          children: hospitals!
                              .map((singleHospital) =>
                                  HospitalCard(hospital: singleHospital))
                              .toList(),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
