import 'dart:io';

import 'package:smart_ahwa_manager_app/classes.dart';
import 'package:smart_ahwa_manager_app/order.dart';
import 'package:smart_ahwa_manager_app/report.dart';

void main() {
  final hotMenu = HotDrinks();
  final coldMenu = ColdDrinks();
  final fullMenu = [...hotMenu.drinks, ...coldMenu.drinks];
  final orderHandler = OrderHandler();
  bool ordering = true;
  final dailyReport = DailyReport();
  final pendingReport = PendingReport();
  bool completing = true;
  // Start
  print('Welcome to the Smart Ahwa Manager!\n');
  while (ordering) {
    stdout.write('Enter customer name: ');
    final customerName = stdin.readLineSync()?.trim();
    if (customerName == null || customerName.isEmpty) {
      print('Invalid name. Try Again.');
      continue;
    }
    final customer = Customer(customerName);

    // TODO: Create menus and show them:
    print("\nMenu:");
    for (var i = 0; i < fullMenu.length; i++) {
      print("${i + 1}. ${fullMenu[i]}");
    }
    // TODO: Take order
    stdout.write("Select a drink (number): ");
    final drinkIndex = int.tryParse(stdin.readLineSync() ?? "") ?? 0;
    if (drinkIndex < 1 || drinkIndex > fullMenu.length) {
      print("Invalid selection. Try again.");
      continue;
    }
    final drink = fullMenu[drinkIndex - 1];
    stdout.write("Any special instructions? (press enter to skip): ");
    final specialInstruction = stdin.readLineSync() ?? "";

    final order = Order(customer, drink, specialInstruction);
    orderHandler.takeOrder(order);
    print("\nOrder added successfully!\n");

    // Repeat:
    stdout.write("Add another order? (y/n): ");
    final cont = stdin.readLineSync()?.toLowerCase();
    if (cont != "y") {
      ordering = false;
    }
  }
  // TODO: Show reports
  print("\n" + dailyReport.generate(orderHandler));
  print("\n" + pendingReport.generate(orderHandler));

  // TODO: Make order completed
  while (completing && orderHandler.pendingOrdersList.isNotEmpty){
    print("\nPending Orders:");
    final pending = orderHandler.pendingOrdersList;
    for (var i = 0; i < pending.length; i++) {
      print("${i + 1}. ${pending[i].customer.name} - ${pending[i].drinkType}");
    }
    stdout.write("Complete an order (number) or 0 to exit: ");
    final completeIndex = int.tryParse(stdin.readLineSync() ?? "") ?? -1;
    if (completeIndex == 0) break;
    if (completeIndex < 1 || completeIndex > pending.length) {
      print("Invalid selection.");
      continue;
    }

    orderHandler.completeOrder(pending[completeIndex - 1]);
    print("Order marked as completed.");

  }
  print("\nFinal Reports:");
  print("\n" + dailyReport.generate(orderHandler));
  print("\n" + pendingReport.generate(orderHandler));

}
