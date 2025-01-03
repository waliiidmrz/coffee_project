import 'package:BISOU/providers/providercart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../widgets/custom_button.dart';
import '../widgets/coffee_size.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int selectedSize = 1;
  int quantity = 1;
  String selectedOption = 'Caramel';

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
            _buildStaticDetails(),
            _buildOptionsAndSize(),
            _buildQuantitySelector(),
            _buildFooter(context),
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
          icon: const Icon(Icons.chevron_left, color: Colors.black),
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
          image: AssetImage(widget.product.imageUrl!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.product.name!,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "\$${widget.product.price!.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaticDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        "Description of the product goes here. It could include ingredients, flavors, and other relevant information.",
        style: GoogleFonts.sora(fontSize: 14, color: Colors.grey),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildOptionsAndSize() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Options",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildOptionButton('Caramel'),
              _buildOptionButton('Chocolate'),
              _buildOptionButton('Vanilla'),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Size",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
        ],
      ),
    );
  }

  Widget _buildOptionButton(String option) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = option;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selectedOption == option ? Colors.red : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          option,
          style: TextStyle(
            color: selectedOption == option ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Quantity",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    if (quantity > 1) quantity--;
                  });
                },
              ),
              Text(quantity.toString()),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    quantity++;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            context.read<CartProvider>().addToCart(
                  widget.product,
                  quantity,
                  selectedSize == 0
                      ? 'S'
                      : selectedSize == 1
                          ? 'M'
                          : 'L',
                  selectedOption,
                );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("${widget.product.name} added to cart!")),
            );
            Navigator.pop(context);
          },
          child: const Text("Add to Cart"),
        ),
      ),
    );
  }
}
