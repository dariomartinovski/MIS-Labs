class ExtendedIngredient {
  final int id;
  final String name;
  final String original;
  final double amount;
  final String unit;

  ExtendedIngredient({
    required this.id,
    required this.name,
    required this.original,
    required this.amount,
    required this.unit,
  });

  factory ExtendedIngredient.fromJson(Map<String, dynamic> json) {
    return ExtendedIngredient(
      id: json['id'],
      name: json['name'],
      original: json['original'],
      amount: (json['amount'] as num).toDouble(),
      unit: json['unit'] ?? '',
    );
  }
}