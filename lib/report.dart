import 'package:smart_ahwa_manager_app/order.dart';

abstract class ReportGenerator {
  String generate(OrderHandler handler);
}

class DailyReport extends ReportGenerator {
  @override
  String generate(OrderHandler handler) {
    return '---- Daily Report ---'
        '\nTotal Orders:${handler.totalNumberOfOrders}'
        '\n------------\n'
        'Bestseller Drink Today: ${handler.getBestSeller()}'
        '\n------------\n'
        'Pending Orders: ${handler.pendingOrders}';
  }
}

class PendingReport extends ReportGenerator {
  @override
  String generate(OrderHandler handler) {
    final pending = handler.pendingOrdersList;
    if (pending.isEmpty) return "No pending orders 🎉";

    final buffer = StringBuffer('--- Pending Orders Dashboard ---\n');
    for (var order in pending) {
      buffer.writeln(
        "Customer: ${order.customer.name}, Drink: ${order.drinkType}, Notes: ${order.specialInstruction}",
      );
    }
    return buffer.toString();
  }
}
