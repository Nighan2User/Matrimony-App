import 'package:flutter/material.dart';
import 'package:bright_weddings/Helper/colors.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Terms of Service'),
        backgroundColor: dashboardSelectedColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms of Service for Bright Weddings',
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
              'Acceptance of Terms',
              '''By accessing and using Bright Weddings, you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to abide by the above, please do not use this service.''',
            ),
            
            _buildSection(
              'Service Description',
              '''Bright Weddings is a matrimonial platform that helps individuals find potential life partners. Our service includes:
• Profile creation and management
• Matching algorithms and recommendations
• Communication tools between users
• Privacy and safety features''',
            ),
            
            _buildSection(
              'User Responsibilities',
              '''As a user of our service, you agree to:
• Provide accurate and truthful information
• Respect other users and their privacy
• Not engage in harassment, abuse, or inappropriate behavior
• Not create fake or misleading profiles
• Comply with all applicable laws and regulations
• Report any suspicious or inappropriate activity''',
            ),
            
            _buildSection(
              'Prohibited Activities',
              '''The following activities are strictly prohibited:
• Creating multiple accounts or fake profiles
• Sharing inappropriate or offensive content
• Soliciting money or engaging in commercial activities
• Harassment, stalking, or threatening behavior
• Sharing personal contact information publicly
• Using the service for any illegal purposes''',
            ),
            
            _buildSection(
              'Privacy and Data Protection',
              '''We are committed to protecting your privacy:
• Your personal information is kept confidential
• We use industry-standard security measures
• You control your profile visibility and privacy settings
• We do not share your information with unauthorized parties''',
            ),
            
            _buildSection(
              'Account Termination',
              '''We reserve the right to terminate accounts that:
• Violate these terms of service
• Engage in prohibited activities
• Pose a risk to other users or our platform
• Remain inactive for extended periods''',
            ),
            
            _buildSection(
              'Limitation of Liability',
              '''Bright Weddings is not responsible for:
• The accuracy of user-provided information
• Outcomes of meetings or relationships
• Actions of other users outside our platform
• Technical issues or service interruptions''',
            ),
            
            _buildSection(
              'Contact Information',
              '''For questions about these Terms of Service, contact us at:
Email: support@brightweddings.com
Address: [Your Business Address]
Phone: [Your Contact Number]''',
            ),
            
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Changes to Terms',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We reserve the right to modify these terms at any time. Users will be notified of significant changes, and continued use of the service constitutes acceptance of the modified terms.',
                    style: TextStyle(color: Colors.orange[600]),
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