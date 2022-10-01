import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BudgetDialog extends StatefulWidget {
  final Function(double) budgetToAdd;
  const BudgetDialog({Key? key, required this.budgetToAdd}) : super(key: key);

  @override
  State<BudgetDialog> createState() => _BudgetDialogState();
}

class _BudgetDialogState extends State<BudgetDialog> {
  final TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.3,
        height: 190,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Add a Budget",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(hintText: "Budget in \$"),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (amountController.text.isNotEmpty) {
                    widget.budgetToAdd(
                      double.parse(amountController.text),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                      fontSize: 18,
                      backgroundColor: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
