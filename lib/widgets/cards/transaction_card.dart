import 'package:budget_tracker_app/models/transaction_item.dart';
import 'package:budget_tracker_app/view_models/budget_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionCard extends StatelessWidget {
  final TransactionItem item;
  const TransactionCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  const Text("Delete them"),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      final budgetViewModel =
                          Provider.of<BudgetViewModel>(context, listen: false);
                      budgetViewModel.deleteItem(item);
                      Navigator.pop(context);
                    },
                    child: const Text("Yes"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("No"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 7, top: 7),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              offset: const Offset(0, 25),
              blurRadius: 50,
            ),
          ],
        ),
        child: Row(
          children: [
            //item text
            Text(
              item.text,
              style: const TextStyle(fontSize: 20),
            ),
            const Spacer(), //understood
            //isExpense
            Text(
              (!item.isExpense ? "+ " : "- ") +
                  item.amount.toString(), //clarity lacking - bool
              style: const TextStyle(fontSize: 18),
            ),
            //double amount
          ],
        ),
      ),
    );
  }
}
