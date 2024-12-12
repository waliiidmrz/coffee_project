import 'package:coffee_project/screens/ProductDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../models/product.dart';

class Item extends StatefulWidget {
  final Product product;

  const Item({
    super.key,
    required this.product,
  });

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 239,
        width: 150,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withOpacity(0.4), // Shadow color with opacity
                blurRadius: 8, // How blurry the shadow is
                offset: const Offset(2, 10), // Position of the shadow
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 13,
            right: 13,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none, // Ensure the shadow is not clipped

                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Container(
                      width: 150,
                      height: 132,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.25), // Shadow color with opacity
                            blurRadius: 8, // Blur intensity
                            offset: const Offset(2, 4), // Shadow position
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            8), // Match the container's border radius
                        child: Image.asset(
                          widget.product.imageUrl,
                          fit: BoxFit.cover,
                          width: 150,
                          height: 132,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 8,
                    child: Container(
                      width: 51,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.transparent.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Iconsax.star1,
                            color: Color(0xfffFBBE21),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            "4.9",
                            style: GoogleFonts.sora(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(
                        product: widget.product,
                      ),
                    ),
                  );
                },
                child: Text(
                  widget.product.name,
                  style: GoogleFonts.sora(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff2F2D2C),
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'with Chocolate',
                style: GoogleFonts.sora(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff9B9B9B),
                ),
              ),
              const SizedBox(
                height: 11,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${widget.product.price.toStringAsFixed(2)}",
                    style: GoogleFonts.sora(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff2F4B4E),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(
                            product: widget.product,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 200, 41, 41),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
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
  }
}
