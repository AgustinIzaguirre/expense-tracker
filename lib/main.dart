import 'dart:math';

import 'package:expense_tracker/models/Expense.dart';
import 'package:expense_tracker/models/cathegory.dart';
import 'package:expense_tracker/models/group_by.dart';
import 'package:expense_tracker/models/payment_method.dart';
import 'package:expense_tracker/widgets/expense_card.dart';
import 'package:expense_tracker/widgets/home_header.dart';
import 'package:expense_tracker/widgets/pie_chart_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scrollController = ScrollController();

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
          _groupBy == GroupBy.category ? e.cathegory.name : e.paymentMethod.name;
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
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: HomeHeader(
              range: _range,
              groupBy: _groupBy,
              onPickRange: _pickRange,
              onChangeGroupBy: (v) => setState(() => _groupBy = v),
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
      ),
    );
  }

  List<Expense> buildMockExpenses({int total = 60}) {
  const categories = [
    Cathegory(id: 1, name: 'Comida'),
    Cathegory(id: 2, name: 'Transporte'),
    Cathegory(id: 3, name: 'Salud'),
    Cathegory(id: 4, name: 'Hogar'),
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
