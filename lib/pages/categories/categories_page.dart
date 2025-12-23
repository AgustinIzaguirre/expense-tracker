import 'package:expense_tracker/mappers/category_mapper.dart';
import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/daos/category.dart' as dao;
import 'package:expense_tracker/pages/categories/category_card.dart';
import 'package:expense_tracker/pages/categories/edit_category_page.dart';
import 'package:expense_tracker/repositories/isar_categories_repository.dart';
import 'package:expense_tracker/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CategoriesPage extends StatefulWidget {

  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => CategoriesPageState();
}

class CategoriesPageState extends State<CategoriesPage> {
  static const String CATEGORIES_TITLE = "Categories";
  static const String CATEGORIES_TOOLTIP = "Create category";
  
  BottomNavItem _currentTab = BottomNavItem.categories;
  final _repository = IsarCategoriesRepository();
  late Future<List<Category>> _futureCategories;

  @override
  void initState() {
    super.initState();
    _futureCategories = _load();
  }

  Future<List<Category>> _load() async {
    final List<dao.Category> categoriesList = await _repository.getAll();

    return categoriesList
        .map((d) => d.toModel(),)
        .toList();
  }

  Future<void> refresh() async {
    setState(() {
      _futureCategories = _load();
    });
    await _futureCategories;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: _futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }

        final categories = snapshot.data ?? [];

        if (categories.isEmpty) {
          return RefreshIndicator(
            onRefresh: refresh,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                SizedBox(height: 200),
                Center(child: Text('No hay categorías todavía')),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: refresh,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final c = categories[index]; // model.Category
              return Slidable(
                key: ValueKey(c.id),
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_) async {
                        await _repository.deleteById(c.id);
                        await refresh();
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: CategoryCard(
                  category: c,
                  onTap: () async {
                    final result = await Navigator.push<String>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditCategoryPage(initial: c),
                      ),
                    );
  
                    if (result == 'updated' || result == 'deleted') {
                      await refresh();
                    }
                  }
                ),
              );
            },
          ),
        );
      },
    );
  }
}