import 'package:flutter/material.dart';
import 'package:e_commerce_app/screens/home_page.dart';
import 'package:e_commerce_app/utils/appcolors.dart';
import 'package:e_commerce_app/widgets/build_text_feild_widget.dart';
import 'package:e_commerce_app/widgets/build_elivated_button_widget.dart';
import 'package:e_commerce_app/widgets/build_text_widget.dart';
import 'package:e_commerce_app/widgets/social_icon_widget.dart';

import '../api_service/api_service.dart';
import '../utils/hive.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final TextEditingController _usernameController = TextEditingController(text: 'pranav.codsair@gmail.com');
  final TextEditingController _passwordController = TextEditingController(text: '12345');

  bool _isLoading = false;

  void _signIn() async {
    final username = _usernameController.text;
    final password = _passwordController.text;


    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter both username and password')));
      return;
    }

    setState(() {
      _isLoading = true;
    });


    final authModel = await ApiService().signIn(username, password);


    setState(() {
      _isLoading = false;
    });

    if (authModel != null) {
      String token = authModel.logindetails?.token ?? "";

      appHive.putToken(token: token);

      print('Token saved in Hive: $token');

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Successful! Token saved in Hive.')));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign-in failed')));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.arrow_back_ios_new, size: 20),
              const SizedBox(height: 20),

              Center(
                child: BuildTextWidget(
                  text: 'Sign In',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: BuildTextWidget(
                  text: 'Log in to enjoy your favorite and\ndiscover new delights waiting just for you',
                  fontSize: 16,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),

              BuildTextFeildWidget(
                label: 'Email',
                hint: 'Ex. John Doe',
                controller: _usernameController,
              ),

              BuildTextFeildWidget(
                label: 'Password',
                hint: '****************',
                controller: _passwordController,
                obscureText: true,
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Forgot password feature coming soon')),
                    );
                  },
                  child: BuildTextWidget(
                    text: 'Forgot password ?',
                    fontSize: 14,
                    color: Appcolors.green_shade,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: BuildElivatedButtonWidget(
                  text: _isLoading ? 'Please Wait...' : 'Sign In',
                  onPressed: _signIn,
                  borderRadius: 30,
                  backgroundColor: Colors.teal,
                ),
              ),
              const SizedBox(height: 30),

              Row(
                children: const [
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: BuildTextWidget(text: 'Or sign in with', fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialIconWidget(assetPath: 'https://cdn-icons-png.flaticon.com/512/721/721335.png'),
                  const SizedBox(width: 16),
                  SocialIconWidget(assetPath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgA7ydnVJlRjWN2s0s7fXukBagY5fTSpRoZNjSmwtMw1KahOOyiOuzZxABvsJd7JtXRYA&usqp=CAU'),
                  const SizedBox(width: 16),
                  SocialIconWidget(assetPath: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/2023_Facebook_icon.svg/667px-2023_Facebook_icon.svg.png'),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const BuildTextWidget(text: "Don’t have an account ? ", fontWeight: FontWeight.w500),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    },
                    child: BuildTextWidget(
                      text: 'Sign Up',
                      color: Appcolors.green_shade,
                    ),
                  ),
                ],
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Guest login feature coming soon')),
                    );
                  },
                  child: BuildTextWidget(
                    text: 'Guest Login',
                    color: Appcolors.green_shade,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}