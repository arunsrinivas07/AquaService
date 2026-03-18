import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/services/firestore_service.dart';
import '../models/customer_model.dart';
import '../providers/customer_provider.dart';
import 'map_picker_screen.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final CustomerModel customer;

  const EditProfileScreen({super.key, required this.customer});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late TextEditingController _nameController;
  late List<TextEditingController> _addressControllers;
  late TextEditingController _latLongController;
  late TextEditingController _passwordController;

  String? _profilePicPath;
  bool _isLoading = false;
  bool _isFetchingAuth = true;

  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.customer.name);
    _addressControllers = widget.customer.addresses.isEmpty
        ? [TextEditingController()]
        : widget.customer.addresses
            .map((addr) => TextEditingController(text: addr))
            .toList();
    _latLongController = TextEditingController(text: widget.customer.location);
    _passwordController = TextEditingController();

    _loadProfilePic();
    _fetchPassword();
  }

  Future<void> _loadProfilePic() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _profilePicPath = prefs.getString('profile_pic_${widget.customer.phoneNumber}');
    });
  }

  Future<void> _fetchPassword() async {
    try {
      final authData = await _firestoreService.getLoginAuth(widget.customer.phoneNumber);
      if (authData != null && authData.containsKey('Password')) {
        _passwordController.text = authData['Password'].toString();
      }
    } catch (e) {
      debugPrint('Error fetching password: $e');
    } finally {
      setState(() {
        _isFetchingAuth = false;
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_pic_${widget.customer.phoneNumber}', pickedFile.path);

      setState(() {
        _profilePicPath = pickedFile.path;
      });
    }
  }

  void _addAddressField() {
    setState(() {
      _addressControllers.add(TextEditingController());
    });
  }

  void _removeAddressField(int index) {
    setState(() {
      final controller = _addressControllers.removeAt(index);
      controller.dispose();
    });
  }

  Future<void> _saveChanges() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Update Customer Details
      final updatedData = {
        'Name': _nameController.text.trim(),
        'Address': _addressControllers
            .map((c) => c.text.trim())
            .where((text) => text.isNotEmpty)
            .toList(),
        'Location': _latLongController.text.trim(),
      };
      await _firestoreService.updateCustomerProfile(widget.customer.docId, updatedData);

      // Update Password if not empty
      if (_passwordController.text.isNotEmpty) {
        await _firestoreService.updateCustomerPassword(
            widget.customer.phoneNumber, _passwordController.text);
      }

      // Invalidate the provider so it fetches the new data
      ref.invalidate(customerProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    for (final controller in _addressControllers) {
      controller.dispose();
    }
    _latLongController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'EDIT PROFILE',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: _isFetchingAuth
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 2),
                            color: Colors.grey.shade300,
                          ),
                          child: ClipOval(
                            child: _profilePicPath != null && File(_profilePicPath!).existsSync()
                                ? Image.file(
                                    File(_profilePicPath!),
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/avatar.jpeg',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.person, size: 50, color: Colors.white),
                                  ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF4DD9E0),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildTextField('Phone Number', TextEditingController(text: widget.customer.phoneNumber), readOnly: true),
                  const SizedBox(height: 16),
                  _buildTextField('Name', _nameController),
                  const SizedBox(height: 16),
                  _buildTextField('Password', _passwordController, obscureText: true),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Addresses',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87),
                      ),
                      TextButton.icon(
                        onPressed: _addAddressField,
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('Add'),
                        style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF4DD9E0)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(_addressControllers.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildTextField(
                        'Address ${index + 1}',
                        _addressControllers[index],
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline,
                              color: Colors.redAccent),
                          onPressed: () => _removeAddressField(index),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  _buildTextField(
                    'Lat/Long Location',
                    _latLongController,
                    trailing: IconButton(
                      icon: const Icon(Icons.map, color: Color(0xFF4DD9E0)),
                      onPressed: () async {
                        // Parse existing lat,long
                        LatLng? initialLoc;
                        if (_latLongController.text.isNotEmpty) {
                          try {
                            final parts = _latLongController.text.split(',');
                            if (parts.length == 2) {
                              initialLoc = LatLng(
                                  double.parse(parts[0].trim()), double.parse(parts[1].trim()));
                            }
                          } catch (_) {}
                        }

                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapPickerScreen(initialLocation: initialLoc),
                          ),
                        );

                        if (result != null && result is LatLng) {
                          setState(() {
                            _latLongController.text =
                                '${result.latitude.toStringAsFixed(6)}, ${result.longitude.toStringAsFixed(6)}';
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _saveChanges,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4DD9E0),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Save Changes',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool readOnly = false, bool obscureText = false, Widget? trailing}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: readOnly,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: readOnly ? Colors.grey.shade200 : Colors.white,
            suffixIcon: trailing,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}
