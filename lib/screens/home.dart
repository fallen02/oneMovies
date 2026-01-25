import 'package:flutter/material.dart';
import 'package:onemovies/screens/sign_in.dart';
import 'package:onemovies/screens/components/custom_text_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        // padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼 Hero Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://placehold.co/400x600.png',
                height: 600,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  return progress == null
                      ? child
                      : const LinearProgressIndicator();
                },
              ),
            ),

            const SizedBox(height: 24),

            // 📝 Title
            Padding(
              padding: EdgeInsetsGeometry.all(10),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffEAEAEA),
                      ),
                      text: "Welcome to ",
                      children: [
                        TextSpan(
                          style: TextStyle(color: colors.primary),
                          text: "OneApp",
                        ),
                      ],
                    ),
                  ),

                  // 🧘 Subtitle
                  Text(
                    'Just sit back and relax',
                    style: textTheme.headlineSmall?.copyWith(
                      color: colors.onSurface.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 🔘 Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: CustomTextButton(
                        text: 'Sign Up',
                        type: CustomTextButtonType.secondary,
                        onPressed: () {},
                      ),),
                      SizedBox(width: 10,),
                      Expanded(child: CustomTextButton(
                        text: 'Sign In',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const SignIn()),
                          );
                        },
                      ),)
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
