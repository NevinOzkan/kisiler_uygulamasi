import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kisiler_uygulamasi/KisiDetaySayfa.dart';
import 'package:kisiler_uygulamasi/KisiKayitSayfa.dart';
import 'package:kisiler_uygulamasi/Kisiler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyoMu = false;
  String aramaKelimesi = "";

  Future<List<Kisiler>> tumKisileriGoster() async {
    var kisilerListesi = <Kisiler>[];

    var k1 = Kisiler(1, "Ahmet", "999999999");
    var k2 = Kisiler(2, "Mehmet", "333333333");
    var k3 = Kisiler(3, "Zeynep", "111111111");

    kisilerListesi.add(k1);
    kisilerListesi.add(k2);
    kisilerListesi.add(k3);

    return kisilerListesi;
  }

  Future<void> sil(int kisi_id) async {
    print("$kisi_id silindi");
    setState(() {});
  }

  Future<bool> uygulamayiKapat() async {
    await exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            uygulamayiKapat();
          },
        ),
        title: aramaYapiliyoMu
            ? TextField(
                decoration:
                    InputDecoration(hintText: "Arama için birşey yazın."),
                onChanged: (aramaSonucu) {
                  print("Arama sonucu : $aramaSonucu");
                  setState(() {
                    aramaKelimesi = aramaSonucu;
                  });
                },
              )
            : Text("Kişiler Uygulaması"),
        actions: [
          aramaYapiliyoMu
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      aramaYapiliyoMu = false;
                      aramaKelimesi = "";
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      aramaYapiliyoMu = true;
                    });
                  },
                ),
        ],
      ),
      body: WillPopScope(
        onWillPop: uygulamayiKapat,
        child: FutureBuilder<List<Kisiler>>(
          future: tumKisileriGoster(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var kisilerListesi = snapshot.data;
              return ListView.builder(
                itemCount: kisilerListesi!.length,
                itemBuilder: (context, index) {
                  var kisi = kisilerListesi[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KisiDetaySayfa(
                              kisi: kisi,
                            ),
                          ));
                    },
                    child: Card(
                        child: SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            kisi.kisi_ad,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(kisi.kisi_tel),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              sil(kisi.kisi_id);
                            },
                          )
                        ],
                      ),
                    )),
                  );
                },
              );
            } else {
              return Center();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KisiKayitSayfa(),
              ));
        },
        tooltip: 'Kişi Ekle',
        child: const Icon(Icons.add),
      ),
    );
  }
}
