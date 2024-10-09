class Exercise {
  String id;
  String name;
  int sets;
  String reps;
  bool completed;
  String? instruction;
  DateTime? completedAt;

  Exercise({
    required this.id,
    required this.name,
    required this.sets,
    required this.reps,
    this.completed = false,
    this.instruction,
    this.completedAt,
  });

  factory Exercise.from(String id, Map<String, dynamic> data) {
    return Exercise(
      id: id,
      name: data['name'],
      sets: data['sets'],
      reps: data['reps'].toString(),
      completed: data['completed'] ?? false,
      instruction: data['instruction'],
      completedAt: data['completedAt']?.toDate(),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sets': sets,
      'reps': reps,
      'completed': completed,
      'instruction': instruction,
      'completedAt': completedAt,
    };
  }

  Exercise copyWith({
    String? id,
    String? name,
    int? sets,
    String? reps,
    bool? completed,
    String? instruction,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      completed: completed ?? this.completed,
      instruction: instruction ?? this.instruction,
    );
  }
}
