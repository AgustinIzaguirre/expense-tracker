import 'package:expense_tracker/mappers/payment_method_mapper.dart';
import 'package:expense_tracker/models/payment_method.dart';
import 'package:expense_tracker/pages/payment_methods/payment_method_card.dart';
import 'package:expense_tracker/repositories/isar_payment_method_repository.dart';
import 'package:expense_tracker/widgets/bottom_nav_bar.dart';
import 'package:expense_tracker/daos/payment_method.dart' as dao;
import 'package:expense_tracker/widgets/expense_tracker_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PaymentMethodsPage extends StatefulWidget {

  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => PaymentMethodsPageState();
}

class PaymentMethodsPageState extends State<PaymentMethodsPage> {
  static const String PAYMENT_METHODS_TITLE = "Payment Methods";
  static const String PAYMENT_METHODS_TOOLTIP = "Create payment method";
  
  BottomNavItem _currentTab = BottomNavItem.categories;
  final _repository = IsarPaymentMethodRepository();
  late Future<List<PaymentMethod>> _futurePaymentMethods;

  @override
  void initState() {
    super.initState();
    _futurePaymentMethods = _load();
  }

  Future<List<PaymentMethod>> _load() async {
    final List<dao.PaymentMethod> paymentMethodsList = await _repository.getAll();

    return paymentMethodsList
        .map((d) => d.toModel(),)
        .toList();
  }

  Future<void> refresh() async {
    setState(() {
      _futurePaymentMethods = _load();
    });
    await _futurePaymentMethods;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PaymentMethod>>(
      future: _futurePaymentMethods,
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

        final paymentMethods = snapshot.data ?? [];

        if (paymentMethods.isEmpty) {
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
            itemCount: paymentMethods.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final paymentMethod = paymentMethods[index];
              return Slidable(
                key: ValueKey(paymentMethod.id),
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_) async {
                        await _repository.deleteById(paymentMethod.id);
                        await refresh();
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: PaymentMethodCard(
                  paymentMethod: paymentMethod,
                  onTap: () async {
                    //final result = await Navigator.push<String>(
                      //context,
                      //MaterialPageRoute(
                        //builder: (_) => EditCategoryPage(initial: paymentMethod),
                      //),
                      //TODO
                   // );
  
                    //if (result == 'updated' || result == 'deleted') {
                      //await refresh();
                    //}
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