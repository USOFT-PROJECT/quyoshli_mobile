import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CartShimmerPage extends StatefulWidget {
  const CartShimmerPage({super.key});

  @override
  State<CartShimmerPage> createState() => _CartShimmerPageState();
}

class _CartShimmerPageState extends State<CartShimmerPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 20.h,
              width: 140.w,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(6)),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ...List.generate(
            2,
            (index) => Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: productItem(),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(
            height: 48,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 20.h,
              width: 140.w,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(6)),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ...List.generate(
            2,
            (index) => Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: productItem(),
            ),
          ),
          SizedBox(
            height: 16,
          ),

          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
            ),
          )
        ],
      ),
    );
  }

  productItem() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            height: 110.w,
            width: 110.w,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
              child: Column(
            children: [
              Container(
                height: 55.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    height: 53.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                  )),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 50.w,
                    height: 53.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
