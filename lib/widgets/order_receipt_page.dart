import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:order_receipt/models/product.dart';
import 'package:order_receipt/commons/commons.dart';
import 'package:order_receipt/models/varian.dart';
import 'package:order_receipt/widgets/not_found.dart';
import 'package:order_receipt/widgets/order_receipt_item_list.dart';
import 'package:order_receipt/widgets/dividers.dart';

class OrderReceiptPage extends StatefulWidget {

  const OrderReceiptPage({super.key, required this.uid});

  final String uid;

  @override
  OrderReceiptPageState createState() => OrderReceiptPageState();
}

class OrderReceiptPageState extends State<OrderReceiptPage> {

  String namaMitra = '';
  String logoMitraUrl = '';
  String alamat = '';
  String tanggal = '';
  // String createdAt = '';
  String noBon = '';
  String namaPelanggan = '';
  String namaKasir = '';
  String jenisOrder = '';
  List daftarProduk = [];
  String total = '';
  String tax = '';
  String subtotal = '';
  String serviceCharge = '';
  String discount = '';
  String additionalfee = '';

  Future<void> setupInitialData() async {
    final response = await http.get(Uri.parse('$beUrl/api/public/order/${widget.uid}'));
    print("ini masuk");
    if (response.statusCode == 200 && widget.uid.isNotEmpty) {
      print('masuk');
      var bodyResponse = json.decode(response.body);
      final data = bodyResponse['data'];
      setState(() {
        namaMitra = data['mitra']['nama'];
        logoMitraUrl = data['mitra']['logo_url'] ?? '';
        alamat = data['cabang'];
        tanggal = '${formatDay(data['tanggal'])}, ${formatDate(data['tanggal'])}';
        // createdAt = formatDate(data['created_at']);
        noBon = data['no_transaksi'];
        namaPelanggan = data['nama_pelanggan'];
        namaKasir = data['nama_pembuat'];
        jenisOrder = data['sales_channel'];
        for (var produk in data['detail']) {
          var varianList = [];
          for (var varian in produk['varian']) {
            varianList.add(Varian(
                nama: varian['nama'],
                harga: formatPrice(varian['harga'])
            ));
          }
          daftarProduk.add(Product(
              name: produk['menu'] ?? '',
              qty: stringMatchRegEx00(produk['qty']),
              price: formatPrice(produk['harga']),
              varian: varianList
          ));
        }
        subtotal = formatPrice(data['subtotal']);
        discount = formatPrice(data['discount']);
        additionalfee = formatPrice(data['additional_fee']);
        serviceCharge = formatPrice(data['service_charge']);
        tax = formatPrice(data['tax']);
        total = formatPrice(data['total_harga_jual']);

      });
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NotFound()));
    }
  }

  @override
  void initState() {
    setupInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]!)
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  logoMitraUrl != '' ?
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        width: 50.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(image: NetworkImage(logoMitraUrl), fit: BoxFit.cover)
                                        ),
                                      ),
                                    ) : const SizedBox(),
                                  logoMitraUrl != '' ? const SizedBox(width: 15) : const SizedBox(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(namaMitra),
                                      const SizedBox(height: 5),
                                      Text(
                                        tanggal,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                  ],
                                )
                              ])
                            ],
                          )
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey[100],
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                        ),
                        child: Column(
                          children: [
                            OrderReceiptItemList(title: 'Tanggal', value: tanggal),
                            OrderReceiptItemList(title: 'Nomor Bon', value: noBon),
                            OrderReceiptItemList(title: 'Nama Pelanggan', value: namaPelanggan??'-'),
                            OrderReceiptItemList(title: 'Nama Kasir', value: namaKasir),
                            const DottedDivider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                    child: Text(jenisOrder)
                                ),
                              ],
                            ),
                            const DottedDivider(),
                            Column(
                              children: daftarProduk.map((produk) => Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Text(produk.qty + 'x')
                                          ),
                                          Expanded(
                                              flex: 5,
                                              child: Text(produk.name)
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(produk.price),
                                              )
                                          ),
                                        ],
                                      )
                                  ),
                                  produk.varian.length > 0 ? Column(
                                    children: <Widget>[
                                      for (int i = 0; i < produk.varian.length; i++)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Expanded(
                                                flex: 1,
                                                child: SizedBox(width: 20.0),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Text(
                                                    produk.varian[i].nama,
                                                )
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                      produk.varian[i].harga,
                                                  ),
                                                )
                                              ),
                                            ],
                                          )
                                      ),
                                    ]
                                  ) : const SizedBox()
                                ]
                              )).toList(),
                            ),
                            const NormalDivider(),
                            OrderReceiptItemList(title: 'Subtotal', value: subtotal),
                            discount != 'Rp 0' ? OrderReceiptItemList(title: 'Diskon', value: '-$discount') : const SizedBox(),
                            tax != 'Rp 0' ? OrderReceiptItemList(title: 'PB (10%)', value: tax) : const SizedBox(),
                            serviceCharge != 'Rp 0' ? OrderReceiptItemList(title: 'Service Charge', value: serviceCharge) : const SizedBox(),
                            additionalfee != 'Rp 0' ? OrderReceiptItemList(title: 'Biaya Tambahan', value: additionalfee) : const SizedBox(),
                            const NormalDivider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Total: '),
                                  Text(total),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Kunjungi Kami Di',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              alamat,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.cyan,
                                  radius: 15,
                                  child: FaIcon(FontAwesomeIcons.twitter, color: Colors.white, size: 15),
                                ),
                                const SizedBox(width: 5),
                                const CircleAvatar(
                                  backgroundColor: Colors.deepPurpleAccent,
                                  radius: 15,
                                  child: FaIcon(FontAwesomeIcons.instagram, color: Colors.white, size: 15),
                                ),
                                const SizedBox(width: 5),
                                CircleAvatar(
                                  backgroundColor: Colors.indigo[700],
                                  radius: 15,
                                  child: const FaIcon(FontAwesomeIcons.facebookF, color: Colors.white, size: 15),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}