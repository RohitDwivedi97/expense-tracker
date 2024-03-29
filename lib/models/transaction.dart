class Expense {
  final String id;
  final double amount;
  final String datetime;
  final String title;

  Expense({required this.id, required this.amount,required this.datetime,required this.title});

  // Convert a transaction into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'datetime': datetime,
      'title': title
    };
  }
}