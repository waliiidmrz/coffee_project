import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryItem extends StatefulWidget {
  final int index;
  final String title;
  final Function() onClick;
  final int selectedCategory;

  const CategoryItem(
      {super.key,
      required this.index,
      required this.title,
      required this.onClick,
      required this.selectedCategory});

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onClick(),
      child: Container(
        width: 100,
        height: 20,
        margin: const EdgeInsets.only(
          right: 8,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.index == widget.selectedCategory
              ? const Color.fromARGB(255, 200, 41, 41)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 201, 182, 182).withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
            ),
          ],
        ),
        child: Text(
          widget.title,
          style: GoogleFonts.sora(
            color: widget.index == widget.selectedCategory
                ? Colors.white
                : Colors.black,
            fontSize: 15,
            fontWeight: widget.index == widget.selectedCategory
                ? FontWeight.w700
                : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
