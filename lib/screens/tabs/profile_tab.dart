import 'package:flutter/material.dart';
import 'package:onemovies/screens/tabs/components/custom_button.dart';
import 'package:onemovies/utils/appwrite/auth.dart';
import 'package:onemovies/utils/icon_fonts.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {

  dynamic logOut(){
    final Auth auth = context.read<Auth>();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 50, 10, 50),
        child: Column(
          spacing: 20,
          children: [
            Row(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/icons/icon.png'),
                  fit: BoxFit.scaleDown,
                  width: 50,
                  gaplessPlayback: true,
                  isAntiAlias: true,
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
            SizedBox(
              // width: double.infinity,
              child: TextButton(
                onPressed: () {
                  logOut();
                },
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Row(
                        spacing: 15,
                        children: [
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
                    ),
                    // Icon(sufixiIcon, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
