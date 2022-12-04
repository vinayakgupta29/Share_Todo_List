import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popup_card/popup_card.dart';
import 'package:to_do_list/todo.dart';
import '../screen/GenerateQr.dart';



class PopUp extends StatelessWidget {
  const PopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PopupItemLauncher(
        tag: 'test',
        popUp: PopUpItem(
          padding: const EdgeInsets.all(8),
          // Padding inside of the card
          color: Colors.white,
          // Color of the card
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          // Shape of the card
          elevation: 2,
          // Elevation of the card
          tag: 'test',
          // MUST BE THE SAME AS IN `PopupItemLauncher`
          child: const PopUpItemBody(), // Your custom child widget.
        ),
        child: Material(
          color: Colors.white,
          elevation: 2,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: const Icon(
            Icons.share,
            size: 56,
          ),
        ),
      ),
    );
  }
}
class PopUpItemBody extends StatelessWidget {
  const PopUpItemBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GenerateQR();
  }
}