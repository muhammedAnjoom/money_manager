import 'package:flutter/material.dart';
import 'package:money_app/db/category/category_db.dart';
import 'package:money_app/db/transtion/transtion_db.dart';
import 'package:money_app/model/category/category_model.dart';
import 'package:money_app/model/transtion/transaction_model.dart';
import 'package:money_app/screens/category/expones_categoeryList.dart';

class ScreenAddTranstion extends StatefulWidget {
  static const routeName = 'add-transtion';
  const ScreenAddTranstion({Key? key}) : super(key: key);

  @override
  State<ScreenAddTranstion> createState() => _ScreenAddTranstionState();
}

class _ScreenAddTranstionState extends State<ScreenAddTranstion> {
  DateTime? _selecteDate;
  CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategoryModel;
  String? _categoryID;

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _selectedCategorytype = CategoryType.income;
    // TransactionDb().getTransaction().then((value){
    //   print(value.toString());
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Purshose widget
          TextFormField(
            controller: _purposeTextEditingController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                hintText: 'Purpose', border: OutlineInputBorder()),
          ),
          //size widget
          const SizedBox(
            height: 20,
          ),
          //Amount widget
          TextFormField(
            controller: _amountTextEditingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: 'Amount', border: OutlineInputBorder())),
          //selected date widget

          TextButton.icon(
              onPressed: () async {
                final _selectedDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 30)),
                    lastDate: DateTime.now());
                if (_selectedDateTemp == null) {
                  return;
                } else {
                  print(_selectedDateTemp.toString());
                  setState(() {
                    _selecteDate = _selectedDateTemp;
                  });
                }
              },
              icon: const Icon(Icons.calendar_today),
              label: Text(_selecteDate == null
                  ? 'Selected Date'
                  : _selecteDate!.toString())),

          //radio button
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Radio<CategoryType>(
                      value: CategoryType.income,
                      groupValue: _selectedCategorytype,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategorytype = CategoryType.income;
                          _categoryID = null;
                        });
                      }),
                  const Text('Income'),
                ],
              ),
              Row(
                children: [
                  Radio<CategoryType>(
                      value: CategoryType.expense,
                      groupValue: _selectedCategorytype,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategorytype = CategoryType.expense;
                          _categoryID = null;
                        });
                      }),
                  const Text('Expense')
                ],
              ),
            ],
          ),
          //catetgory type
          DropdownButton<String>(
              hint: const Text('selected item'),
              value: _categoryID,
              items: (_selectedCategorytype == CategoryType.income
                      ? CategoryDB().incomeCategoryList
                      : CategoryDB().exponseCategoryList)
                  .value
                  .map((e) {
                return DropdownMenuItem(
                  onTap: (){
                    print(e.toString());
                    _selectedCategoryModel = e;
                  },
                  value: e.id,
                   child: Text(e.name));
              }).toList(),
              onChanged: (seletedValue) {
                setState(() {
                  _categoryID = seletedValue;
                });
                print(seletedValue);
              }),
          //sumbit
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () {
                      addTrasction();
                      Navigator.of(context).pop();
                      TransactionDb.instance.refresh();
                    }, child: const Text('Sumbit')),
              ),
            ],
          )
        ]),
      ))),
    );
  }

  Future<void> addTrasction() async{
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;
    if(_purposeText.isEmpty){
      return;
    }
    if(_amountText.isEmpty){
      return;
    }
    if(_categoryID == null){
      return;
    }
    if(_selecteDate == null){
      return;
    }
    if(_selectedCategoryModel == null){
      return;
    }
   final _parseAmount = double.tryParse(_amountText);
   if(_parseAmount == null){
     return;
   }
    // _selecteDate
    // _selectedCategorytype
    // _categoryID
   final _model =  TransctionModel(
      purpose: _purposeText,
      amount: _parseAmount,
      date: _selecteDate!,
      type: _selectedCategorytype!,
     category: _selectedCategoryModel!
     );
     TransactionDb.instance.addTransaction(_model);
  }
}
