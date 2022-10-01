import 'package:budget_tracker_app/view_models/budget_view_model.dart';
import 'package:budget_tracker_app/widgets/cards/transaction_card.dart';
import 'package:budget_tracker_app/widgets/transaction_dialog.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddTransactionDialog(
                itemtoAdd: (value) {
                  final budgetService =
                      Provider.of<BudgetViewModel>(context, listen: false);
                  budgetService.addItem(value);
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: screenSize.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Consumer<BudgetViewModel>(
                    builder: (context, value, child) {
                      final balance = value.getBalance();
                      final budget = value.getBudget();
                      double percentage = balance / budget;

                      //making sure % is not -ve and not bigger than 1
                      if (percentage < 0) {
                        percentage = 0;
                      }
                      if (percentage > 1) {
                        percentage = 1;
                      }

                      return CircularPercentIndicator(
                        radius: screenSize.height / 3,
                        lineWidth: 10,
                        percent: percentage,
                        center: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "\$${balance.toString().split(".")[0]}",
                              style: const TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Balance",
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Budget: \$$budget",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        progressColor: Theme.of(context).colorScheme.primary,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 35),
                const Text(
                  "Items",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Consumer<BudgetViewModel>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      // <- *use this method now since state managemnt exists*
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: value.items.length,
                      itemBuilder: (context, index) {
                        return TransactionCard(
                          item: value.items[index],
                        );
                      },
                    );
                  },
                ),

                // ...List.generate(        <- *this method is fine if we have few items and no state*
                //     itemList.length,
                //     (index) => TransactionCard(
                //           item: itemList[index],
                //         )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
