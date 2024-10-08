class Exercise {
  String id;
  String name;
  int sets;
  String reps;
  bool completed;
  DateTime? completedAt;

  Exercise({
    required this.id,
    required this.name,
    required this.sets,
    required this.reps,
    this.completed = false,
    this.completedAt,
  });

  factory Exercise.from(String id, Map<String, dynamic> data) {
    return Exercise(
      id: id,
      name: data['name'],
      sets: data['sets'],
      reps: data['reps'].toString(),
      completed: data['completed'] ?? false,
      completedAt: data['completedAt'] != null ? DateTime.parse(data['completedAt']) : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sets': sets,
      'reps': reps,
      'completed': completed,
      'completedAt': completedAt,
    };
  }

  Exercise copyWith({
    String? id,
    String? name,
    int? sets,
    String? reps,
    bool? completed,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      completed: completed ?? this.completed,
    );
  }
}
