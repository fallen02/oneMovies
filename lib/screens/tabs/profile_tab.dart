import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/providers/auth_provider.dart';
import 'package:onemovies/screens/components/custom_button.dart';
import 'package:onemovies/utils/icon_fonts.dart';

class ProfileTab extends ConsumerStatefulWidget {
  const ProfileTab({super.key});

  @override
  ConsumerState<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends ConsumerState<ProfileTab> {
  Future<void> logOut() async {
    await ref.read(authProvider.notifier).signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 50),
        child: Column(
          spacing: 20,
          children: [
            Row(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Image(
                  image: AssetImage('assets/icons/icon.png'),
                  width: 50,
                ),
                Text(
                  "Profile",
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffD7263D),
                  ),
                ),
              ],
            ),

            Column(
              children: [
                CustomButton(
                  text: "Edit Profile",
                  onPressed: () {},
                  prefixiIcon: Broken.user_edit,
                  sufixiIcon: Broken.arrow_right_3,
                ),
                CustomButton(
                  text: "Security",
                  onPressed: () {},
                  prefixiIcon: Broken.shield_tick,
                  sufixiIcon: Broken.arrow_right_3,
                ),
                CustomButton(
                  text: "Watch List",
                  onPressed: () {},
                  prefixiIcon: Broken.heart_circle,
                  sufixiIcon: Broken.arrow_right_3,
                ),
                CustomButton(
                  text: "History",
                  onPressed: () {},
                  prefixiIcon: Broken.clock,
                  sufixiIcon: Broken.arrow_right_3,
                ),
                CustomButton(
                  text: "Help Center",
                  onPressed: () {},
                  prefixiIcon: Broken.like_1,
                  sufixiIcon: Broken.arrow_right_3,
                ),
                CustomButton(
                  text: "Version Control",
                  onPressed: () {},
                  prefixiIcon: Broken.shuffle,
                  sufixiIcon: Broken.arrow_right_3,
                ),
              ],
            ),

            TextButton(
              onPressed: logOut,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 15,
                    children: const [
                      Icon(
                        Broken.logout,
                        size: 30,
                        color: Color(0xffD7263D),
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 20,
                          color: Color(0xffD7263D),
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
    );
  }
}
