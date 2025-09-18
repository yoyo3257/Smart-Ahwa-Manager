class Customer {
  late final String _name;
  Customer(this._name);

  String get name => _name;
}

class Menu {
  late List<String> _drinks;

  Menu(List<String> drinks) {
    _drinks = drinks;
  }

  List<String> get drinks => List.unmodifiable(_drinks);
}

class HotDrinks extends Menu {
  HotDrinks() : super(['shai', 'Turkish coffee', 'helba', 'hibiscus tea hot']);
}

class ColdDrinks extends Menu {
  ColdDrinks() : super(['lamoon', 'hibiscus tea cold', 'ice coffee']);
}
