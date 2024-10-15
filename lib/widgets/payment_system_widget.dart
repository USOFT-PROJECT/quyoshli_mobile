import 'package:flutter/material.dart';

class PaymentSystemWidget extends StatelessWidget {
  const PaymentSystemWidget({super.key, required this.img});

  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 48) / 2,
      height: 64,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: Color.fromRGBO(119, 119, 119, 1),
        ),
      ),
      child: Image.asset(
        img,
        height: 32,
        width: 84,
      ),
    );
  }
}
