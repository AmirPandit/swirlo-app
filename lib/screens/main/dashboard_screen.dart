import 'package:flutter/material.dart';
import '../../config/theme_config.dart';
import '../../data/dummy_users.dart';
import '../../models/user_card_model.dart';
import 'dart:math' as math;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<UserCardModel> _users = DummyUsers.getUsers();
  int _currentIndex = 0;

  void _handleSwipe(bool isLike) {
    setState(() {
      if (_currentIndex < _users.length - 1) {
        _currentIndex++;
      } else {
        // Reset to beginning when all cards are viewed
        _currentIndex = 0;
      }
    });

    // Show feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isLike ? 'Liked!' : 'Passed'),
        duration: const Duration(milliseconds: 500),
        backgroundColor: isLike ? const Color(0xFFFF4D67) : AppColors.textSecondary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _users.isEmpty
                  ? _buildEmptyState()
                  : _buildCardStack(),
            ),
            _buildActionButtons(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.ac_unit,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Swirlo',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardStack() {
    return Stack(
      children: [
        // Show next 2 cards in background for depth effect
        if (_currentIndex + 2 < _users.length)
          _buildBackgroundCard(_users[_currentIndex + 2], 2),
        if (_currentIndex + 1 < _users.length)
          _buildBackgroundCard(_users[_currentIndex + 1], 1),
        // Current card on top
        _buildUserCard(_users[_currentIndex]),
      ],
    );
  }

  Widget _buildBackgroundCard(UserCardModel user, int index) {
    return Positioned.fill(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20 + (index * 10.0),
          right: 20 + (index * 10.0),
          top: 10 + (index * 10.0),
          bottom: 100 + (index * 10.0),
        ),
        child: Opacity(
          opacity: 1.0 - (index * 0.2),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(user.photos.first),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserCard(UserCardModel user) {
    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 100),
        child: GestureDetector(
          onPanEnd: (details) {
            if (details.velocity.pixelsPerSecond.dx > 500) {
              // Swipe right - Like
              _handleSwipe(true);
            } else if (details.velocity.pixelsPerSecond.dx < -500) {
              // Swipe left - Pass
              _handleSwipe(false);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Background image
                  Image.network(
                    user.photos.first,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.cardBackground,
                        child: const Icon(
                          Icons.person,
                          size: 100,
                          color: AppColors.textSecondary,
                        ),
                      );
                    },
                  ),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: const [0.5, 1.0],
                      ),
                    ),
                  ),
                  // User info
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                user.name,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${user.age}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                user.distance,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            user.bio,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: user.interests.take(3).map((interest) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                                child: Text(
                                  interest,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Photo indicators
                  Positioned(
                    top: 20,
                    left: 20,
                    right: 20,
                    child: Row(
                      children: List.generate(
                        user.photos.length,
                        (index) => Expanded(
                          child: Container(
                            height: 4,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: index == 0
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    const pinkColor = Color(0xFFFF4D67);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Pass button
          _buildActionButton(
            icon: Icons.close,
            color: Colors.white,
            size: 70,
            iconSize: 35,
            onTap: () => _handleSwipe(false),
          ),
          // Super like button
          _buildActionButton(
            icon: Icons.star,
            color: const Color(0xFF4A9EFF),
            size: 60,
            iconSize: 30,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Super Liked!'),
                  duration: Duration(milliseconds: 500),
                  backgroundColor: Color(0xFF4A9EFF),
                ),
              );
            },
          ),
          // Like button
          _buildActionButton(
            icon: Icons.favorite,
            color: pinkColor,
            size: 70,
            iconSize: 35,
            onTap: () => _handleSwipe(true),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required double size,
    required double iconSize,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color == Colors.white
              ? Colors.white
              : color.withOpacity(0.2),
          shape: BoxShape.circle,
          border: Border.all(
            color: color,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: color == Colors.white ? const Color(0xFFFF4D67) : color,
          size: iconSize,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_search,
            size: 80,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 20),
          Text(
            'No more profiles to show',
            style: TextStyle(
              fontSize: 20,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
