import 'package:bodybuilderaiapp/model/favorite_exercise.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';

class FavoriteExerciseListItem extends StatefulWidget {
  final FavoriteExercise exercise;
  final Future<void> Function() onLikeExercise;
  final Future<void> Function() onUnlikeExercise;

  const FavoriteExerciseListItem({
    super.key,
    required this.exercise,
    required this.onLikeExercise,
    required this.onUnlikeExercise,
  });

  @override
  State<FavoriteExerciseListItem> createState() => _FavoriteExerciseListItemState();
}

class _FavoriteExerciseListItemState extends State<FavoriteExerciseListItem> {
  var logger = Logger();
  bool showInstruction = false;
  bool isImageToggled = false;
  bool isLiked = true;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
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
                  child: _buildExerciseName(textStyle),
                ),
                _buildLikeButton(),
              ],
            ),
            if (widget.exercise.instruction != null && widget.exercise.instruction!.isNotEmpty)
              _buildInstructionSection(),
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
          height: 80,
          width: 80,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 80,
              width: 80,
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

  Widget _buildExerciseName(TextStyle textStyle) {
    return Text(widget.exercise.name, style: textStyle);
  }

  Widget _buildLikeButton() {
    return IconButton(
      icon: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: isLiked ? Colors.red : Colors.grey,
      ),
      onPressed: () async {
        if (isLiked) {
          await widget.onUnlikeExercise();
        } else {
          await widget.onLikeExercise();
        }
        setState(() {
          isLiked = !isLiked;
        });
      },
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
