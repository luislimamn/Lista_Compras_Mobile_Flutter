import 'package:flutter/material.dart';

class BlockButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function()? onPressed;
  final buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.grey[200],
    textStyle: const TextStyle(fontSize: 18),
    padding: const EdgeInsets.all(18),
  );
  BlockButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: buttonStyle,
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }
}
