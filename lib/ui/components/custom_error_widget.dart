import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;
  final String customText;

  CustomErrorWidget({@required this.onRetry, this.customText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              customText ??
                  "Terjadi kesalahan ketika mengambil data. Silakan cek koneksi internet Anda.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: RaisedButton(
              onPressed: onRetry,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text("COBA LAGI"),
            ),
          )
        ],
      ),
    );
  }
}
