import 'package:flutter/material.dart';
import 'package:bright_weddings/Helper/colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: dashboardSelectedColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy for Bright Weddings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: dashboardSelectedColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Last updated: ${DateTime.now().toString().split(' ')[0]}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            
            _buildSection(
              'Information We Collect',
              '''We collect information you provide directly to us, such as:
• Profile information (name, age, location, photos)
• Contact information (email address, phone number)
• Preferences and interests
• Messages and communications with other users
• Usage data and analytics''',
            ),
            
            _buildSection(
              'How We Use Your Information',
              '''We use the information we collect to:
• Provide and maintain our matchmaking service
• Create and manage your profile
• Connect you with potential matches
• Send you notifications and updates
• Improve our services and user experience
• Ensure safety and security of our platform''',
            ),
            
            _buildSection(
              'Information Sharing',
              '''We do not sell, trade, or rent your personal information to third parties. We may share your information:
• With other users as part of the matchmaking service
• With service providers who assist in operating our platform
• When required by law or to protect our rights
• In connection with a business transfer or acquisition''',
            ),
            
            _buildSection(
              'Data Security',
              '''We implement appropriate security measures to protect your personal information:
• Encryption of sensitive data
• Secure authentication systems
• Regular security audits and updates
• Limited access to personal information''',
            ),
            
            _buildSection(
              'Your Rights',
              '''You have the right to:
• Access and update your personal information
• Delete your account and associated data
• Control your privacy settings
• Opt-out of certain communications
• Request a copy of your data''',
            ),
            
            _buildSection(
              'Cookies and Tracking',
              '''We use cookies and similar technologies to:
• Remember your preferences
• Analyze usage patterns
• Improve our services
• Provide personalized content''',
            ),
            
            _buildSection(
              'Contact Us',
              '''If you have questions about this Privacy Policy, please contact us at:
Email: privacy@brightweddings.com
Address: [Your Business Address]
Phone: [Your Contact Number]''',
            ),
            
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Changes to This Policy',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last updated" date.',
                    style: TextStyle(color: Colors.blue[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}