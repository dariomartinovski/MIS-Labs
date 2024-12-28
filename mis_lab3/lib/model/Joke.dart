class Joke {
  int id;
  String setup;
  String punchline;
  String type;
  bool isFavorite;

  Joke({required this.id, required this.setup, required this.punchline, required this.type, this.isFavorite = false});

  Joke.fromJson(Map<String, dynamic> data) :
      id = data['id'],
      setup = data['setup'],
      punchline = data['punchline'],
      type = data['type'],
      isFavorite = data['isFavorite'] ?? false;

  Map<String, dynamic> toJson() => {
    'id': id,
    'setup': setup,
    'punchline': punchline,
    'type': type,
    'isFavorite': isFavorite
  };
}