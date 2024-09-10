import 'package:flutter/material.dart';
import 'package:home_test_flutter/commons/color.dart';

class CostumeHeader extends StatelessWidget {
  const CostumeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: ColorValues.purplePastel,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(33.0),
              bottomRight: Radius.circular(33.0))),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/images/logo.png',
            height: 165,
            width: 235,
          ),
          const Text(
            'MyToDo',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
          const SizedBox(height: 10,),
          const Text(
            'Gunakan untuk mengatur To-Do anda!',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white
            ),
          ),
        ],
      ),
    );
  }
}
