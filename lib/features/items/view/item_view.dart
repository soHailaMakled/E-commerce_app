import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntigradproject/core/resources_manager/appbar_main.dart';
import 'package:ntigradproject/core/utils/app-colors.dart';
import 'package:ntigradproject/core/utils/app_icons.dart';
import 'package:ntigradproject/core/utils/app_images.dart';
import 'package:ntigradproject/core/utils/app_strings.dart';
import 'package:ntigradproject/features/home/view/widget/category_view.dart';
import 'package:ntigradproject/features/home/view/widget/item_card.dart';

class ItemsView extends StatelessWidget {
  const ItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.specialbackground,
      appBar: MyAppBar(appbartitle: SvgPicture.asset(MyAppIcons.homelogo)),
      body: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 6),
                child: Text(
                  AppStrings.allfeatured,
                  style: TextStyle(
                    color: MyAppColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 25),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.16,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CategoryView(
                          categorytext: AppStrings.beauty,
                          image: MyAppImage.makeup,
                        ),
                        CategoryView(
                          categorytext: AppStrings.fashion,
                          image: MyAppImage.women,
                        ),
                        CategoryView(
                          categorytext: AppStrings.kids,
                          image: MyAppImage.clothes,
                        ),
                        CategoryView(
                          categorytext: AppStrings.mens,
                          image: MyAppImage.room,
                        ),
                        CategoryView(
                          categorytext: AppStrings.womens,
                          image: MyAppImage.teshirt,
                        ),
                        CategoryView(
                          categorytext: AppStrings.gifts,
                          image: MyAppImage.gift,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Text(
                AppStrings.products,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 15),

              Column(
                children: [
                  Row(children: [ItemCard(), ItemCard()]),
                  Row(children: [ItemCard(), ItemCard()]),
                  Row(children: [ItemCard(), ItemCard()]),
                  Row(children: [ItemCard(), ItemCard()]),
                  Row(children: [ItemCard(), ItemCard()]),
                  Row(children: [ItemCard(), ItemCard()]),
                  Row(children: [ItemCard(), ItemCard()]),
                  Row(children: [ItemCard(), ItemCard()]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}