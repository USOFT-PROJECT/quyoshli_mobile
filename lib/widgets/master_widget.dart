import 'package:flutter/material.dart';

class MasterWidget extends StatelessWidget {
  const MasterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: double.infinity,
      height: 142,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: const Color(0xFFE7EAE7),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              "assets/images/dev/master_img.png",
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //master name
                Text(
                  "Акмал Орипов",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 4,
                ),
                //phone number
                Text(
                  "Телефон: +998(99) 000-00-00",
                  style: TextStyle(color: Color(0xFF454745), fontSize: 12),
                ),
                SizedBox(
                  height: 4,
                ),
                Divider(),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "График работы: Пн-Сб, 09:00-18:00",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "Стоимость р.: 15 000 000 сум",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
