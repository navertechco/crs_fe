// ignore_for_file: unused_field, prefer_final_fields

// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/constants.dart';
import 'package:naver_crs/pages/buycredits/state.dart';
import 'package:naver_crs/pages/buycredits/widgets/index.dart';

import '../controller.dart';

// ignore: must_be_immutable
class BuyCreditsFormWidget extends StatefulWidget {
  const BuyCreditsFormWidget(
      {Key? key,
      required this.formKey,
      required this.state,
      required this.ctrl})
      : super(key: key);

  final GlobalKey<FormState> formKey;
  final BuyCreditsState state;
  final BuyCreditsController ctrl;
  @override
  State<BuyCreditsFormWidget> createState() => _BuyCreditsFormWidgetState();
}

class _BuyCreditsFormWidgetState extends State<BuyCreditsFormWidget> {
  RxInt n = 0.obs;

  String? _reference, _email, _password, _phoneNumber;

  String? _payment, _institution, _bank;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CreditCounterWidget(n: n),
              const SizedBox(height: kDefaultPadding * 3),
            ],
          ),
          Column(
            children: [
              PaymentCatalogueWidget(
                payment: _payment,
              ),
              const SizedBox(height: kDefaultPadding),
            ],
          ),
          Column(
            children: [
              InstitutionCatalogueWidget(institution: _institution),
              const SizedBox(height: kDefaultPadding),
            ],
          ),
          Visibility(
            visible: _institution == "banco",
            child: Column(
              children: [
                BankCatalogueWidget(bank: _bank),
                const SizedBox(height: kDefaultPadding),
              ],
            ),
          ),
          Column(
            children: [
              ReferenceTextFieldWidget(
                reference: _reference,
              ),
              const SizedBox(height: kDefaultPadding),
            ],
          ),
          BuyButtonWidget(formKey: widget.formKey, n: n, ctrl: widget.ctrl),
        ],
      ),
    );
  }
}
