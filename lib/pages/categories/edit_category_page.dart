import 'package:expense_tracker/mappers/category_mapper.dart';
import 'package:expense_tracker/pages/categories/icon_picker_botomsheet.dart';
import 'package:expense_tracker/repositories/isar_categories_repository.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/category.dart';

class EditCategoryPage extends StatefulWidget {
  final Category initial;

  const EditCategoryPage({
    super.key,
    required this.initial,
  });

  @override
  State<EditCategoryPage> createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  final _repository = IsarCategoriesRepository();


  late IconData _selectedIcon;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.initial.name);
    _selectedIcon = widget.initial.icon;
  }

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

  void _updatePressed() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final updated = Category(
      id: widget.initial.id,
      name: _nameCtrl.text.trim(),
      iconCodePoint: _selectedIcon.codePoint,
      iconFontFamily: _selectedIcon.fontFamily ?? 'MaterialIcons',
    );
    await _repository.update(updated.toDao());

    Navigator.pop(context, 'updated');
  }

  Future<void> _deletePressed() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete category?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    await _repository.deleteById(widget.initial.id);

    Navigator.pop(context, 'deleted');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Category'),
        actions: [
          TextButton(
            onPressed: _updatePressed,
            child: const Text('Update'),
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
                  subtitle: const Text('Tap to choose'),
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
                onFieldSubmitted: (_) => _updatePressed(),
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
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  onPressed: _deletePressed,
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
