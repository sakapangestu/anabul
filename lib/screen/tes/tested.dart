import 'package:flutter/material.dart';

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        if (index % 3 == 0) {
          // Jika indeks adalah kelipatan 3, buat baris baru
          return Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 50,
                  color: Colors.blue,
                  child: Center(
                    child: Text((index + 1).toString()),
                  ),
                ),
              ),
            ],
          );
        } else {
          // Selain itu, tampilkan dalam kolom
          return Expanded(
            child: Container(
              height: 50,
              color: Colors.blue,
              child: Center(
                child: Text((index + 1).toString()),
              ),
            ),
          );
        }
      },
    );
  }
}
