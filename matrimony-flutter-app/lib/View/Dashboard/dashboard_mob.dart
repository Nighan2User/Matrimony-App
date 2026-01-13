import 'package:bright_weddings/Component/AppBar/header/head.dart';
import 'package:bright_weddings/View/Dashboard/chat.dart';
import 'package:bright_weddings/View/Profile/ProfileDetails/profile_details.dart';
import 'package:bright_weddings/View/Discover/discover_page.dart';
import 'package:bright_weddings/View/Matches/matches_page.dart';
import 'package:bright_weddings/Component/Navigation/bottom_nav_bar.dart';
import 'package:bright_weddings/Helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardMob extends StatefulWidget {
  DashboardMob({super.key});

  @override
  _DashboardMobState createState() => _DashboardMobState();
}

class _DashboardMobState extends State<DashboardMob> {
  final List<Map<String, dynamic>> newProfiles = [
    {
      "name": "Nandana",
      "age": 26,
      "location": "Bangalore",
      "image": "assets/images/profile1.jpg",
      "isVerified": true,
      "isOnline": true,
    },
    {
      "name": "Arjun",
      "age": 28,
      "location": "Mumbai",
      "image": "assets/images/profile2.jpg",
      "isVerified": true,
      "isOnline": false,
    },
    {
      "name": "Priya",
      "age": 25,
      "location": "Delhi",
      "image": "assets/images/profile3.jpg",
      "isVerified": false,
      "isOnline": true,
    },
    {
      "name": "Rahul",
      "age": 30,
      "location": "Chennai",
      "image": "assets/images/profile4.jpg",
      "isVerified": true,
      "isOnline": false,
    },
  ];

  final List<Map<String, dynamic>> recommendations = [
    {
      "name": "Sneha",
      "age": 24,
      "location": "Hyderabad",
      "occupation": "Artist",
      "image": "assets/images/profile5.jpg",
      "matchPercentage": 95,
      "interests": ["Art", "Photography", "Dance"],
    },
    {
      "name": "Kavya",
      "age": 25,
      "location": "Pune",
      "occupation": "Doctor",
      "image": "assets/images/profile1.jpg",
      "matchPercentage": 90,
      "interests": ["Yoga", "Travel", "Music"],
    },
    {
      "name": "Meera",
      "age": 27,
      "location": "Bangalore",
      "occupation": "Designer",
      "image": "assets/images/profile3.jpg",
      "matchPercentage": 88,
      "interests": ["Design", "Reading", "Travel"],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0F172A) : backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Header(),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Custom App Bar

            // Welcome Banner
            SliverToBoxAdapter(
              child: _buildWelcomeBanner(isDark),
            ),

            // Search Bar
            SliverToBoxAdapter(
              child: _buildSearchBar(isDark),
            ),

            // Quick Actions
            SliverToBoxAdapter(
              child: _buildQuickActions(isDark),
            ),

            // New Profiles Section
            SliverToBoxAdapter(
              child: _buildSectionHeader("New Profiles",
                  onViewAll: () {}, isDark: isDark),
            ),

            SliverToBoxAdapter(
              child: _buildNewProfilesCarousel(isDark),
            ),

            // Recommendations Section
            SliverToBoxAdapter(
              child: _buildSectionHeader("Recommended for You",
                  onViewAll: () {}, isDark: isDark),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    _buildRecommendationCard(recommendations[index], isDark),
                childCount: recommendations.length,
              ),
            ),

            // Bottom Padding
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildWelcomeBanner(bool isDark) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [dashboardSelectedColor, const Color(0xFFB91C5A)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: dashboardSelectedColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Find Your",
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  "Perfect Match!",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Get.to(() => DiscoverPage()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: dashboardSelectedColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Start Discovering",
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.favorite,
              size: 40,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: isDark ? Colors.grey[400] : otherTextColor),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search for your partner...",
                hintStyle: GoogleFonts.lato(
                    color: isDark ? Colors.grey[400] : otherTextColor),
                border: InputBorder.none,
              ),
              style: TextStyle(color: isDark ? Colors.white : textColor),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: dashboardSelectedColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.tune, color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(bool isDark) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildQuickActionItem(
              Icons.explore,
              "Discover",
              dashboardSelectedColor,
              () => Get.offAll(() => DiscoverPage()),
              isDark),
          _buildQuickActionItem(
              Icons.favorite,
              "Matches",
              greenColor,
              () => Get.offAll(() => const MatchesPage()),
              isDark),
          _buildQuickActionItem(Icons.chat_bubble, "Messages", buttonColor,
              () => Get.offAll(() => const Chat()), isDark),
          _buildQuickActionItem(Icons.person, "Profile", darkYellowColor,
              () => Get.offAll(() => const ProfileDetails()), isDark),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem(IconData icon, String label, Color color,
      VoidCallback onTap, bool isDark) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.lato(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title,
      {required VoidCallback onViewAll, required bool isDark}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          TextButton(
            onPressed: onViewAll,
            child: Row(
              children: [
                Text(
                  "View All",
                  style: GoogleFonts.lato(
                    color: dashboardSelectedColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward_ios,
                    size: 12, color: dashboardSelectedColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewProfilesCarousel(bool isDark) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: newProfiles.length,
        itemBuilder: (context, index) {
          return _buildNewProfileCard(newProfiles[index], isDark);
        },
      ),
    );
  }

  Widget _buildNewProfileCard(Map<String, dynamic> profile, bool isDark) {
    return GestureDetector(
      onTap: () => Get.to(() => DiscoverPage()),
      child: Container(
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                profile["image"],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: isDark ? Colors.grey[800] : Colors.grey[300],
                    child:
                        const Icon(Icons.person, size: 50, color: Colors.grey),
                  );
                },
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              // Profile Info
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${profile['name']}, ${profile['age']}",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            color: Colors.white70, size: 12),
                        const SizedBox(width: 4),
                        Text(
                          profile['location'],
                          style: GoogleFonts.lato(
                            fontSize: 11,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(Map<String, dynamic> profile, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => Get.to(() => DiscoverPage()),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Profile Image
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    profile["image"],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: isDark ? Colors.grey[800] : Colors.grey[300],
                        child: const Icon(Icons.person,
                            size: 30, color: Colors.grey),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Profile Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${profile['name']}, ${profile['age']}",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "${profile['matchPercentage']}%",
                            style: GoogleFonts.lato(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 12,
                            color: isDark ? Colors.grey[400] : Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          "${profile['location']} • ${profile['occupation']}",
                          style: GoogleFonts.lato(
                            fontSize: 12,
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Action Button
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: dashboardSelectedColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.favorite_outline,
                    color: dashboardSelectedColor, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
