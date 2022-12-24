import 'package:e_health/resources/api_methods.dart';
import 'package:e_health/utils/colors.dart';
import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';

class DoctorDropdown extends StatefulWidget {
  const DoctorDropdown({super.key});

  @override
  State<DoctorDropdown> createState() => _DoctorDropdownState();
}

class _DoctorDropdownState extends State<DoctorDropdown> {
  String dropdownvalue = '';
  List? doctors;
  bool isLoading = false;

  doctorDropdown() async {
    List data = await APImethods().doctorDropdown();

    setState(() {
      doctors = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    doctorDropdown();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Doctor :',
          style: TextStyles.textHeader2.copyWith(color: CustomColors.black),
        ),
        const SizedBox(width: 20),
        !isLoading
            ? doctors != null
                ? DropdownButton(
                    value: dropdownvalue.isNotEmpty ? dropdownvalue : null,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: doctors?.map((doctor) {
                      return DropdownMenuItem(
                        value: doctor['doctorID'].toString(),
                        child: Text(
                          'Dr ${doctor['firstName'].toString()} ${doctor['lastName'].toString()}',
                          style: TextStyles.textHeader2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        dropdownvalue = value!;
                      });
                    },
                  )
                : const SizedBox()
            : SizedBox(
                height: 50,
                child: Row(
                  children: const [
                    SizedBox(width: 40),
                    SizedBox(
                        width: 10,
                        height: 10,
                        child: CircularProgressIndicator()),
                  ],
                ),
              )
      ],
    );
  }
}
