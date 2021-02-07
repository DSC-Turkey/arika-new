import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Hakkımızda",
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            "Modern hayatı şekillendiren yeni keşiflerin öncülüğünü üstlenerek daha iyi bir yaşamın standartlarını oluşturmak için çalışan Doğuş Grubu, 1951 yılında kurulmuştur. Müşterilerinin yanı sıra çalışanları, iş ortakları ve hatta rakipleri için bir tutkuya dönüşecek, sınıfının en iyisi yaşam tarzı markalarını bünyesinde barındıran Doğuş, çalıştığı alanlarda küresel bir oyuncu olma hedefiyle çalışmalarına devam etmektedir.\n\n\n Otomotiv; inşaat; medya; yeme-içme, turizm & perakende; gayrimenkul ve enerji olmak üzere altı ana sektörde faaliyet gösteren Doğuş Grubu ayrıca, mevcut hizmet verdiği sektörlerin yanı sıra teknoloji, spor ve eğlence alanındaki yeni yatırımlarıyla da büyümesini sürdürmektedir. Grup 300’ün üzerindeki şirketi ve 18 bini aşkın çalışanıyla müşterilerine üstün teknoloji, yüksek marka kalitesi ve dinamik bir insan kaynağı ile hizmet vermektedir.",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
