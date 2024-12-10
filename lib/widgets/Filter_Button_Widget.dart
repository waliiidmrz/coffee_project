import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final String label;

  const FilterButton({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle filter logic
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(color: Color(0xFFC52127)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        label,
        style: const TextStyle(
            color: Color(0xFFC52127), fontWeight: FontWeight.bold),
      ),
    );
  }
}
