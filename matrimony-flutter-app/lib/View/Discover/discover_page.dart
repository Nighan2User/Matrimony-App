import 'package:bright_weddings/View/Profile/ProfileDetails/profile_details.dart';
import 'package:bright_weddings/View/Discover/user_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bright_weddings/View/Dashboard/chat.dart';
import 'package:bright_weddings/View/Dashboard/dashboard_mob.dart';
import 'package:bright_weddings/Component/Navigation/bottom_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bright_weddings/View/Matches/matches_page.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> with SingleTickerProviderStateMixin {
  
  final List<Map<String, dynamic>> profiles = [
    {
      "name": "Nandana",
      "age": 26,
      "location": "Bangalore",
      "occupation": "Software Engineer",
      "bio": "I go crazy for beach vacations 🌊. I love long walks near the shore, sunsets, and peaceful moments by the sea.",
      "image": "assets/images/profile1.png",
      "interests": ["Travel", "Cooking", "Music", "Reading"],
      "compatibility": 92,
      "category": "Technology",
    },
    {
      "name": "Arjun",
      "age": 28,
      "location": "Mumbai",
      "occupation": "Photographer",
      "bio": "Adventure is my second name. Trekking, hiking, and exploring unexplored places give me a high 🏞️.",
      "image": "assets/images/profile2.png",
      "interests": ["Photography", "Hiking", "Fitness", "Travel"],
      "compatibility": 88,
      "category": "Creative",
    },
    {
      "name": "Priya",
      "age": 25,
      "location": "Delhi",
      "occupation": "Content Writer",
      "bio": "Bookworm 📚 and coffee lover ☕. You'll often find me curled up with a novel or writing in my journal.",
      "image": "assets/images/profile3.png",
      "interests": ["Reading", "Cooking", "Movies", "Travel"],
      "compatibility": 85,
      "category": "Creative",
    },
    {
      "name": "Rahul",
      "age": 30,
      "location": "Chennai",
      "occupation": "Product Manager",
      "bio": "Tech geek 💻 and travel addict ✈️. By profession, I'm into software development, but outside work I love exploring.",
      "image": "assets/images/profile4.png",
      "interests": ["Technology", "Travel", "Volunteering", "Gaming"],
      "compatibility": 78,
      "category": "Technology",
    },
    {
      "name": "Sneha",
      "age": 24,
      "location": "Hyderabad",
      "occupation": "Artist",
      "bio": "Creative soul 🎨 with a passion for painting, photography, and dance. I enjoy expressing myself through art.",
      "image": "assets/images/profile5.png",
      "interests": ["Art", "Photography", "Dance", "Travel"],
      "compatibility": 95,
      "category": "Creative",
    },
  ];

  int currentIndex = 0;
  String selectedFilter = "All";
  String searchQuery = "";
  final TextEditingController searchController = TextEditingController();
  
  // Configuration constants for filtering
  static const List<String> _nearbyCities = ["Bangalore", "Chennai", "Hyderabad"];
  static const int _newProfileMaxAge = 25;

  List<Map<String, dynamic>> get filteredProfiles {
    return profiles.where((profile) {
      final matchesFilter = selectedFilter == "All" || 
          profile["category"] == selectedFilter ||
          (selectedFilter == "Nearby" && _nearbyCities.contains(profile["location"])) ||
          (selectedFilter == "New" && (profile["age"] as int? ?? 0) <= _newProfileMaxAge);
      
      final matchesSearch = searchQuery.isEmpty ||
          (profile["name"]?.toString().toLowerCase() ?? "").contains(searchQuery.toLowerCase()) ||
          (profile["location"]?.toString().toLowerCase() ?? "").contains(searchQuery.toLowerCase()) ||
          (profile["occupation"]?.toString().toLowerCase() ?? "").contains(searchQuery.toLowerCase());
      
      return matchesFilter && matchesSearch;
    }).toList();
  }

  void _nextProfile({required bool liked}) {
    final currentProfiles = filteredProfiles;
    if (currentProfiles.isEmpty) return;
    
    final profile = currentProfiles[currentIndex % currentProfiles.length];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              liked ? Icons.favorite : Icons.close,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Text(
              liked ? "You liked ${profile['name']}" : "Skipped ${profile['name']}",
              style: GoogleFonts.lato(fontSize: 16),
            ),
          ],
        ),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: liked ? const Color(0xFF4CAF50) : const Color(0xFFE91E63),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );

    setState(() {
      if (currentIndex < currentProfiles.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
    });
  }

  void _openUserProfile(Map<String, dynamic> profile) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfileView(profile: profile),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Default empty profile as fallback
  static const Map<String, dynamic> _emptyProfile = {
    "name": "No profile",
    "age": 0,
    "location": "",
    "occupation": "",
    "bio": "",
    "image": "",
    "interests": <String>[],
    "compatibility": 0,
    "category": "",
  };

  @override
  Widget build(BuildContext context) {
    final currentProfiles = filteredProfiles;
    final profile = currentProfiles.isNotEmpty 
        ? currentProfiles[currentIndex % currentProfiles.length] 
        : (profiles.isNotEmpty ? profiles[0] : _emptyProfile);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Custom App Bar
            SliverAppBar(
              floating: true,
              backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE91E63),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.explore, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Discover",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[800] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.tune, color: isDark ? Colors.white70 : Colors.black54),
                  ),
                  onPressed: () => _showFilterBottomSheet(),
                ),
                const SizedBox(width: 8),
              ],
            ),

            // Search Bar
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                      currentIndex = 0;
                    });
                  },
                  style: GoogleFonts.lato(
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  decoration: InputDecoration(
                    hintText: "Search by name, location, occupation...",
                    hintStyle: GoogleFonts.lato(
                      color: isDark ? Colors.grey[500] : Colors.grey[400],
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: isDark ? Colors.grey[400] : Colors.grey[500],
                    ),
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: isDark ? Colors.grey[400] : Colors.grey[500],
                            ),
                            onPressed: () {
                              setState(() {
                                searchController.clear();
                                searchQuery = "";
                                currentIndex = 0;
                              });
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
            ),

            // Category Filter Chips
            SliverToBoxAdapter(
              child: Container(
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildFilterChip("All", selectedFilter == "All", isDark),
                    _buildFilterChip("Technology", selectedFilter == "Technology", isDark),
                    _buildFilterChip("Creative", selectedFilter == "Creative", isDark),
                    _buildFilterChip("Nearby", selectedFilter == "Nearby", isDark),
                    _buildFilterChip("New", selectedFilter == "New", isDark),
                  ],
                ),
              ),
            ),

            // Main Profile Card (only show when profiles exist)
            if (currentProfiles.isNotEmpty)
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () => _openUserProfile(profile),
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity != null) {
                      if (details.primaryVelocity! < 0) {
                        // Swiped left - dislike
                        _nextProfile(liked: false);
                      } else if (details.primaryVelocity! > 0) {
                        // Swiped right - like
                        _nextProfile(liked: true);
                      }
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Stack(
                      children: [
                        // Profile Image
                        Image.asset(
                          profile["image"],
                          height: 420,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 420,
                              color: isDark ? Colors.grey[800] : Colors.grey[300],
                              child: const Icon(Icons.person, size: 100, color: Colors.grey),
                            );
                          },
                        ),
                        // Gradient Overlay
                        Container(
                          height: 420,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black.withOpacity(0.8),
                              ],
                              stops: const [0.0, 0.5, 1.0],
                            ),
                          ),
                        ),
                        // Compatibility Badge
                        Positioned(
                          top: 16,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.favorite, color: Colors.white, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  "${profile['compatibility']}%",
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Tap to view profile hint
                        Positioned(
                          top: 16,
                          left: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.touch_app, color: Colors.white, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  "Tap to view",
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Profile Info Overlay
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${profile['name']}, ${profile['age']}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, color: Colors.white70, size: 14),
                                    const SizedBox(width: 4),
                                    Text(
                                      "${profile['location']} • ${profile['occupation']}",
                                      style: GoogleFonts.lato(color: Colors.white70, fontSize: 13),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  profile['bio'],
                                  style: GoogleFonts.lato(color: Colors.white, fontSize: 13, height: 1.3),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Action Buttons (Only Like and Dislike buttons)
            if (currentProfiles.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        icon: Icons.close,
                        color: Colors.grey,
                        size: 65,
                        onTap: () => _nextProfile(liked: false),
                        isDark: isDark,
                      ),
                      _buildActionButton(
                        icon: Icons.favorite,
                        color: const Color(0xFFE91E63),
                        size: 70,
                        onTap: () => _nextProfile(liked: true),
                        isDark: isDark,
                      ),
                    ],
                  ),
                ),
              ),

            // Profile Counter (only show when profiles exist)
            if (currentProfiles.isNotEmpty)
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(currentProfiles.length, (index) {
                        final actualIndex = currentIndex % currentProfiles.length;
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: index == actualIndex ? 20 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: index == actualIndex ? const Color(0xFFE91E63) : (isDark ? Colors.grey[700] : Colors.grey[300]),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),

            // No profiles found message
            if (currentProfiles.isEmpty)
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 80,
                        color: isDark ? Colors.grey[600] : Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "No profiles found",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Try adjusting your search or filters",
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 4),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, bool isDark) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
          currentIndex = 0;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE91E63) : (isDark ? const Color(0xFF1E1E1E) : Colors.white),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : (isDark ? Colors.grey[700]! : Colors.grey[300]!),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.lato(
            color: isSelected ? Colors.white : (isDark ? Colors.white : Colors.black54),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required double size,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Icon(icon, color: color, size: size * 0.45),
      ),
    );
  }

  void _showFilterBottomSheet() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[600] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Filters",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Reset", style: GoogleFonts.lato(color: const Color(0xFFE91E63))),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildFilterSection("Age Range", "22 - 32 years", isDark),
                    _buildFilterSection("Distance", "Within 50 km", isDark),
                    _buildFilterSection("Education", "Graduate & above", isDark),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE91E63),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Text("Apply Filters", style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterSection(String title, String value, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.grey[50],
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.lato(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: GoogleFonts.lato(color: isDark ? Colors.grey[400] : Colors.grey[600]),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right, color: isDark ? Colors.grey[400] : Colors.grey),
            ],
          ),
        ],
      ),
    );
  }
}
