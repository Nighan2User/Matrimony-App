import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Controller/firestore_data_controller.dart';
import '../../../Controller/firebase_auth_controller.dart';

class FirebaseDataDisplay extends StatelessWidget {
  final FirestoreDataController firestoreController = Get.find<FirestoreDataController>();
  final FirebaseAuthController authController = Get.find<FirebaseAuthController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(Icons.cloud_outlined, color: Colors.orange, size: 24),
              SizedBox(width: 8),
              Text(
                'Firebase Database',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              Spacer(),
              Obx(() => Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: firestoreController.users.length > 0 
                      ? Colors.green[100] 
                      : Colors.orange[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  firestoreController.users.length > 0 ? 'Connected' : 'Loading...',
                  style: TextStyle(
                    color: firestoreController.users.length > 0 
                        ? Colors.green[800] 
                        : Colors.orange[800],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
            ],
          ),
          
          SizedBox(height: 16),
          
          // Loading state
          Obx(() {
            if (firestoreController.isLoading.value) {
              return Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(color: Colors.orange),
                    SizedBox(height: 8),
                    Text('Loading matrimony data...', style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              );
            }
            
            // Error state
            if (firestoreController.errorMessage.value.isNotEmpty) {
              return Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange[200]!),
                ),
                child: Column(
                  children: [
                    Icon(Icons.warning_amber_outlined, color: Colors.orange, size: 32),
                    SizedBox(height: 8),
                    Text(
                      'Firestore API Setup Needed',
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '🔧 To access your matrimony data:',
                      style: TextStyle(color: Colors.orange[600], fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '1. Go to Firebase Console\n2. Select "bright-weddings-605e7"\n3. Enable Firestore Database\n4. Set read/write rules if needed',
                      style: TextStyle(color: Colors.orange[600], fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        // This would open the Firebase console in a new tab
                        print('Open Firebase Console');
                      },
                      icon: Icon(Icons.open_in_new, size: 16),
                      label: Text('Open Firebase Console', style: TextStyle(fontSize: 12)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Error: ${firestoreController.errorMessage.value}',
                      style: TextStyle(color: Colors.orange[500], fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
            
            // Success state with data
            if (firestoreController.users.length > 0) {
              final stats = firestoreController.getUserStats();
              
              return Column(
                children: [
                  // Statistics
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Total Profiles',
                          stats['total'].toString(),
                          Icons.people,
                          Colors.blue,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _buildStatCard(
                          'Male',
                          stats['male'].toString(),
                          Icons.male,
                          Colors.indigo,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _buildStatCard(
                          'Female',
                          stats['female'].toString(),
                          Icons.female,
                          Colors.pink,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 16),
                  
                  // Current user info
                  if (authController.isLoggedIn.value) ...[
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green[200]!),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Logged in as',
                                  style: TextStyle(
                                    color: Colors.green[600],
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  authController.userEmail.value.isNotEmpty 
                                      ? authController.userEmail.value 
                                      : 'Firebase User',
                                  style: TextStyle(
                                    color: Colors.green[800],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'UID: ${authController.userId.value.length > 8 ? authController.userId.value.substring(0, 8) : authController.userId.value}...',
                                  style: TextStyle(
                                    color: Colors.green[600],
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  
                  SizedBox(height: 16),
                  
                  // Recent profiles preview
                  Text(
                    'Recent Profiles from Firebase',
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  
                  Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: firestoreController.users.length > 5 
                          ? 5 
                          : firestoreController.users.length,
                      itemBuilder: (context, index) {
                        final user = firestoreController.users[index];
                        return _buildProfileCard(user);
                      },
                    ),
                  ),
                ],
              );
            }
            
            // Empty state
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(Icons.inbox_outlined, color: Colors.grey[400], size: 48),
                  SizedBox(height: 8),
                  Text(
                    'No matrimony data found',
                    style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Make sure you have users in your Firebase Firestore',
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
  
  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  Widget _buildProfileCard(Map<String, dynamic> user) {
    return Container(
      width: 80,
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: user['gender'] == 'Male' ? Colors.blue[300] : Colors.pink[300],
            child: Icon(
              user['gender'] == 'Male' ? Icons.male : Icons.female,
              color: Colors.white,
              size: 16,
            ),
          ),
          SizedBox(height: 4),
          Text(
            user['name'] ?? 'Unknown',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          Text(
            user['age']?.toString() ?? '',
            style: TextStyle(
              fontSize: 8,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
