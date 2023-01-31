import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kisiler_uygulamasi/main.dart';

class KisiKayitSayfa extends StatefulWidget {
  const KisiKayitSayfa({super.key});

  @override
  State<KisiKayitSayfa> createState() => _KisiKayitSayfaState();
}

class _KisiKayitSayfaState extends State<KisiKayitSayfa> {
  var tfKisiAdi = TextEditingController();
  var tfKisiTel = TextEditingController();

  Future<void> kayit(String kisi_ad, String kisi_tel) async {
    print("$kisi_ad - $kisi_tel kayıt edildi");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kişi Kayıt"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextField(
                controller: tfKisiAdi,
                decoration: InputDecoration(hintText: "Kişi Ad"),
              ),
              TextField(
                controller: tfKisiTel,
                decoration: InputDecoration(hintText: "Kişi Tel"),
              ),
            ],
          ),
        ),
      ),
    );
    floatingActionButton:
    FloatingActionButton.extended(
      onPressed: () {
        kayit(tfKisiAdi.text, tfKisiTel.text);
      },
      tooltip: 'Kişi Kayıt',
      icon: const Icon(Icons.save),
      label: Text("Kaydet"),
    );
  }
}
