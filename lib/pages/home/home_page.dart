import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_sepatu_3/models/category_model.dart';
import 'package:toko_sepatu_3/models/product_model.dart';
import 'package:toko_sepatu_3/models/user_model.dart';
import 'package:toko_sepatu_3/providers/auth_provider.dart';
import 'package:toko_sepatu_3/providers/category_provider.dart';
import 'package:toko_sepatu_3/providers/products_provider.dart';
import 'package:toko_sepatu_3/theme.dart';
import 'package:toko_sepatu_3/widgets/categories_bar.dart';
import 'package:toko_sepatu_3/widgets/categories_title.dart';
import 'package:toko_sepatu_3/widgets/product_card.dart';
import 'package:toko_sepatu_3/widgets/product_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentCategoryIndex = 0;
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    List<CategoryModel> datacategories = categoryProvider.categories;

    Widget header() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultMargin, left: defaultMargin, right: defaultMargin),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo, ${user.name}',
                    style: primaryTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    '@${user.username}',
                    style: subtitleTextSyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    user.profilePhotoUrl,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget categories() {
      return Container(
        height: 40.0,
        margin: EdgeInsets.only(top: defaultMargin),
        child: ListView.builder(
          itemCount: datacategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                currentCategoryIndex = index;
              });
            },
            child: Row(
              children: [
                SizedBox(
                  width: index == 0 ? defaultMargin : 0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  margin: EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: subtitleColor,
                    ),
                    color: index == currentCategoryIndex
                        ? primaryColor
                        : transparentColor,
                  ),
                  child: Text(
                    datacategories[index].name,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: medium,
                      color: index == currentCategoryIndex
                          ? primaryTextColor
                          : subtitleColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget popularProductsTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'Popular Products',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget popularProducts() {
      return Container(
        margin: EdgeInsets.only(
          top: 14,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: defaultMargin,
              ),
              Row(
                children: productProvider.products
                    .map(
                      (product) => ProductCard(product),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      );
    }

    Widget newArrivalsTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'New Arrivals',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget newArrivals() {
      return Container(
        margin: EdgeInsets.only(
          top: 14,
        ),
        child: Column(
          children: productProvider.products
              .map(
                (product) => ProductTile(product),
              )
              .toList(),
        ),
      );
    }

    Future<void> refreshData() async {
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        productProvider.getProducts();
        categoryProvider.getCategories();
      });
    }

    return RefreshIndicator(
      onRefresh: refreshData,
      child: ListView(
        children: [
          header(),
          categories(),
          popularProductsTitle(),
          popularProducts(),
          newArrivalsTitle(),
          newArrivals(),
        ],
      ),
    );
  }
}
