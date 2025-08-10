import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loop_lab/Widgets/app_colors.dart';

class EditProfileScreen extends StatefulWidget {
  final String userId;

  const EditProfileScreen({super.key, required this.userId});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedRole = 'Student';

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users') // Change if your collection is named differently
          .doc(widget.userId)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>;
        _nameController.text = data['name'] ?? '';
        _emailController.text = data['email'] ?? '';
        _phoneController.text = data['phoneNumber'] ?? '';
        _selectedRole = data['role'] ?? 'Student';
      }
    } catch (e) {
      print("Error fetching user: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading profile: $e")),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveProfileChanges() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .update({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'phoneNumber': _phoneController.text.trim(),
        'role': _selectedRole,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    } catch (e) {
      print("Error updating profile: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating profile: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final secondaryTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final cardColor =
        isDark ? AppColors.darkCardBackground : Colors.white;
    final borderColor =
        isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final inputFillColor =
        isDark ? AppColors.darkBackground : Colors.grey[50]!;

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkCardBackground : Colors.white,
        elevation: 0,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.primaryBlue,
                    child: Text(
                      _nameController.text.isNotEmpty
                          ? _nameController.text[0]
                          : '?',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        shape: BoxShape.circle,
                        border: Border.all(color: cardColor, width: 3),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          // Handle image selection
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildTextField(
              controller: _nameController,
              label: 'Full Name',
              hint: 'Enter your full name',
              icon: Icons.person_outline,
              isDark: isDark,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
              borderColor: borderColor,
              inputFillColor: inputFillColor,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _emailController,
              label: 'Email Address',
              hint: 'Enter your email address',
              icon: Icons.email_outlined,
              isDark: isDark,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
              borderColor: borderColor,
              inputFillColor: inputFillColor,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _phoneController,
              label: 'Phone Number',
              hint: 'Enter your phone number',
              icon: Icons.phone_outlined,
              isDark: isDark,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
              borderColor: borderColor,
              inputFillColor: inputFillColor,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            Text(
              'Role',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor),
                color: inputFillColor,
              ),
              child: DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                dropdownColor: cardColor,
                style: TextStyle(color: textColor),
                items: ['student', 'teacher', 'admin'].map((role) {
                  return DropdownMenuItem(value: role, child: Text(role));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _saveProfileChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required bool isDark,
    required Color textColor,
    required Color secondaryTextColor,
    required Color borderColor,
    required Color inputFillColor,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: secondaryTextColor),
            prefixIcon: Icon(icon, color: secondaryTextColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primaryBlue),
            ),
            filled: true,
            fillColor: inputFillColor,
          ),
        ),
      ],
    );
  }
}
