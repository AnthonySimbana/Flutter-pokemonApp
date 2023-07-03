import 'package:flutter/material.dart';
import 'package:pokedex_mobile/providers/category_provider.dart';
import 'package:provider/provider.dart';

class CategoryListWidget extends StatefulWidget {
  const CategoryListWidget({super.key});

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              elevation: 10,
              child: ListTile(
                leading: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(
                    image: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/9/95/Fire.jpg'),
                  ),
                ),
                title: Text(
                  categoryProvider.categoriesGetter[index].name,
                ),
              ),
            );
          },
          itemCount: categoryProvider.totalCategories,
        );
      },
    );
  }
}
