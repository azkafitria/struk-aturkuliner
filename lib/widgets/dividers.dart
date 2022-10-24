import 'package:flutter/material.dart';

class DottedDivider extends StatelessWidget {
  const DottedDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(100~/0.75, (index) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
          child: Container(
              color: index % 2 == 0 ? Colors.transparent : Colors.grey[200],
              height: 1
          ),
        ),
      )),
    );
  }
}

class NormalDivider extends StatelessWidget {
  const NormalDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Divider(
        thickness: 0.5,
        endIndent: 0,
        color: Colors.grey[200],
      ),
    );
  }
}