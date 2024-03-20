import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FollowingPageShimmer extends StatelessWidget {
  const FollowingPageShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5,
        (index) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: Card(
                child: ListTile(
                    leading: Shimmer.fromColors(
                      period: const Duration(seconds: 10),
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(80),
                        ),
                        height: 60,
                        width: 60,
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 5, top: 5),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 20,
                          width: 60,
                        ),
                      ),
                    ),
                    subtitle: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        height: 20,
                        width: 60,
                      ),
                    ),
                    trailing: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                        height: 15,
                        width: 15,
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
