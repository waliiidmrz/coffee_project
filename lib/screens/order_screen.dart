import 'package:BISOU/screens/home_screen.dart';
import 'package:BISOU/widgets/custom_button.dart';
import 'package:BISOU/widgets/gold_membership_container.dart';
import 'package:BISOU/widgets/pay_button.dart';
import 'package:BISOU/widgets/payment_options.dart';
import 'package:BISOU/widgets/payment_summary_card.dart';
import 'package:BISOU/widgets/type_toggle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wheel_picker/wheel_picker.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int selectedType = 0;
  int selectedPickUpOption = 0;
  int selectedTableNumber = 1;
  final List<Map<String, dynamic>> coffeeItems = [
    {
      "name": "Cappuccino",
      "description": "with Chocolate",
      "image": "assets/images/cappucino.jpeg",
      "quantity": 1,
    },
    {
      "name": "Americano",
      "description": "Rich and Smooth",
      "image": "assets/images/americano.jpeg",
      "quantity": 1,
    },
    {
      "name": "Espresso",
      "description": "Strong and Bold",
      "image": "assets/images/express.jpeg",
      "quantity": 1,
    },
    {
      "name": "Latte",
      "description": "Creamy and Mild",
      "image": "assets/images/latte.webp",
      "quantity": 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HomeScreen(),
            ),
          ),
          icon: const Icon(
            Icons.chevron_left,
            color: Color(0xff2F2D2C),
          ),
        ),
        title: Text(
          "Your Order",
          style: GoogleFonts.sora(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xff2F2D2C),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Order Type Toggle
              TypeToggle(
                selectedTab: selectedType,
                onTabChanged: (int newType) {
                  setState(() {
                    selectedType = newType;
                  });
                },
              ),
              SizedBox(height: size.height * 0.03),

              // Order Details Section
              buildOrderDetailsContainer(),
              const SizedBox(height: 20),

              // Coffee Items
              buildCoffeeList(),
              const SizedBox(height: 20),

              // Separator Line
              Container(
                height: 2,
                width: size.width * 0.9,
                color: const Color(0xFFEAEAEA),
              ),
              const SizedBox(height: 20),

              // Gold Membership Section
              AnimatedGoldMembershipContainer(),
              const SizedBox(height: 20),

              // Payment Summary
              PaymentSummaryCard(),
              const SizedBox(height: 20),

              // Payment Options
              PaymentSelector(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  width: 200,
                  height: 40,
                  child: PayButton(title: 'Order', onPressed: () => {}),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOrderDetailsContainer() {
    if (selectedType == 0) {
      // Delivery
      return Container(
        width: 315,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Delivery Address",
              style: GoogleFonts.sora(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 16),
            Text(
              "Ezzahra, Ben Arous",
              style: GoogleFonts.sora(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 8),
            Text(
              "14 Rue Andalouse",
              style: GoogleFonts.sora(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xff808080),
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildActionButton(Icons.location_on, "Edit Address"),
                const SizedBox(width: 8),
                buildActionButton(Icons.note_alt, "Add Note"),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 2,
              decoration: const BoxDecoration(
                color: Color(0xffEAEAEA),
              ),
            ),
          ],
        ),
      );
    } else {
      // Pick-Up
      return Container(
        width: 315,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  "Pick-Up Options",
                  style: GoogleFonts.sora(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPickUpOption = 0;
                    });
                  },
                  child: buildOptionChip("At Café", selectedPickUpOption == 0),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPickUpOption = 1;
                    });
                  },
                  child: buildOptionChip("Pass By", selectedPickUpOption == 1),
                ),
              ],
            ),
            if (selectedPickUpOption == 0) ...[
              Center(child: buildTableNumberPicker()),
            ],
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 2,
              decoration: const BoxDecoration(
                color: Color(0xffEAEAEA),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget buildActionButton(IconData icon, String text) {
    return Container(
      width: 120,
      height: 27,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffDEDEDE)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 14),
          const SizedBox(width: 4),
          Text(
            text,
            style: GoogleFonts.sora(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOptionChip(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFC52127) : Colors.white,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: isSelected ? const Color(0xFFC52127) : const Color(0xffDEDEDE),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Cspercy',
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget buildTableNumberPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              "Table Number :",
              style: GoogleFonts.sora(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "$selectedTableNumber",
              style: GoogleFonts.sora(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xff808080),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 80,
          width: 300,
          child: WheelPicker(
            style: const WheelPickerStyle(
                diameterRatio: 2,
                itemExtent: 27,
                magnification: 50,
                shiftAnimationStyle: WheelShiftAnimationStyle(
                    duration: Duration(seconds: 3),
                    curve: Curves.fastOutSlowIn)),
            itemCount: 20, // Number of tables
            scrollDirection: Axis.horizontal, // Set horizontal scrolling
            onIndexChanged: (index) {
              setState(() {
                selectedTableNumber = index + 1; // Update selected table
              });
            },

            initialIndex: selectedTableNumber - 1, // Set initial table
            builder: (context, index) {
              return Container(
                width: 100, // Increase width for larger circles
                height: 100, // Increase height for larger circles
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selectedTableNumber == index + 1
                      ? const Color(0xFFC52127)
                      : Colors.white,
                  border: Border.all(
                    color: selectedTableNumber == index + 1
                        ? const Color(0xFFC52127)
                        : const Color(0xffDEDEDE),
                  ),
                ),
                child: Text(
                  '${index + 1}',
                  style: GoogleFonts.sora(
                    fontSize: selectedTableNumber == index + 1 ? 20 : 18,
                    fontWeight: FontWeight.bold,
                    color: selectedTableNumber == index + 1
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildCoffeeList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        shrinkWrap: true, // Allows flexible height based on content
        physics:
            const NeverScrollableScrollPhysics(), // Scrolls with the main view
        itemCount: coffeeItems.length,
        itemBuilder: (context, index) {
          final coffee = coffeeItems[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Coffee Image and Info
                    Row(
                      children: [
                        // Coffee Image
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(coffee["image"]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Coffee Name and Description
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              coffee["name"],
                              style: GoogleFonts.sora(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff2F2D2C),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              coffee["description"],
                              style: GoogleFonts.sora(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff9B9B9B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Quantity Controls
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (coffee["quantity"] > 1) coffee["quantity"]--;
                            });
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xffEAEAEA),
                              ),
                            ),
                            child: const Icon(
                              Icons.remove,
                              color: Color(0xffAAADB0),
                              size: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                          child: Text(
                            "${coffee["quantity"]}",
                            key: ValueKey<int>(coffee["quantity"]),
                            style: GoogleFonts.sora(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              coffee["quantity"]++;
                            });
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFFC52127),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
