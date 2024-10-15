import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FavouriteShimmerPage extends StatefulWidget {
  const FavouriteShimmerPage({super.key});

  @override
  State<FavouriteShimmerPage> createState() => _FavouriteShimmerPageState();
}

class _FavouriteShimmerPageState extends State<FavouriteShimmerPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 16,
          childAspectRatio: 1 / 1.4, // Adjusted for better height management
        ),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shimmer effect for the image
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width:    (MediaQuery.of(context).size.width - 48) / 2 ,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Shimmer effect for the text
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: (MediaQuery.of(context).size.width - 48) / 2.5,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: (MediaQuery.of(context).size.width - 48) / 3,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
