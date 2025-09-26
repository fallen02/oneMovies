import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData prefixiIcon;
  final IconData sufixiIcon;
  final VoidCallback onPressed;


  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.prefixiIcon,
    required this.sufixiIcon
    });
  



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: double.infinity,
      child: TextButton(
        onPressed: () {},
        style: ButtonStyle(
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Row(
                spacing: 10,
                children: [
                  Icon(prefixiIcon, size: 20),
                  Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 15,
                      // color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            Icon(sufixiIcon, size: 20),
          ],
        ),
      ),
    );
  }
}
