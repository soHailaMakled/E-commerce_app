import 'package:flutter/material.dart';
import 'package:givestarreviews/givestarreviews.dart';
import 'package:ntigradproject/core/utils/app_images.dart';
import 'package:ntigradproject/core/utils/app_strings.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.479,
      height: MediaQuery.of(context).size.height * 0.315,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.196,
            width: MediaQuery.of(context).size.width * 0.434,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(MyAppImage.shirt),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            AppStrings.mensstarry,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            AppStrings.describtion,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
          ),
          Text(
            AppStrings.price,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          StarRating(onChanged: (rate) {}),
        ],
      ),
    );
  }
}