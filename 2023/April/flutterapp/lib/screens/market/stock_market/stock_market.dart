import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/models/quote_realtime.dart';
import 'package:flutterapp/services/quote_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;


import 'child_widget.dart';

class StockMarketScreen extends StatefulWidget {
  const StockMarketScreen({Key? key}) : super(key: key);

  @override
  _StockMarketScreenState createState() => _StockMarketScreenState();
}

class _StockMarketScreenState extends State<StockMarketScreen> {
  List<QuoteRealtime> data = [
    // Add more fake data here
  ];
  OverlayEntry? _overlayEntry;
  bool _isPopupVisible = false;

  int page = 1;
  int pageSize = 10;
  String sector = "";
  String industry = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final message = {
      "type": "subscribe",
      "page": page,
      "pageSize": pageSize,
      "sector": sector,
      "industry": industry,
    };
    final messageJson = json.encode(message);
    var channel = WebSocketChannel.connect(Uri.parse(QuoteService.wsUrlGetQuotes));
    channel.sink.add(messageJson);
    channel.stream.listen((data) {
      debugPrint('haha');
      final parsedData = json.decode(data);
      // if (onData != null) {
      //   onData(parsedData);
      // }

      // _quotes = List<Map<String, dynamic>>.from(data)
      //     .map((quote) => {
      //   'symbol': quote['symbol'],
      //   'company_name': quote['company_name'],
      //   'price': quote['price'],
      // })
      //     .toList();
      //this.data = data;

      //channel.sink.close(status.goingAway);
    });
  }
  @override
  void dispose() {
    super.dispose();
  }

  void _togglePopup() {
    if (_isPopupVisible) {
      _overlayEntry?.remove();
    } else {
      _overlayEntry = _createPopupOverlay();
      Overlay.of(context).insert(_overlayEntry!);
    }
    _isPopupVisible = !_isPopupVisible;
  }
  OverlayEntry _createPopupOverlay() {
    return OverlayEntry(
      builder: (BuildContext context) => GestureDetector(
        onTap: () {
          _togglePopup();
        },
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: GestureDetector(
              onTap: () {}, // Prevent tap from closing the popup
              child: Opacity(
                opacity: 0.9,
                child: ChildWidget(
                  togglePopup: _togglePopup,
                  data: [
                    'Software & Services',
                    'Technology Hardware & Equipment',
                    'Semiconductors & Semiconductor Equipment',
                    'Pharmaceuticals',
                    'Biotechnology',
                    'Medical Devices & Supplies',
                    'Banking',
                    'Insurance',
                    'Asset Management & Custody Banks',
                    'Automobiles & Components',
                    'Consumer Durables & Apparel',
                    'Retailing',
                    'Food & Staples Retailing',
                    'Household & Personal Products',
                    'Oil, Gas & Consumable Fuels',
                    'Energy Equipment & Services',
                    'Electric Utilities',
                    'Metals & Mining',
                    'Chemicals',
                    'Wireless Telecommunication Services',
                  ],
                  onPressItem: (selectedItem) {
                    debugPrint(selectedItem);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child: Row(
              children: [
                SizedBox(width: 10,),
                Expanded(child: Text('This is Stock Market'),),
                IconButton(
                  icon: const Icon(Icons.arrow_drop_down), onPressed: () {  },
                )
              ],
            ),
          ),
          onTap: () {
            _togglePopup();
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Symbol')),
                  DataColumn(label: Text('Price')),
                  DataColumn(label: Text('+/-')),
                  DataColumn(label: Text('+/- %')),
                  DataColumn(label: Text('TotalVol')),
                ],
                rows: data.map((item) {
                  return DataRow(cells: [
                    DataCell(Text(item.symbol)),
                    DataCell(Text('${item.price}')),
                    DataCell(Text('${item.change}')),
                    DataCell(Text('${item.percentChange}')),
                    DataCell(Text('${item.volume}')),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Table Footer Text',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}