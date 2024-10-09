import 'package:flutter/material.dart';
import 'package:bodybuilderaiapp/model/exercise.dart';

class ExerciseListItem extends StatefulWidget {
  final Exercise exercise;
  final VoidCallback onComplete;
  final Future<void> Function() onChangeExercise;

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
  bool isReplacing = false;
  bool showInstruction = false;

  @override
  Widget build(BuildContext context) {
    final textStyle = widget.exercise.completed
        ? const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          )
        : const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          );

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: widget.exercise.completed ? Colors.grey[300] : Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(
                Icons.fitness_center,
                color: widget.exercise.completed ? Colors.grey : Colors.blue,
              ),
              title: Text(widget.exercise.name, style: textStyle),
              subtitle: Text(
                'Sets: ${widget.exercise.sets}, Reps: ${widget.exercise.reps}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.check_circle,
                      color: widget.exercise.completed ? Colors.green : Colors.grey,
                    ),
                    onPressed: widget.exercise.completed ? null : widget.onComplete,
                  ),
                  isReplacing
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.blue,
                          ),
                        )
                      : IconButton(
                          icon: Icon(Icons.swap_horiz, color: widget.exercise.completed ? Colors.grey : Colors.blue),
                          onPressed: widget.exercise.completed
                              ? null
                              : () async {
                                  setState(() {
                                    isReplacing = true;
                                  });
                                  await widget.onChangeExercise();
                                  setState(() {
                                    isReplacing = false;
                                  });
                                },
                        ),
                ],
              ),
            ),
            if (showInstruction && widget.exercise.instruction != null && widget.exercise.instruction!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  widget.exercise.instruction!,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  showInstruction ? Icons.expand_less : Icons.expand_more,
                  color: Colors.black54,
                ),
                onPressed: () {
                  setState(() {
                    showInstruction = !showInstruction;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
