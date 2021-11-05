import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_trivia/common/constants.dart';
import 'package:naver_trivia/common/index.dart';

// ignore: must_be_immutable
class CreditCounterWidget extends StatelessWidget {
  CreditCounterWidget({Key? key, required this.n}) : super(key: key);

  RxInt n;
  var session = getContext('session');

  void add() {
    n++;
    setContext('n', n);
    print(getContext('n'));
  }

  void minus() {
    // ignore: unrelated_type_equality_checks
    if (n != 0) n--;
    setContext('n', n);
    print(getContext('n'));
  }

  @override
  Widget build(BuildContext context) {
    int? credits = session != null ? int.parse(session['credits']) : 0;
    return Column(
      children: [
        Text("Tu crédito actual es: $credits", style: TextStyle(fontSize: 20)),
        const SizedBox(height: kDefaultPadding * 3),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                heroTag: "add",
                onPressed: add,
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
              ),
              Obx(() {
                return Text('$n', style: const TextStyle(fontSize: 60.0));
              }),
              FloatingActionButton(
                heroTag: "minus",
                onPressed: minus,
                child: const Icon(Icons.remove, color: Colors.black),
                backgroundColor: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
