import 'classes.dart';

class Order {
  late Customer _customer;
  late String _drinkType;
  late String _specialInstruction;
  late bool _isDone = false;

  bool get isDone => _isDone;

  String get drinkType => _drinkType;

  Customer get customer => _customer;

  String get specialInstruction => _specialInstruction;

  Order(
    this._customer,
    this._drinkType,
    this._specialInstruction, [
    this._isDone = false,
  ]);
  void _markDone() {
    _isDone = true;
  }
}

class OrderHandler {
  final List<Order> _orderList = [];

  void takeOrder(Order order) {
    _orderList.add(order);
  }

  int get completedOrders => _orderList.where((o) => o.isDone).length;

  int get pendingOrders => _orderList.where((o) => !o.isDone).length;

  List<Order> get pendingOrdersList =>
      _orderList.where((order) => !order.isDone).toList();

  int get totalNumberOfOrders => _orderList.length;

  String getBestSeller() {
    final Map<String, int> drinkCount = {};
    for (var order in _orderList) {
      drinkCount[order.drinkType] = (drinkCount[order.drinkType] ?? 0) + 1;
    }

    String bestSeller = '';
    int maxCount = 0;
    drinkCount.forEach((drink, count) {
      if (count > maxCount) {
        maxCount = count;
        bestSeller = drink;
      }
    });

    return bestSeller.isNotEmpty ? bestSeller : 'No orders yet';
  }

  void completeOrder(Order order) {
    if (!_orderList.contains(order)) {
      throw ArgumentError("Order not found in system.");
    }
    order._markDone();
  }
}
