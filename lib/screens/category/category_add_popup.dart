import 'package:flutter/material.dart';
import 'package:money_app/db/category/category_db.dart';
import 'package:money_app/model/category/category_model.dart';

ValueNotifier<CategoryType> selectedCateogryNotfier =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameEditingController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text('add category'),
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: _nameEditingController,
                decoration: const InputDecoration(
                    hintText: 'Category Name', border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: const [
                  RadioButton(title: 'income', type: CategoryType.income),
                  RadioButton(title: 'exponse', type: CategoryType.expense)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: () {
                    final _name = _nameEditingController.text;
                    if (_name.isEmpty) {
                      return;
                    } else {
                      final _type = selectedCateogryNotfier.value;
                     final _category = CategoryModel(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          name: _name,
                          type: _type);
                          CategoryDB().insertCategory(_category);
                          Navigator.pop(ctx);
                    }

                  },
                  child: const Text('Add')),
            )
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({Key? key, required this.title, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCateogryNotfier,
            builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
              return Radio<CategoryType>(
                  value: type,
                  groupValue: selectedCateogryNotfier.value,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    selectedCateogryNotfier.value = value;
                    selectedCateogryNotfier.notifyListeners();
                  });
            }),
        Text(title)
      ],
    );
  }
}
