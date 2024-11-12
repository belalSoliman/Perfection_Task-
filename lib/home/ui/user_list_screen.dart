import 'package:flutter/material.dart';
import 'package:perfection_company/core/services/fetch_user_details_service.dart';
import 'package:perfection_company/home/model/user_model.dart';
import 'package:perfection_company/home/widget/user_item.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'user_details_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  UserListScreenState createState() => UserListScreenState();
}

class UserListScreenState extends State<UserListScreen> {
  final UserService _userService = UserService();
  final List<User> _users = [];
  int _currentPage = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    if (_isLoading) return; // Prevent multiple fetch calls
    setState(() {
      _isLoading = true;
    });
    try {
      List<User> users = await _userService.fetchUsers(_currentPage);
      if (mounted) {
        setState(() {
          _users.addAll(users);
          _currentPage++;
        });
      }
    } catch (e) {
      // Handle error
      print("Error fetching users: $e");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _isLoading && _users.isEmpty ? 6 : _users.length + 1,
        itemBuilder: (context, index) {
          if (_isLoading && _users.isEmpty) {
            return Skeletonizer(
              child: UserCard(
                user: User(
                  id: 0,
                  name: 'Loading...',
                  email: 'loading@example.com',
                  avatar: '', // Empty or placeholder avatar
                ),
              ),
            );
          }

          if (index == _users.length) {
            return _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _fetchUsers,
                    child: const Text('Load More'),
                  );
          }

          User user = _users[index];
          return UserCard(
            user: user,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailsScreen(userId: user.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
