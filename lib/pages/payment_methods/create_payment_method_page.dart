import 'package:expense_tracker/daos/payment_method.dart';
import 'package:expense_tracker/mappers/payment_method_mapper.dart';
import 'package:expense_tracker/pages/categories/icon_picker_botomsheet.dart';
import 'package:expense_tracker/repositories/isar_payment_method_repository.dart';
import 'package:flutter/material.dart';

class CreatePaymentMethodPage extends StatefulWidget {
  const CreatePaymentMethodPage({super.key});

  @override
  State<CreatePaymentMethodPage> createState() => _CreatePaymentMethodPageState();
}

class _CreatePaymentMethodPageState extends State<CreatePaymentMethodPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();

  IconData _selectedIcon = Icons.category;

  final _repository = IsarPaymentMethodRepository();


  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickIcon() async {
    final picked = await showCategoryIconPicker(
      context,
      selected: _selectedIcon,
    );
    if (picked == null) return;
    setState(() => _selectedIcon = picked);
  }

  Future<void> _save() async {
  final name = _nameCtrl.text.trim();
  if (name.isEmpty) return;

  final paymentMethod = PaymentMethod()
    ..name = name
    ..iconCodePoint = _selectedIcon.codePoint
    ..iconFontFamily = _selectedIcon.fontFamily ?? 'MaterialIcons';

  final id = await _repository.create(paymentMethod);

  // Para confirmar rápido que guardó:
  debugPrint('Payment method created with id: $id');

  // Volvés a la pantalla anterior
  Navigator.pop(context, paymentMethod.toModel());
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create payment method'),
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text('Save'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    child: Icon(
                      _selectedIcon,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  title: const Text('Icon'),
                  subtitle: const Text('Tap para elegir'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: _pickIcon,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _save(),
                validator: (v) {
                  final value = (v ?? '').trim();
                  if (value.isEmpty) return 'Enter a name';
                  if (value.length < 2) return 'Name too short';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.check),
                  label: const Text('Create'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
