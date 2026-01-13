import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFFF57C00), // Orange Theme
      ),
      body: ListView(
        children: [
          _buildNotificationTile(
            context,
            title: "New Match Found!",
            subtitle: "Someone liked your profile.",
            icon: Icons.favorite,
            time: "2h ago",
          ),
          _buildNotificationTile(
            context,
            title: "Profile Viewed",
            subtitle: "Your profile was viewed 3 times today.",
            icon: Icons.visibility,
            time: "4h ago",
          ),
          _buildNotificationTile(
            context,
            title: "Match Reminder",
            subtitle: "Don't miss this match! View their profile now.",
            icon: Icons.notifications,
            time: "1d ago",
          ),
          _buildNotificationTile(
            context,
            title: "Profile Approved",
            subtitle: "Your profile has been approved!",
            icon: Icons.check_circle,
            time: "2d ago",
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationTile(BuildContext context,
      {required String title,
      required String subtitle,
      required IconData icon,
      required String time}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xFFFFA726), // Lighter Orange
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFF57C00)),
        ),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.black54)),
        trailing: Text(
          time,
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Tapped on: $title'),
              backgroundColor: Color(0xFFF57C00),
            ),
          );
        },
      ),
    );
  }
}
