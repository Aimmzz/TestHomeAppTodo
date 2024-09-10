import 'package:flutter/material.dart';
import 'package:home_test_flutter/commons/color.dart';
import 'package:home_test_flutter/screens/todo_page.dart';
import 'package:home_test_flutter/widgets/costume_header.dart';
import 'package:home_test_flutter/widgets/login_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CostumeHeader(),
              const SizedBox(height: 20,),
              _bodyWithPadding()
            ],
          ),
        ),
      ),
    );
  }

  Widget _bodyWithPadding() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          LoginTextField(
            label: 'Username',
            controller: _emailController,
            obscureText: false,
          ),
          const SizedBox(height: 20,),
          LoginTextField(
            label: 'Password',
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                  }
                );
              },
              icon: Icon(
                _isPasswordVisible
                  ? Icons.visibility_off
                  : Icons.visibility,
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {},
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorValues.purple,
              fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => 
              const TodoPage()),
              );
            },
            child: const Text(
              'Login',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
                color: Colors.white
              ),
            )
          ),
        ],
      ),
    );
  }
}