import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bumn_eid/irwan_dev/padi/resources/const.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_dropdown_one.dart';

class ItemFilter extends StatelessWidget {
  final String title;
  final IconData icon;

  const ItemFilter({this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        _filterModalBottomSheet(context);
      },
      child: new Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        margin: const EdgeInsets.only(right: 5),
        decoration: new BoxDecoration(
            color: colorSecondary, borderRadius: BorderRadius.circular(25)),
        child: new Row(
          children: [
            new Icon(
              icon,
              size: 15,
            ),
            new Text(title),
          ],
        ),
      ),
    );
  }
}

void _filterModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    context: context,
    builder: (BuildContext context) {
      return new SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(18.0),
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0))),
          child: new Column(
            children: [
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Text(
                    "Filter Data",
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  new OutlineButton(
                    onPressed: () {},
                    child: new Text(
                      "Reset",
                      style: new TextStyle(
                        color: secondaryColor,
                      ),
                    ),
                    borderSide:
                        new BorderSide(color: secondaryColor, width: 2.0),
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: secondaryColor),
                    ),
                  ),
                ],
              ),
              new SizedBox(
                height: 10.0,
              ),
              new Row(
                children: [
                  new Icon(
                    Icons.check_circle_outline,
                    color: Colors.black,
                  ),
                  new Text(
                    "Level UMKM",
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                    ),
                  ),
                ],
              ),
              ItemDropdownOne(
                listItem: ["Semua Level UMKM", "Mikro", "Kecil", "Menengah"],
                title: "Level UMKM",
                isExpanded: true,
              ),
              new SizedBox(
                height: 10.0,
              ),
              new Row(
                children: [
                  new Icon(
                    Icons.check_circle_outline,
                    color: Colors.black,
                  ),
                  new Text(
                    "Provinsi",
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                    ),
                  ),
                ],
              ),
              ItemDropdownOne(
                listItem: ["Prov 1", "Prov 2", "Prov 3", "Prov 4"],
                title: "Provinsi",
                isExpanded: true,
              ),
              new SizedBox(
                height: 10.0,
              ),
              new Row(
                children: [
                  new Icon(
                    Icons.check_circle_outline,
                    color: Colors.black,
                  ),
                  new Text(
                    "Kategori Project",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 10.0),
                  ),
                ],
              ),
              ItemDropdownOne(
                listItem: [
                  "Semua Kategori",
                  "Material Transaksi",
                  "Jasa Kontruksi & Renovasi",
                  "Jasa Adversting"
                ],
                title: "Kategori Project",
                isExpanded: true,
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Column(
                    children: [
                      new Row(
                        children: [
                          new Icon(
                            Icons.check_circle_outline,
                            color: Colors.black,
                          ),
                          new Text(
                            "Kategori Project",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10.0),
                          ),
                        ],
                      ),
                      ItemDropdownOne(
                        listItem: [
                          "Semua Kategori",
                          "Material Transaksi",
                          "Jasa Kontruksi & Renovasi",
                          "Jasa Adversting"
                        ],
                        title: "Kategori Project",
                        isExpanded: false,
                      ),
                    ],
                  ),
                  new Column(
                    children: [
                      new Row(
                        children: [
                          new Icon(
                            Icons.check_circle_outline,
                            color: Colors.black,
                          ),
                          new Text(
                            "Kategori Project",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10.0),
                          ),
                        ],
                      ),
                      ItemDropdownOne(
                        listItem: [
                          "Semua Kategori",
                          "Material Transaksi",
                          "Jasa Kontruksi & Renovasi",
                          "Jasa Adversting"
                        ],
                        title: "Kategori Project",
                        isExpanded: false,
                      ),
                    ],
                  )
                ],
              ),
              new Row(
                children: [
                  new Icon(
                    Icons.check_circle_outline,
                    color: Colors.black,
                  ),
                  new Text(
                    "Cluster",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 10.0),
                  ),
                ],
              ),
              ItemDropdownOne(
                listItem: [
                  "Semua Cluster",
                  "Industri Pertahanan, Manufaktur, dan Industri Lainnya",
                  "Industri Pupuk dan Pangan",
                  "Industri Energi dan Migas",
                  "Perkebunan Dan Kehutanan",
                  "Industri Farmasi",
                  ""
                ],
                title: "Cluster",
                isExpanded: true,
              ),
              new SizedBox(
                width: double.infinity,
                child: new MaterialButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0),
                  ),
                  color: secondaryColor,
                  child: new Text(
                    "Tampilkan",
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
