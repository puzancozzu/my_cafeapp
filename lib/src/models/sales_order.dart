class SalesOrder {
  final String name;
  final String summary;
  final DateTime date;
  final int items;
  final double total;

  SalesOrder({
    required this.name,
    required this.summary,
    required this.date,
    required this.items,
    required this.total,
  });
}