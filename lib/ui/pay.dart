import 'package:arika/config/base/close_keyboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

class Pay extends StatefulWidget {
  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int ay;
  int yil;
  String tc;
  List<Map<String, dynamic>> map1 = [];

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: KlavyeninKapanmasi(
        widget: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 0,
              title: Text(
                "Güvenli Bağış",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                //margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                width: size.width,
                height: size.height - size.height * 0.11,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        cardPhoto(),
                        cardDetails(),
                      ],
                    ),
                    payButton(size, context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded cardDetails() {
    return Expanded(
      child: Column(
        children: [
          CreditCardForm(
            formKey: formKey,
            obscureCvv: false,
            obscureNumber: false,
            cardNumberDecoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Kart Numarası',
              hintText: '**** **** **** ****',
            ),
            expiryDateDecoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Son Kullanma Tarihi',
              hintText: 'Ay /Yıl',
            ),
            cvvCodeDecoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Güvenlik Kodu',
              hintText: 'CVC',
            ),
            cardHolderDecoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Kart Üzerindeki İsim',
            ),
            onCreditCardModelChange: onCreditCardModelChange,
          ),
        ],
      ),
    );
  }

  CreditCardWidget cardPhoto() {
    return CreditCardWidget(
      cardBgColor: Color(0xff26406e),
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cardHolderName: cardHolderName,
      cvvCode: cvvCode,
      showBackView: isCvvFocused,
      obscureCardNumber: false,
      obscureCardCvv: false,
    );
  }

  Positioned payButton(Size size, BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        height: size.height * 0.1,
        decoration: BoxDecoration(color: Color(0xfff8f8f8), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ]),
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        width: size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Ödenecek Tutar",
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.01),
                  child: Text(
                    "200.00 TL",
                    style: TextStyle(
                      color: Color(0xff26406e),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                height: size.height * 0.06,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.022),
                decoration: BoxDecoration(
                  color: Color(0xff26406e),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "Ödemeyi Tamamla",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
