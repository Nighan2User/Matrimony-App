import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FirestoreDataController extends GetxController {
  // Firebase project details
  final String projectId = "bright-weddings-605e7";
  final String apiKey = "AIzaSyCfcn_q14Wc-AnYPshuJWHtAEzP_Jxf3Bo";
  
  // Observable variables for UI
  RxList<Map<String, dynamic>> users = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> profiles = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  
  // Get Firestore REST URL
  String getFirestoreUrl(String collection, [String? documentId]) {
    if (documentId != null) {
      return 'https://firestore.googleapis.com/v1/projects/$projectId/databases/(default)/documents/$collection/$documentId';
    }
    return 'https://firestore.googleapis.com/v1/projects/$projectId/databases/(default)/documents/$collection';
  }
  
  // Convert Firestore document to Map
  Map<String, dynamic> convertFirestoreDocument(Map<String, dynamic> doc) {
    final Map<String, dynamic> result = {'id': doc['name'].split('/').last};
    
    if (doc['fields'] != null) {
      doc['fields'].forEach((key, value) {
        if (value['stringValue'] != null) {
          result[key] = value['stringValue'];
        } else if (value['integerValue'] != null) {
          result[key] = int.parse(value['integerValue']);
        } else if (value['booleanValue'] != null) {
          result[key] = value['booleanValue'];
        } else if (value['doubleValue'] != null) {
          result[key] = double.parse(value['doubleValue']);
        } else if (value['timestampValue'] != null) {
          result[key] = DateTime.parse(value['timestampValue']);
        } else if (value['arrayValue'] != null) {
          result[key] = value['arrayValue']['values'] ?? [];
        } else if (value['mapValue'] != null) {
          result[key] = value['mapValue']['fields'] ?? {};
        } else {
          result[key] = value.toString();
        }
      });
    }
    
    return result;
  }
  
  // Get all users from Firestore
  Future<void> fetchUsers([String? authToken]) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      // Try the simple approach first - no auth token needed for public reads
      final url = getFirestoreUrl('users');
      final headers = <String, String>{
        'Content-Type': 'application/json',
      };
      
      print("Fetching users from: $url");
      
      final response = await http.get(Uri.parse(url), headers: headers);
      
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['documents'] != null) {
          users.clear();
          for (var doc in data['documents']) {
            final userData = convertFirestoreDocument(doc);
            users.add(userData);
          }
          print("Fetched ${users.length} users successfully");
        } else {
          print("No documents found in users collection");
          users.clear();
        }
      } else if (response.statusCode == 403) {
        // API not enabled - provide helpful error message
        final errorData = json.decode(response.body);
        if (errorData['error'] != null && errorData['error']['message'] != null) {
          final errorMsg = errorData['error']['message'].toString();
          if (errorMsg.contains('Cloud Firestore API has not been used') || 
              errorMsg.contains('disabled')) {
            errorMessage.value = 'Firestore API not enabled. Enable it in Firebase Console to see your real data.';
            
            // Add some sample data to show the interface works
            users.clear();
            users.addAll([
              {
                'id': 'sample1',
                'name': 'Sample Profile 1',
                'email': 'sample1@example.com',
                'gender': 'Male',
                'age': 28,
                'location': 'Mumbai',
                'profession': 'Engineer'
              },
              {
                'id': 'sample2',
                'name': 'Sample Profile 2',
                'email': 'sample2@example.com',
                'gender': 'Female',
                'age': 25,
                'location': 'Delhi',
                'profession': 'Doctor'
              },
              {
                'id': 'sample3',
                'name': 'Sample Profile 3',
                'email': 'sample3@example.com',
                'gender': 'Male',
                'age': 30,
                'location': 'Bangalore',
                'profession': 'Designer'
              }
            ]);
            print("Added ${users.length} sample profiles");
          } else {
            errorMessage.value = 'Firestore access error: $errorMsg';
          }
        } else {
          errorMessage.value = 'Firestore API access denied';
        }
        print("Firestore API error: ${response.body}");
      } else {
        final errorData = json.decode(response.body);
        if (errorData['error'] != null && errorData['error']['message'] != null) {
          errorMessage.value = 'Failed to fetch users: ${errorData['error']['message']}';
        } else {
          errorMessage.value = 'Failed to fetch users: HTTP ${response.statusCode}';
        }
        print("Error fetching users: ${response.body}");
      }
    } catch (e) {
      errorMessage.value = 'Network error: $e';
      print("Exception fetching users: $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  // Get specific user by ID
  Future<Map<String, dynamic>?> fetchUserById(String userId, [String? authToken]) async {
    try {
      final url = getFirestoreUrl('users', userId);
      final headers = <String, String>{
        'Content-Type': 'application/json',
      };
      
      if (authToken != null) {
        headers['Authorization'] = 'Bearer $authToken';
      }
      
      final response = await http.get(Uri.parse(url), headers: headers);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return convertFirestoreDocument(data);
      } else {
        print("Error fetching user $userId: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception fetching user $userId: $e");
      return null;
    }
  }
  
  // Create new user in Firestore
  Future<bool> createUser(Map<String, dynamic> userData, [String? authToken]) async {
    try {
      final url = getFirestoreUrl('users');
      final headers = <String, String>{
        'Content-Type': 'application/json',
      };
      
      if (authToken != null) {
        headers['Authorization'] = 'Bearer $authToken';
      }
      
      // Convert to Firestore format
      final firestoreData = <String, dynamic>{};
      userData.forEach((key, value) {
        if (value is String) {
          firestoreData[key] = {'stringValue': value};
        } else if (value is int) {
          firestoreData[key] = {'integerValue': value.toString()};
        } else if (value is bool) {
          firestoreData[key] = {'booleanValue': value};
        } else if (value is double) {
          firestoreData[key] = {'doubleValue': value};
        } else {
          firestoreData[key] = {'stringValue': value.toString()};
        }
      });
      
      final requestBody = json.encode({
        'fields': firestoreData
      });
      
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: requestBody,
      );
      
      if (response.statusCode == 200) {
        print("User created successfully");
        await fetchUsers(authToken); // Refresh the list
        return true;
      } else {
        print("Error creating user: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Exception creating user: $e");
      return false;
    }
  }
  
  // Search users by criteria
  List<Map<String, dynamic>> searchUsers({
    String? gender,
    String? ageRange,
    String? location,
    String? profession,
  }) {
    return users.where((user) {
      bool matches = true;
      
      if (gender != null && user['gender'] != gender) {
        matches = false;
      }
      
      if (location != null && user['location'] != null) {
        if (!user['location'].toString().toLowerCase().contains(location.toLowerCase())) {
          matches = false;
        }
      }
      
      if (profession != null && user['profession'] != null) {
        if (!user['profession'].toString().toLowerCase().contains(profession.toLowerCase())) {
          matches = false;
        }
      }
      
      return matches;
    }).toList();
  }
  
  // Get user statistics
  Map<String, int> getUserStats() {
    final stats = <String, int>{
      'total': users.length,
      'male': 0,
      'female': 0,
    };
    
    for (var user in users) {
      if (user['gender'] == 'Male') {
        stats['male'] = (stats['male'] ?? 0) + 1;
      } else if (user['gender'] == 'Female') {
        stats['female'] = (stats['female'] ?? 0) + 1;
      }
    }
    
    return stats;
  }
}
