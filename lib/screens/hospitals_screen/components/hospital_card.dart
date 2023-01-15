import 'package:e_health/utils/styles.dart';
import 'package:flutter/cupertino.dart';

class HorizontalHospitalCard extends StatelessWidget {
  const HorizontalHospitalCard({super.key, required this.hospital});
  final Map<dynamic, dynamic> hospital;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '${hospital['name']}',
        style: TextStyles.regulerText,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
