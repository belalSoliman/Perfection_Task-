import 'package:flutter/material.dart';
import 'package:perfection_company/core/services/fetch_user_details_service.dart';
import 'package:perfection_company/home/model/user_model.dart';

class UserDetailsScreen extends StatefulWidget {
  final int userId;

  const UserDetailsScreen({super.key, required this.userId});

  @override
  UserDetailsScreenState createState() => UserDetailsScreenState();
}

class UserDetailsScreenState extends State<UserDetailsScreen> {
  final UserService _userService = UserService();
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    try {
      User user = await _userService.fetchUserDetails(widget.userId);
      if (mounted) {
        setState(() {
          _user = user;
          _isLoading = false;
        });
      }
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_user?.name ?? 'User Details'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _user != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(_user!.avatar),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _user!.name,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _user!.email,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
              : const Center(child: Text('Failed to load user details')),
    );
  }
}
