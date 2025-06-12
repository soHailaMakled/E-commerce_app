import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ntigradproject/core/resources_manager/appbar_main.dart';
import 'package:ntigradproject/core/utils/app-colors.dart';
import 'package:ntigradproject/core/utils/app_icons.dart';
import 'package:ntigradproject/core/utils/app_images.dart';
import 'package:ntigradproject/core/utils/app_strings.dart';
import 'package:ntigradproject/features/home/view/widget/category_view.dart';
import 'package:ntigradproject/features/home/view/widget/item_card.dart';

class FinalHomeView extends StatelessWidget {
  const FinalHomeView({super.key});

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
              // شريط البحث
              Container(
                width: double.infinity,
                height: 40,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: MyAppColors.background,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: TextFormField(
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: SvgPicture.asset(MyAppIcons.search),
                    hintText: 'Search any Product',
                    hintStyle: const TextStyle(
                      color: MyAppColors.gray,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ),
              // عنوان القسم "All Featured"
              const Padding(
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
              // قائمة الفئات في سطر أفقي
              const Padding(
                padding: EdgeInsets.only(left: 8.0, top: 25),
                child: SizedBox(
                  height: 100, // تعديل الارتفاع حسب الحاجة
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
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
              // Slider باستخدام CarouselSlider
              CarouselSlider(
                items: [1, 2, 3].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber,
                        ),
                        child: SvgPicture.asset(MyAppIcons.slider),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(viewportFraction: 1, autoPlay: true),
              ),
              // DotsIndicator أسفل الـ Carousel
              Center(child: DotsIndicator(dotsCount: 3)),
              // عنوان القسم "Recommended"
              const Text(
                AppStrings.recommended,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 15),
              // عرض بعض المنتجات باستخدام ItemCard (يمكن تعديل التصميم)
              Row(
                children: const [
                  Expanded(child: ItemCard()),
                  SizedBox(width: 10),
                  Expanded(child: ItemCard()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
