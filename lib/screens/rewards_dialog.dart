import 'package:flutter/material.dart';

class RewardsDialog extends StatefulWidget {
  final int userPoints;

  const RewardsDialog({required this.userPoints, Key? key}) : super(key: key);

  @override
  State<RewardsDialog> createState() => RewardsDialogState();
}

class RewardsDialogState extends State<RewardsDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // Repeat the spinning animation
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller to avoid errors
    super.dispose();
  }

  final List<Map<String, String>> rewards = [
    {'points': '100', 'reward': '10% discount'},
    {'points': '200', 'reward': '15% discount'},
    {'points': '300', 'reward': '20% discount'},
    {'points': '400', 'reward': '25% discount'},
    {'points': '500', 'reward': '30% discount'},
    {'points': '700', 'reward': '35% discount'},
    {'points': '1000', 'reward': '70% discount (MAX)'},
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Spinning Coin Animation
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * 3.1416, // Full rotation
                    child: Image.asset(
                      'assets/images/coin.png', // Path to spinning coin image
                      width: 50,
                      height: 50,
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
              // Animated Counter for Points
              TweenAnimationBuilder<int>(
                tween: IntTween(begin: 0, end: widget.userPoints),
                duration: const Duration(seconds: 3),
                builder: (context, value, child) {
                  return Text(
                    '$value pts',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Keep it up! Only ${500 - widget.userPoints} pts to your next reward!',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Row(
          children: [
            // Vertical Progress Bar Section
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(rewards.length, (index) {
                  final int rewardPoints = int.parse(rewards[index]['points']!);
                  final bool achieved = widget.userPoints >= rewardPoints;
                  return Column(
                    children: [
                      Container(
                        height: 40,
                        width: 10,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: achieved
                              ? Colors.green.shade600
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Text(
                        '${rewardPoints} pts',
                        style: TextStyle(
                          fontSize: 12,
                          color: achieved
                              ? const Color.fromARGB(255, 14, 4, 55)
                              : Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
            const SizedBox(width: 16),
            // Rewards List
            Expanded(
              flex: 4,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: rewards.length,
                itemBuilder: (context, index) {
                  final reward = rewards[index];
                  final bool achieved =
                      widget.userPoints >= int.parse(reward['points']!);
                  return ListTile(
                    leading: Icon(
                      achieved ? Icons.check_circle : Icons.circle_outlined,
                      color: achieved ? Colors.green.shade600 : Colors.grey,
                    ),
                    title: Text(
                      '${reward['points']} pts',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: achieved ? Colors.green.shade600 : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      reward['reward']!,
                      style: TextStyle(
                        color: achieved
                            ? const Color.fromARGB(255, 14, 4, 55)
                            : Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFC52127),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
