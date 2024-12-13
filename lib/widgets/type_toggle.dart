import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TypeToggle extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTabChanged;

  const TypeToggle({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 315,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xffF2F2F2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => onTabChanged(0),
            child: Container(
              width: 153.5,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    selectedTab == 0 ? const Color(0xffC67C4E) : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Delivery",
                style: GoogleFonts.sora(
                  color: selectedTab == 0 ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onTabChanged(1),
            child: Container(
              width: 153.5,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    selectedTab == 1 ? const Color(0xffC67C4E) : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Pick Up",
                style: GoogleFonts.sora(
                  color: selectedTab == 1 ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
