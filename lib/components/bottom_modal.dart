import 'package:flutter/material.dart';

class BottomSlideUpModal extends StatelessWidget {
  final String? title;
  final Widget child;

  const BottomSlideUpModal({Key? key, this.title, required this.child})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (title != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title!,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Padding(padding: const EdgeInsets.all(16.0), child: child),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

void showBottomSlideUpModal(
  BuildContext context, {
  required Widget child,
  String? title,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled:
        true,
    backgroundColor:
        Colors.transparent,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ), // Evita que o teclado cubra o modal
        child: BottomSlideUpModal(title: title, child: child),
      );
    },
  );
}
