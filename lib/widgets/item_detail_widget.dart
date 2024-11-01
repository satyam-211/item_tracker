import 'package:flutter/material.dart';
import 'package:item_tracker/models/item.dart';

class ItemDetailWidget extends StatefulWidget {
  final Item item;

  const ItemDetailWidget({super.key, required this.item});

  @override
  State<ItemDetailWidget> createState() => _ItemDetailWidgetState();
}

class _ItemDetailWidgetState extends State<ItemDetailWidget> {
  final GlobalKey _key = GlobalKey();
  Color bgColor = Colors.white;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  void _afterLayout(Duration timeStamp) {
    final RenderBox? renderBox =
        _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero);
      double screenHeight = MediaQuery.of(context).size.height;
      double yPos = position.dy;
      double normalizedY = (yPos / screenHeight).clamp(0.0, 1.0);
      setState(() {
        bgColor = Color.lerp(Colors.blue[100], Colors.green[100], normalizedY)!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      key: _key,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(8.0),
      ),
      duration: const Duration(seconds: 1),
      child: LayoutBuilder(
        builder: (context, constraints) => constraints.maxWidth > 600
            ? Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.item.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(widget.item.description),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(widget.item.description),
                ],
              ),
      ),
    );
  }
}
