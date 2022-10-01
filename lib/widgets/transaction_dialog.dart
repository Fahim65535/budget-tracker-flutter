import 'package:budget_tracker_app/models/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTransactionDialog extends StatefulWidget {
  final Function(TransactionItem) itemtoAdd;
  const AddTransactionDialog({Key? key, required this.itemtoAdd})
      : super(key: key);

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  bool _isExpenseController = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.3,
        height: 270,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Text(
                "Add an expense",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 12),
              //expense text field
              TextField(
                controller: expenseController,
                decoration: const InputDecoration(hintText: "Name of expense"),
              ),
              //amount text field
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(hintText: "Amount in \$"),
              ),
              //switch field
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Is expense?"),
                  Switch.adaptive(
                    value: _isExpenseController,
                    onChanged: (b) {
                      setState(() {
                        _isExpenseController = b;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (amountController.text.isNotEmpty &&
                      expenseController.text.isNotEmpty) {
                    widget.itemtoAdd(TransactionItem(
                      amount: double.parse(amountController.text),
                      text: expenseController.text,
                      isExpense: _isExpenseController,
                    ));
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
