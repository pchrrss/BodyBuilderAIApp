import 'package:flutter/material.dart';
import 'package:bodybuilderaiapp/model/exercise.dart';

class ExerciseListItem extends StatefulWidget {
  final Exercise exercise;
  final VoidCallback onComplete;
  final VoidCallback onChangeExercise;

  const ExerciseListItem({
    super.key,
    required this.exercise,
    required this.onComplete,
    required this.onChangeExercise,
  });

  @override
  State<ExerciseListItem> createState() => _ExerciseListItemState();
}

class _ExerciseListItemState extends State<ExerciseListItem> {
  @override
  Widget build(BuildContext context) {
    bool isCompleted = widget.exercise.completed;
    print('isCompleted: $isCompleted');

    return Dismissible(
      key: Key(widget.exercise.name),
      background: isCompleted ? null : _buildActionButtons(),
      confirmDismiss: isCompleted
          ? null
          : (direction) async {
              if (direction == DismissDirection.endToStart) {
                widget.onComplete();
              } else if (direction == DismissDirection.startToEnd) {
                widget.onChangeExercise();
              }
              return false;
            }, 
      child: Container(
        color: isCompleted ? Colors.grey[300] : Colors.white, 
        child: ListTile(
          title: Text(
            widget.exercise.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              decoration: isCompleted ? TextDecoration.lineThrough : null,
              color: isCompleted ? Colors.grey : Colors.black87,
            ),
          ),
          subtitle: Text(
            'Sets: ${widget.exercise.sets}, Reps: ${widget.exercise.reps}',
            style: TextStyle(
              fontSize: 16,
              color: isCompleted ? Colors.grey : Colors.black54,
            ),
          ),
          trailing: isCompleted
              ? const Icon(Icons.check, color: Colors.green)
              : const Icon(Icons.arrow_forward_ios, color: Colors.black54),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.green,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 16.0),
            child: const Icon(Icons.check_circle, color: Colors.white),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.blue,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16.0),
            child: const Icon(Icons.swap_horiz, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
