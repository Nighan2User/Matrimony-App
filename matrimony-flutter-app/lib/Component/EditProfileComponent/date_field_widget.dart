import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const DateFieldWidget({
    Key? key,
    required this.controller,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: 'Select date',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        controller.text = DateFormat('yyyy-MM-dd').format(pickedDate!);
      },
    );
  }
}
