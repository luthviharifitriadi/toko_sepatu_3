import 'package:flutter/material.dart';
import 'package:toko_sepatu_3/models/category_model.dart';
import 'package:toko_sepatu_3/providers/auth_provider.dart';
import 'package:toko_sepatu_3/providers/category_provider.dart';
import 'package:provider/provider.dart';
import 'package:toko_sepatu_3/providers/products_provider.dart';
import 'package:toko_sepatu_3/theme.dart';

class CategoriesTitle extends StatelessWidget {
  final CategoryModel categories;
  CategoriesTitle(this.categories);
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    int currentCategoryIndex = 0;

    handle() async {
      await productProvider.getProducts();
    }

    return GestureDetector(
      onTap: () {},
      child: Container(
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
        ),
        child: Text(
          categories.name,
          style: subtitleTextSyle.copyWith(
            fontSize: 13,
            fontWeight: medium,
          ),
        ),
      ),
    );
  }
}
