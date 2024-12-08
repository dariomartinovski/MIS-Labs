class Joke {
  int id;
  String setup;
  String punchline;
  String type;

  Joke({required this.id, required this.setup, required this.punchline, required this.type});

  Joke.fromJson(Map<String, dynamic> data) :
      id = data['id'],
      setup = data['setup'],
      punchline = data['punchline'],
      type = data['type'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'setup': setup,
    'punchline': punchline,
    'type': type
  };
}