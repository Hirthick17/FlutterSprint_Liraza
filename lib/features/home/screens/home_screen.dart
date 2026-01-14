import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/animations/fade_in_up.dart';
import '../../chat/screens/chat_screen.dart';
import '../../dashboard/screens/dashboard_screen.dart';
import '../../therapist_directory/screens/therapist_list_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../dashboard/screens/habits_screen.dart';
import '../providers/mood_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeTab(),
    const DashboardScreen(),
    const HabitsScreen(), // New Habits Tab
    const TherapistListScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.hotPink,
          unselectedItemColor: AppColors.textSecondary,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics_rounded),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded), // Calendar Icon
              label: 'Habits',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_rounded),
              label: 'Therapists',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moodState = ref.watch(moodProvider);
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Gradient Header with Mood Check-in
            Container(
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good ${_getGreeting()}, User 👋',
                            style: AppTextStyles.h2.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'How are you feeling today?',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                      Container(
                         padding: const EdgeInsets.all(2),
                         decoration: const BoxDecoration(
                           color: Colors.white,
                           shape: BoxShape.circle,
                         ),
                         child: const CircleAvatar(
                           radius: 20,
                           backgroundImage: AssetImage('assets/images/user_avatar.png'), // Placeholder
                           backgroundColor: AppColors.lightPink,
                           child: Icon(Icons.person, color: AppColors.hotPink),
                         ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Glassmorphism Mood Card
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _MoodEmoji(
                          emoji: '😢',
                          label: 'Sad',
                          isSelected: moodState.selectedMood == 'Sad',
                          onTap: () => ref.read(moodProvider.notifier).logMood('Sad'),
                        ),
                        _MoodEmoji(
                          emoji: '😔',
                          label: 'Low',
                          isSelected: moodState.selectedMood == 'Low',
                          onTap: () => ref.read(moodProvider.notifier).logMood('Low'),
                        ),
                        _MoodEmoji(
                          emoji: '😐',
                          label: 'Okay',
                          isSelected: moodState.selectedMood == 'Okay',
                          onTap: () => ref.read(moodProvider.notifier).logMood('Okay'),
                        ),
                        _MoodEmoji(
                          emoji: '🙂',
                          label: 'Good',
                          isSelected: moodState.selectedMood == 'Good',
                          onTap: () => ref.read(moodProvider.notifier).logMood('Good'),
                        ),
                        _MoodEmoji(
                          emoji: '😊',
                          label: 'Happy',
                          isSelected: moodState.selectedMood == 'Happy',
                          onTap: () => ref.read(moodProvider.notifier).logMood('Happy'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Today's Insight
                  FadeInUp(
                    delay: const Duration(milliseconds: 100),
                    child: Text('Today\'s Insight', style: AppTextStyles.h3),
                  ),
                  const SizedBox(height: 16),
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.hotPink.withOpacity(0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border(left: BorderSide(color: AppColors.hotPink, width: 4)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.lightbulb_outline_rounded, color: AppColors.hotPink, size: 28),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Practice Mindfulness',
                                style: AppTextStyles.h4,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Taking 5 minutes to breathe deeply can reduce anxiety by 30%.',
                                style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ),

                  const SizedBox(height: 24),

                  // Quick Actions Grid
                  FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    child: Text('Quick Actions', style: AppTextStyles.h3),
                  ),
                  const SizedBox(height: 16),
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                    children: [
                      _QuickActionCard(
                        icon: Icons.chat_bubble_rounded,
                        title: 'AI Chat',
                        subtitle: 'Talk now',
                        color: AppColors.hotPink,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ChatScreen()),
                          );
                        },
                      ),
                      _QuickActionCard(
                        icon: Icons.analytics_rounded,
                        title: 'Dashboard',
                        subtitle: 'View stats',
                        color: Colors.purpleAccent,
                        onTap: () {
                          final homeScreenState = context.findAncestorStateOfType<_HomeScreenState>();
                          if (homeScreenState != null) {
                            homeScreenState.setState(() {
                              homeScreenState._currentIndex = 1; 
                            });
                          }
                        },
                      ),
                      _QuickActionCard(
                        icon: Icons.people_rounded,
                        title: 'Therapists',
                        subtitle: 'Find help',
                        color: Colors.teal,
                        onTap: () {
                          final homeScreenState = context.findAncestorStateOfType<_HomeScreenState>();
                          if (homeScreenState != null) {
                            homeScreenState.setState(() {
                              homeScreenState._currentIndex = 3; // Therapist Tab (fixed from 2)
                            });
                          }
                        },
                      ),
                      _QuickActionCard(
                        icon: Icons.book_rounded,
                        title: 'Journal',
                        subtitle: 'Write logs',
                        color: Colors.orange,
                        onTap: () {}, // TODO: Implement Journal
                      ),
                    ],
                  ),
                  ),

                  const SizedBox(height: 24),

                  // Recent Activity Header
                  FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Recent Activity', style: AppTextStyles.h3),
                        TextButton(
                          onPressed: () {},
                          child: const Text('View All', style: TextStyle(color: AppColors.hotPink)),
                        ),
                      ],
                    ),
                  ),
                  
                  // Activity Items
                  FadeInUp(
                    delay: const Duration(milliseconds: 600),
                    child: const _ActivityCard(
                      title: 'Chat Session',
                      subtitle: 'Feeling anxious about work',
                      time: '2 hours ago',
                      icon: Icons.chat,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  FadeInUp(
                    delay: const Duration(milliseconds: 700),
                    child: const _ActivityCard(
                      title: 'Mood Log: Happy',
                      subtitle: 'Great progress w/ project',
                      time: 'Yesterday',
                      icon: Icons.mood,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Morning';
    if (hour < 17) return 'Afternoon';
    return 'Evening';
  }
}

class _MoodEmoji extends StatelessWidget {
  final String emoji;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _MoodEmoji({
    required this.emoji,
    required this.label,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.3) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(
              emoji,
              style: TextStyle(
                fontSize: isSelected ? 32 : 28,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(title, style: AppTextStyles.h4),
            const SizedBox(height: 4),
            Text(subtitle, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final Color color;

  const _ActivityCard({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
           BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
             padding: const EdgeInsets.all(10),
             decoration: BoxDecoration(
               color: color.withOpacity(0.1),
               shape: BoxShape.circle,
             ),
             child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                Text(subtitle, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
          Text(time, style: AppTextStyles.caption.copyWith(color: AppColors.textHint)),
        ],
      ),
    );
  }
}
