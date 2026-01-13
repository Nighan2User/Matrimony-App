import 'package:bright_weddings/Mock%20API/user_list.dart';
import 'package:flutter/material.dart';

class Temp extends StatelessWidget {
  const Temp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.all(10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
          itemCount: userList.length,
          itemBuilder: (context, index){
            final user = userList[index];
            return ListTile(
              title: Text(user['full_name']),
              subtitle: Text(user['address']),
            );
          }
      ),
      ),
    );
  }
}
