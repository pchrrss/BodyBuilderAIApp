import 'package:flutter/material.dart';
import 'package:bodybuilderaiapp/model/exercise.dart';
import 'package:logger/web.dart';

class ExerciseListItem extends StatefulWidget {
  final Exercise exercise;
  final bool isLiked;
  final VoidCallback onComplete;
  final Future<void> Function() onChangeExercise;
  final Future<void> Function() onLikeExercise;
  final Future<void> Function() onUnlikeExercise;

  const ExerciseListItem({
    super.key,
    required this.exercise,
    required this.onComplete,
    required this.onChangeExercise,
    required this.onLikeExercise,
    required this.onUnlikeExercise,
    required this.isLiked,
  });

  @override
  State<ExerciseListItem> createState() => _ExerciseListItemState();
}

class _ExerciseListItemState extends State<ExerciseListItem> {
  var logger = Logger();
  bool isReplacing = false;
  bool showInstruction = false;
  bool isImageToggled = false;

  @override
  Widget build(BuildContext context) {
    final textStyle = widget.exercise.completed
        ? const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          )
        : const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          );

    return GestureDetector(
      onTap: () {
        setState(() {
          showInstruction = !showInstruction;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildExerciseImage(),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildExerciseDetails(textStyle),
                ),
                _buildActionButtons(),
              ],
            ),
            if (widget.exercise.instruction != null && widget.exercise.instruction!.isNotEmpty) _buildInstructionSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseImage() {
    String assetPath = widget.exercise.getExerciseImageAsset(isImageToggled);
    logger.d(assetPath);

    return GestureDetector(
      onTap: () {
        setState(() {
          isImageToggled = !isImageToggled;
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          assetPath,
          height: 100,
          width: 100,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 100,
              width: 100,
              color: Colors.grey[300],
              child: const Icon(
                Icons.image_not_supported,
                color: Colors.grey,
                size: 50,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildExerciseDetails(TextStyle textStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.exercise.name, style: textStyle),
        const SizedBox(height: 4),
        Text(
          'Sets: ${widget.exercise.sets}',
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 4),
        Text(
          'Reps: ${widget.exercise.reps}',
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          height: 34,
          child: IconButton(
            icon: Icon(
              widget.isLiked ? Icons.favorite : Icons.favorite_border,
              color: widget.isLiked ? Colors.red : Colors.grey,
            ),
            onPressed: () async {
              if (widget.isLiked) {
                widget.onUnlikeExercise();
              } else {
                widget.onLikeExercise();
              }
            },
          ),
        ),
        SizedBox(
          height: 34,
          child: IconButton(
            icon: Icon(
              Icons.check_circle,
              color: widget.exercise.completed ? Colors.green : Colors.grey,
            ),
            onPressed: widget.exercise.completed ? null : widget.onComplete,
          ),
        ),
        SizedBox(
          height: 34,
          child: isReplacing
              ? const Row(children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.blue,
                    ),
                  ),
                ])
              : IconButton(
                  icon: Icon(
                    Icons.swap_horiz,
                    color: widget.exercise.completed ? Colors.grey : Colors.blue,
                  ),
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
        ),
      ],
    );
  }

  Widget _buildInstructionSection() {
    return Column(
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: showInstruction
              ? Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    widget.exercise.instruction!,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
