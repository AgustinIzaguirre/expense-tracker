import 'dart:math';

import 'package:expense_tracker/models/Expense.dart';
import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/models/currency.dart';
import 'package:expense_tracker/models/group_by.dart';
import 'package:expense_tracker/models/payment_method.dart';
import 'package:expense_tracker/widgets/bottom_nav_bar.dart';
import 'package:expense_tracker/pages/expenses/expense_card.dart';
import 'package:expense_tracker/pages/expenses/expenses_header.dart';
import 'package:expense_tracker/widgets/pie_chart/pie_chart_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {

  final _scrollController = ScrollController();
  BottomNavItem _currentTab = BottomNavItem.expenses;

  late final List<Expense> _allExpenses;
  final List<Expense> _visible = [];

  bool _isLoadingMore = false;
  bool _hasMore = true;
  int _page = 0;

  static const _pageSize = 20;

  DateTimeRange _range = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  );

  GroupBy _groupBy = GroupBy.category;

  @override
  void initState() {
    super.initState();
    _allExpenses = buildMockExpenses();
    _scrollController.addListener(_onScroll);
    _refresh();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_hasMore || _isLoadingMore) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      _fetchNextPage();
    }
  }

  List<Expense> get _filteredAll {
    final start = DateTime(_range.start.year, _range.start.month, _range.start.day);
    final end = DateTime(_range.end.year, _range.end.month, _range.end.day, 23, 59);

    return _allExpenses
        .where((e) => !e.date.isBefore(start) && !e.date.isAfter(end))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<void> _refresh() async {
    setState(() {
      _visible.clear();
      _page = 0;
      _hasMore = true;
    });
    await _fetchNextPage();
  }

  Future<void> _fetchNextPage() async {
    if (_isLoadingMore || !_hasMore) return;

    setState(() => _isLoadingMore = true);
    await Future.delayed(const Duration(milliseconds: 200));

    final all = _filteredAll;
    final start = _page * _pageSize;
    final end = min(start + _pageSize, all.length);

    if (start >= all.length) {
      setState(() {
        _hasMore = false;
        _isLoadingMore = false;
      });
      return;
    }

    setState(() {
      _visible.addAll(all.sublist(start, end));
      _page++;
      _hasMore = end < all.length;
      _isLoadingMore = false;
    });
  }

  Map<String, double> _pieTotals() {
    final map = <String, double>{};
    for (final e in _filteredAll) {
      final key =
          _groupBy == GroupBy.category ? e.category.name : e.paymentMethod.name;
      map[key] = (map[key] ?? 0) + parseAmount(e.amount);
    }
    return map;
  }

  double parseAmount(String value) {
  final format = NumberFormat.decimalPattern('es_AR');
  return format.parse(value).toDouble();
}

  Future<void> _pickRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: _range,
    );
    if (picked == null) return;

    setState(() => _range = picked);
    await _refresh();
  }

  @override
  Widget build(BuildContext context) {
    Currency currency = Currency.ars;

    return CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ExpensesHeader(
              range: _range,
              groupBy: _groupBy,
              currency: currency,
              onPickRange: _pickRange,
              onChangeGroupBy: (v) => setState(() => _groupBy = v),
              onChangeCurrency: (c) {
                setState(() => currency = c);
                // más adelante: refrescar lista / recalcular pie
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PieChartCard(
                title: _groupBy == GroupBy.category
                    ? 'Gastos por categoría'
                    : 'Gastos por medio de pago',
                totals: _pieTotals(),
              ),
            ),
          ),
          SliverList.separated(
            itemCount: _visible.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ExpenseCard(expense: _visible[index]),
              );
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _isLoadingMore
                  ? const Center(child: CircularProgressIndicator())
                  : (!_hasMore && _visible.isNotEmpty)
                      ? const Center(child: Text('No hay más gastos'))
                      : null,
            ),
          ),
        ],
      );
  }

  List<Expense> buildMockExpenses({int total = 60}) {
  var categories = [
   Category(
    id: 1,
    name: 'Comida',
    iconCodePoint: Icons.restaurant.codePoint,
    iconFontFamily: Icons.restaurant.fontFamily!,
  ),
  Category(
    id: 2,
    name: 'Transporte',
    iconCodePoint: Icons.directions_bus.codePoint,
    iconFontFamily: Icons.directions_bus.fontFamily!,
  ),
  Category(
    id: 3,
    name: 'Salud',
    iconCodePoint: Icons.medical_services.codePoint,
    iconFontFamily: Icons.medical_services.fontFamily!,
  ),
  Category(
    id: 4,
    name: 'Hogar',
    iconCodePoint: Icons.home.codePoint,
    iconFontFamily: Icons.home.fontFamily!,
  ),
  ];

  const methods = [
    PaymentMethod(id: 1, name: 'Efectivo'),
    PaymentMethod(id: 2, name: 'Débito Visa'),
    PaymentMethod(id: 3, name: 'Crédito Master Card'),
    PaymentMethod(id: 3, name: 'Crédito Visa'),
    PaymentMethod(id: 4, name: 'Mercado Pago'),
  ];

  final now = DateTime.now();
  final rnd = Random(7);

  return List.generate(total, (i) {
    return Expense(
   (1200 + (i % 5) * 350).toString(),
    'Gasto mock #${i + 1}',
    methods[(i + 1) % methods.length],
    categories[i % categories.length],
    now.subtract(Duration(days: rnd.nextInt(45))),
    "ARS"
    );
  });
  }
}
