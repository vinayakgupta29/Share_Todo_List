import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../todo.dart';


class GenerateQR extends StatefulWidget {
  const GenerateQR({super.key});

  @override
  _GenerateQRState createState() => _GenerateQRState();
}

class _GenerateQRState extends State<GenerateQR> {
  final ToDo toq = ToDo();
  String? qrData;
  final qrsList = ToDo.todoList();
  @override
  void initState() {
    qrData = toq.todoText;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 500,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QrImage(data: qrData==null? " ": toq.todoText.toString(),),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(8.0),
            ),
          ],
        ),
      ),
    );
  }
}