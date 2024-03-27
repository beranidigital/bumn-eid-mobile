import 'package:bumn_eid/core/models/business_portfolio/general_company.dart';
import 'package:bumn_eid/core/models/legal/legal_item.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/sort_item.dart';
import 'package:flutter/material.dart';

class BaseFilter extends StatefulWidget {
  final List<GeneralCompany> companiesList;
  final List<LegalItem> caseList;
  final Function(String) onWamenChanged;
  final Function(String) onKelasChanged;
  final Function(String) onClusterChanged;
  final List<String> statusPegawai;
  final Function(String) onStatusPegawaiChanged;
  final List<String> tingkatPendidikan;
  final Function(String) onTingkatPendidikanChanged;
  final List<String> tingkatUmur;
  final Function(String) onTingkatUmurChanged;
  final List<String> agama;
  final Function(String) onAgamaChanged;

  BaseFilter({
    this.companiesList,
    this.caseList,
    this.onWamenChanged,
    this.onKelasChanged,
    this.onClusterChanged,
    this.statusPegawai,
    this.onStatusPegawaiChanged,
    this.tingkatPendidikan,
    this.onTingkatPendidikanChanged,
    this.tingkatUmur,
    this.onTingkatUmurChanged,
    this.agama,
    this.onAgamaChanged,
  });

  @override
  _BaseFilterState createState() => _BaseFilterState();
}

class _BaseFilterState extends State<BaseFilter> {
  String currentWamen;
  String currentKelas;
  String currentCluster;
  String currentStatusPegawai;
  String currentTingkatPendidikan;
  String currentTingkatUmur;
  String currentAgama;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        List<String> clusterList = [];
        if (widget.companiesList != null) {
          widget.companiesList.forEach((element) {
            if (!clusterList.contains(element.getCluster())) {
              clusterList.add(element.getCluster());
            }
          });
        } else if (widget.caseList != null) {
          widget.caseList.forEach((element) {
            if (!clusterList.contains(element.cluster_bumn)) {
              clusterList.add(element.cluster_bumn);
            }
          });
        }
        showBaseFilterDialog(
            context: context,
            wamen: currentWamen,
            kelas: currentKelas,
            cluster: currentCluster,
            clusterList: clusterList,
            onClusterChanged: widget.onClusterChanged == null
                ? null
                : (a) {
                    setState(() {
                      this.currentCluster = a;
                    });
                    widget.onClusterChanged(a);
                  },
            onWamenChanged: widget.onWamenChanged == null
                ? null
                : (a) {
                    setState(() {
                      this.currentWamen = a;
                    });
                    widget.onWamenChanged(a);
                  },
            onKelasChanged: widget.onKelasChanged == null
                ? null
                : (a) {
                    setState(() {
                      this.currentKelas = a;
                    });
                    widget.onKelasChanged(a);
                  },
            onTingkatPendidikanChanged:
                widget.onTingkatPendidikanChanged == null
                    ? null
                    : (a) {
                        setState(() {
                          this.currentTingkatPendidikan = a;
                        });
                        widget.onTingkatPendidikanChanged(a);
                      },
            onTingkatUmurChanged: widget.onTingkatUmurChanged == null
                ? null
                : (a) {
                    setState(() {
                      this.currentTingkatUmur = a;
                    });
                    widget.onTingkatUmurChanged(a);
                  },
            onStatusPegawaiChanged: widget.onStatusPegawaiChanged == null
                ? null
                : (a) {
                    setState(() {
                      this.currentStatusPegawai = a;
                    });
                    widget.onStatusPegawaiChanged(a);
                  },
            onAgamaChanged: widget.onAgamaChanged == null
                ? null
                : (a) {
                    setState(() {
                      this.currentAgama = a;
                    });
                    widget.onAgamaChanged(a);
                  },
            onReset: () {
              setState(() {
                this.currentKelas = null;
                this.currentWamen = null;
                this.currentCluster = null;
              });
              widget.onKelasChanged(null);
              widget.onWamenChanged(null);
              widget.onClusterChanged(null);
            });
      },
      child: Container(
        height: 28.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SortItem(
              image: 'res/images/ic_filter.png',
              name: 'Filter',
            ),
            if (widget.onWamenChanged != null && currentWamen != null)
              SortItem(
                image: 'res/images/ic_eselon_1.png',
                name: currentWamen ?? '-',
              ),
            if (widget.onKelasChanged != null && currentKelas != null)
              SortItem(
                image: 'res/images/ic_sort_item.png',
                name: currentKelas ?? '-',
              ),
            if (widget.onClusterChanged != null && currentCluster != null)
              SortItem(
                image: 'res/images/ic_sort_item.png',
                name: currentCluster ?? '-',
              ),
            if (widget.onStatusPegawaiChanged != null &&
                currentStatusPegawai != null)
              SortItem(
                image: 'res/images/ic_sort_item.png',
                name: currentStatusPegawai ?? '-',
              ),
            if (widget.onAgamaChanged != null && currentAgama != null)
              SortItem(
                image: 'res/images/ic_sort_item.png',
                name: currentAgama ?? '-',
              ),
            if (widget.onTingkatPendidikanChanged != null &&
                currentTingkatPendidikan != null)
              SortItem(
                image: 'res/images/ic_sort_item.png',
                name: currentAgama ?? '-',
              ),
            if (widget.onTingkatUmurChanged != null &&
                currentTingkatUmur != null)
              SortItem(
                image: 'res/images/ic_sort_item.png',
                name: currentTingkatUmur ?? '-',
              ),
          ],
        ),
      ),
    );
  }
}

showBaseFilterDialog({
  BuildContext context,
  Function(String) onWamenChanged,
  Function(String) onKelasChanged,
  Function(String) onClusterChanged,
  Function(String) onStatusPegawaiChanged,
  Function(String) onTingkatPendidikanChanged,
  Function(String) onTingkatUmurChanged,
  Function(String) onAgamaChanged,
  VoidCallback onReset,
  String wamen,
  String kelas,
  String cluster,
  String statusPegawai,
  String tingkatPendidikan,
  String tingkatUmur,
  String agama,
  List<String> clusterList,
}) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return BaseFilterDialog(
        onWamenChanged: onWamenChanged,
        onKelasChanged: onKelasChanged,
        onClusterChanged: onClusterChanged,
        onStatusPegawaiChanged: onStatusPegawaiChanged,
        onTingkatPendidikanChanged: onTingkatPendidikanChanged,
        onTingkatUmurChanged: onTingkatUmurChanged,
        onAgamaChanged: onAgamaChanged,
        onReset: onReset,
        wamen: wamen,
        kelas: kelas,
        cluster: cluster,
        clusterList: clusterList,
      );
    },
  );
}

class BaseFilterDialog extends StatefulWidget {
  Function(String) onWamenChanged;
  Function(String) onKelasChanged;
  Function(String) onClusterChanged;
  Function(String) onStatusPegawaiChanged;
  Function(String) onTingkatPendidikanChanged;
  Function(String) onTingkatUmurChanged;
  Function(String) onAgamaChanged;
  VoidCallback onReset;
  String wamen;
  String kelas;
  String cluster;
  String statusPegawai;
  String tingkatPendidikan;
  String tingkatUmur;
  String agama;
  List<String> clusterList;

  BaseFilterDialog({
    this.onWamenChanged,
    this.onKelasChanged,
    this.onClusterChanged,
    this.onStatusPegawaiChanged,
    this.onTingkatPendidikanChanged,
    this.onTingkatUmurChanged,
    this.onAgamaChanged,
    this.onReset,
    this.wamen,
    this.kelas,
    this.cluster,
    this.statusPegawai,
    this.tingkatPendidikan,
    this.tingkatUmur,
    this.agama,
    this.clusterList = const [],
  });

  @override
  _BaseFilterDialogState createState() => _BaseFilterDialogState();
}

class _BaseFilterDialogState extends State<BaseFilterDialog> {
  String currentWamen;
  String currentKelas;
  String currentCluster;
  String currentStatusPegawai;
  String currentTingkatPendidikan;
  String currentTingkatUmur;
  String currentAgama;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        setState(() {
          this.currentWamen = widget.wamen;
          this.currentKelas = widget.kelas;
          this.currentCluster = widget.cluster;
          this.currentStatusPegawai = widget.statusPegawai;
          this.currentTingkatPendidikan = widget.tingkatPendidikan;
          this.currentTingkatUmur = widget.tingkatUmur;
          this.currentAgama = widget.agama;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Color(0xFF737373),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Center(
              child: Container(
                height: 2.0,
                width: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  color: Color(0xFFC2C9D1),
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Filter Data',
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () {
                    widget.onReset();
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Color(0xFF1FA4CA),
                        width: 1.0,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            widget.onWamenChanged == null
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'res/images/ic_wamen_2.png',
                                  height: 16.0,
                                  width: 16.0,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  'Wamen',
                                  style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            FilterWidget(
                              withTitle: false,
                              items: [
                                'WAMEN I',
                                'WAMEN II',
                              ],
                              currentItem: currentWamen,
                              onChanged: (a) {
                                setState(() {
                                  this.currentWamen = a;
                                });
                                widget.onWamenChanged(a);
                              },
                            ),
                          ],
                        ),
                      ),
                      widget.onWamenChanged == null
                          ? Container()
                          : SizedBox(
                              width: 16.0,
                            ),
                      widget.onKelasChanged == null
                          ? Container()
                          : Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'res/images/ic_wamen_2.png',
                                        height: 16.0,
                                        width: 16.0,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 4.0,
                                      ),
                                      Text(
                                        'Kelas',
                                        style: TextStyle(
                                          fontFamily: 'poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  FilterWidget(
                                    withTitle: false,
                                    items: [
                                      'Kelas 1',
                                      'Kelas 2',
                                      'Kelas 3',
                                      'Kelas 4',
                                      'Kelas 5',
                                    ],
                                    currentItem: currentKelas,
                                    onChanged: (a) {
                                      setState(() {
                                        this.currentKelas = a;
                                      });
                                      widget.onKelasChanged(a);
                                    },
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
            SizedBox(
              height: 16.0,
            ),
            widget.onClusterChanged == null
                ? Container()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'res/images/ic_wamen_2.png',
                            height: 16.0,
                            width: 16.0,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            'Cluster',
                            style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      FilterWidget(
                        withTitle: false,
                        items: widget.clusterList,
                        currentItem: currentCluster,
                        onChanged: (a) {
                          setState(() {
                            this.currentCluster = a;
                          });
                          widget.onClusterChanged(a);
                        },
                      ),
                    ],
                  ),
            widget.onClusterChanged == null
                ? Container()
                : SizedBox(
                    height: 16.0,
                  ),
            widget.onTingkatUmurChanged == null
                ? Container()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'res/images/ic_wamen_2.png',
                            height: 16.0,
                            width: 16.0,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            'Tingkat Umur',
                            style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      FilterWidget(
                        withTitle: false,
                        items: [
                          'Dibawah 30 Tahun',
                          '30-39 Tahun',
                          '40-49 Tahun',
                          'Diatas 50 Tahun',
                        ],
                        currentItem: currentTingkatUmur,
                        onChanged: (a) {
                          setState(() {
                            this.currentTingkatUmur = a;
                          });
                          widget.onTingkatUmurChanged(a);
                        },
                      ),
                    ],
                  ),
            widget.onTingkatUmurChanged == null
                ? Container()
                : SizedBox(
                    height: 16.0,
                  ),
            widget.onTingkatPendidikanChanged == null
                ? Container()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'res/images/ic_wamen_2.png',
                            height: 16.0,
                            width: 16.0,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            'Tingkat Pendidikan',
                            style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      FilterWidget(
                        withTitle: false,
                        items: [
                          'S3',
                          'S2',
                          'S1',
                          'D4',
                          'D3',
                          'D2',
                          'D1',
                          'Pendidikan Khusus',
                          'SMA Sederajat',
                          'SMP Sederajat',
                        ],
                        currentItem: currentTingkatPendidikan,
                        onChanged: (a) {
                          setState(() {
                            this.currentTingkatPendidikan = a;
                          });
                          widget.onTingkatPendidikanChanged(a);
                        },
                      ),
                    ],
                  ),
            widget.onTingkatPendidikanChanged == null
                ? Container()
                : SizedBox(
                    height: 16.0,
                  ),
            widget.onAgamaChanged == null
                ? Container()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'res/images/ic_wamen_2.png',
                            height: 16.0,
                            width: 16.0,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            'Agama',
                            style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      FilterWidget(
                        withTitle: false,
                        items: [
                          'Hindu',
                          'Islam',
                          'Khatolik',
                          'Kristen',
                          'Protestan',
                        ],
                        currentItem: currentAgama,
                        onChanged: (a) {
                          setState(() {
                            this.currentAgama = a;
                          });
                          widget.onAgamaChanged(a);
                        },
                      ),
                    ],
                  ),
            widget.onAgamaChanged == null
                ? Container()
                : SizedBox(
                    height: 16.0,
                  ),
            widget.onStatusPegawaiChanged == null
                ? Container()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'res/images/ic_wamen_2.png',
                            height: 16.0,
                            width: 16.0,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            'Status Pegawai',
                            style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      FilterWidget(
                        withTitle: false,
                        items: [
                          'Alih Pengetahuan',
                          'CPNS',
                          'Diperbantukan (Direksi)',
                          'Honorer',
                          'Kembali ke Instansi Asal',
                          'Menteri',
                          'Pindah Kerja',
                          'PNS',
                          'Tenaga Kontrak',
                          'Wakil Menteri',
                        ],
                        currentItem: currentStatusPegawai,
                        onChanged: (a) {
                          setState(() {
                            this.currentStatusPegawai = a;
                          });
                          widget.onStatusPegawaiChanged(a);
                        },
                      ),
                    ],
                  ),
            widget.onStatusPegawaiChanged == null
                ? Container()
                : SizedBox(
                    height: 16.0,
                  ),
            FlatButton(
              minWidth: double.infinity,
              onPressed: () => Navigator.pop(context),
              color: Color(0xFF1FA4CA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Text(
                'Tampilkan',
                style: TextStyle(
                  fontFamily: 'poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
