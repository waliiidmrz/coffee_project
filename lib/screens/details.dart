import 'package:coffee_project/screens/pass_new_order.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product.dart';
import '../widgets/custom_button.dart';
import '../widgets/coffee_size.dart';

class Detail extends StatefulWidget {
  final Product product;

  const Detail({super.key, required this.product});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  int selectedSize = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildProductImage(),
            SizedBox(height: size.height * 0.020),
            _buildProductInfo(),
            SizedBox(height: size.height * 0.020),
            _buildStaticDetails(size),
            _buildFooter(size),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.chevron_left, color: Color(0xff2F2D2C)),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite_border, color: Color(0xff2F2D2C)),
        ),
      ],
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: 315,
      height: 226,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(widget.product.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.product.name,
            style: const TextStyle(
              fontFamily: 'Csnolan',
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: Color(0xff2F2D2C),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "with Chocolate", // Static detail
            style: GoogleFonts.sora(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xff9B9B9B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaticDetails(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Color(0xffFBBE21)),
                  const SizedBox(width: 5),
                  Text(
                    "4.9", // Static rating
                    style: GoogleFonts.sora(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff2F2D2C),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "(230)", // Static review count
                    style: GoogleFonts.sora(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff9B9B9B),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _iconFeature(Icons.local_drink, size),
                  const SizedBox(width: 10),
                  _iconFeature(Icons.bolt, size),
                ],
              ),
            ],
          ),
          const Divider(color: Color(0xffEAEAEA)),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description',
                style: GoogleFonts.sora(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo..",
                textAlign: TextAlign.justify,
                style: GoogleFonts.sora(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff9B9B9B),
                  height: 1.64,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Size',
            style: GoogleFonts.sora(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CoffeeSize(
                title: 'S',
                index: 0,
                selectedSize: selectedSize,
                onClick: () {
                  setState(() {
                    selectedSize = 0;
                  });
                },
              ),
              CoffeeSize(
                title: 'M',
                index: 1,
                selectedSize: selectedSize,
                onClick: () {
                  setState(() {
                    selectedSize = 1;
                  });
                },
              ),
              CoffeeSize(
                title: 'L',
                index: 2,
                selectedSize: selectedSize,
                onClick: () {
                  setState(() {
                    selectedSize = 2;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFooter(Size size) {
    return Container(
      height: 121,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Price', style: TextStyle(color: Colors.grey)),
                Text(
                  "\$${widget.product.price.toStringAsFixed(2)}",
                  style: GoogleFonts.sora(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffC67C4E),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 217,
            height: 62,
            child: CustomButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PassNewOrderScreen(),
                ),
              ),
              title: 'Buy Now',
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconFeature(IconData icon, Size size) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xffF9F9F9),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: const Color(0xffC67C4E)),
    );
  }
}
