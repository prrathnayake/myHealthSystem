import 'package:e_health/resources/api_methods.dart';
import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class HospitalDropdown extends StatefulWidget {
  const HospitalDropdown({super.key});

  @override
  State<HospitalDropdown> createState() => _HospitalDropdownState();
}

class _HospitalDropdownState extends State<HospitalDropdown> {
  String dropdownvalue = '';
  List? hospitals;
  bool isLoading = false;

  hospitalDropdown() async {
    List data = await APImethods().hospitalDropdown();

    setState(() {
      hospitals = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    hospitalDropdown();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Hospital :',
          style: TextStyles.textHeader2.copyWith(color: CustomColors.black),
        ),
        const SizedBox(width: 20),
        !isLoading
            ? hospitals != null
                ? Expanded(
                    child: DropdownButton(
                      isExpanded: true,
                      value: dropdownvalue.isNotEmpty ? dropdownvalue : null,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: hospitals?.map((hospital) {
                        return DropdownMenuItem(
                          value: hospital['hospitalId'].toString(),
                          child: Text(
                            hospital['name'].toString(),
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
                    ),
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
