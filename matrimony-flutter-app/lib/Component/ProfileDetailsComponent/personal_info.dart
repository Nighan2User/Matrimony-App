import 'package:bright_weddings/Helper/size_config.dart';
import 'package:flutter/material.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key,  required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      '> $label: $value',
      style: TextStyle(fontSize: 1.0.t,),
    );
  }
}
