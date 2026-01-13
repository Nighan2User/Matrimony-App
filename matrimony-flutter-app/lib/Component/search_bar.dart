import 'package:flutter/material.dart';
import 'package:bright_weddings/Helper/size_config.dart';

class Search_Bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(
            fontSize: 1.3.t,
            color: Colors.grey,
          ),
          border: InputBorder.none,
          suffixIcon: Icon(
            Icons.search,
            color: Colors.grey,
            size: 2.0.t,
          ),
        ),
        style: TextStyle(fontSize: 1.3.t),
      ),
    );
  }
}