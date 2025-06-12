import 'package:flutter/material.dart';
import 'package:ntigradproject/core/utils/app-colors.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({
    super.key,
    required this.categorytext,
    required this.image,
  });
  final String categorytext;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(image),
            radius: MediaQuery.of(context).size.width * 0.10,
          ),

          Text(
            categorytext,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: MyAppColors.categoryblack,
            ),
          ),
        ],
      ),
    );
  }
}