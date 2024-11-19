import 'package:flutter/material.dart';
import 'package:prototype/components/app_bar.dart';
import 'package:prototype/controller/hive_alumni.dart';
import 'package:prototype/controller/hive_batch.dart';
import 'package:prototype/models/admin_model.dart';
import 'package:prototype/components/drawer.dart';
import 'package:prototype/view/student/alumni/nav_alumni.dart';
import 'package:prototype/view/student/data/student_profile.dart';

class StudentDataTable extends StatefulWidget {
  const StudentDataTable({Key? key}) : super(key: key);

  @override
  State<StudentDataTable> createState() => _StudentDataTableState();
}

class _StudentDataTableState extends State<StudentDataTable> {
  void goToAlumniPage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ShowAlumniDomain()));
  }

  final _searchController = TextEditingController();
  final columns = [
    'No',
    'NAME',
    'BATCH',
    'DOMAIN',
    // 'ATTENDANCE',
    'WEEK',
    // 'PROGRESS'
  ];

  int? sortColumnIndex;
  bool isAscending = false;
  List<BatchModel> adminList = [];

  @override
  void initState() {
    adminList = batchNotifier.value;
    getValue();
    getAlumni();
    super.initState();
  }

  void filterSearchResults(String query) {
    List<BatchModel> results = [];
    // print(query);

    results = batchNotifier.value
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()) ||
            element.batch.contains(query) ||
            element.domain!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      adminList = results;
    });
  }

  BatchModel? selectedBatch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(116),
        child: Column(
          children: [
            MyAppBar(
                iconThemeData: const IconThemeData(color: Colors.red),
                automaticallyImplyLeading: true,
                appbartitle: 'STUDENTS DATA'),
            Container(
              height: 60,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  style: const TextStyle(fontSize: 20),
                  controller: _searchController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.only(bottom: 10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 18,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: MyDrawer(
        onTap: () => goToAlumniPage(context),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: batchNotifier,
              builder:
                  (BuildContext ctx, List<BatchModel> list, Widget? child) {
                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            // width: MediaQuery.sizeOf(context).width,
                            padding: const EdgeInsets.all(10),
                            // margin: EdgeInsets.symmetric(horizontal: 25),
                            color: Colors.black,
                            child: const Center(
                              child: Text(
                                'Status > > >  On Going Students',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 20),
                              ),
                            )),
                        buildDataTable(adminList),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDataTable(List<BatchModel> adminList) {
    double screenWidth = MediaQuery.of(context).size.width;
    double columnSpacingFraction = 0.05;
    return InkWell(
      child: DataTable(
        // decoration: BoxDecoration(
        //     color: Colors.yellow[100],
        //     backgroundBlendMode: BlendMode.luminosity),
        sortColumnIndex: sortColumnIndex,
        sortAscending: isAscending,
        border: TableBorder.all(width: 0.1),
        dataTextStyle:
            const TextStyle(fontSize: 13, color: Colors.black, wordSpacing: 2),
        columnSpacing: screenWidth * columnSpacingFraction,
        headingRowColor: MaterialStatePropertyAll(Colors.grey.shade800),
        columns: buildDataColumns(),
        rows: buildDataRows(adminList, context),
      ),
      // onTap: () {
      //   // int selectedRowIndex =
      //   //     adminList.indexWhere((batch) => batch == selectedBatch);
      //   // selectedBatch = adminList[selectedRowIndex];
      //   Navigator.of(context).push(MaterialPageRoute(
      //       builder: (ctx) => MyProfile(studentData: adminList)));
      // }
    );
  }

  List<DataColumn> buildDataColumns() {
    return columns.asMap().entries.map((entry) {
      final dataindex = entry.key;
      final col = entry.value;
      return DataColumn(
        label: Text(
          col,
          style: const TextStyle(color: Colors.white70),
        ),
        onSort: col == 'ATTENDANCE'
            ? null
            : (columnIndex, ascending) =>
                onSort(columnIndex, ascending, dataindex),
      );
    }).toList();
  }

  List<DataRow> buildDataRows(
      List<BatchModel> adminList, BuildContext context) {
    // Sort batches in ascending order
    // adminList.sort((a, b) => int.parse(a.batch) - int.parse(b.batch));
    adminList.sort((a, b) {
      int aBatch = int.tryParse(a.batch) ?? 0;
      int bBatch = int.tryParse(b.batch) ?? 0;

      return aBatch - bBatch;
    });

// adminList.sort((a, b) {
//   print("a.batch: ${a.batch}, b.batch: ${b.batch}");
//   return int.parse(a.batch) - int.parse(b.batch);
// });

    return List.generate(adminList.length, (index) {
      final data = adminList[index];

      return DataRow(
        onLongPress: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => StudentProfile(studentData: adminList[index])));
        },
        cells: [
          DataCell(Text('${index + 1}', softWrap: true)),
          DataCell(Text(data.name.toUpperCase(), softWrap: true)),
          // value
          //  ?
          DataCell(
              Text('${data.hub}-${data.batch}'.toUpperCase(), softWrap: true)),
          //  :DataCell(Text(AddBatchesDetails(DomainValues: null, batchValues: data.batch).batchValues!)),

          // value
          // ?
          DataCell(Text(data.domain!.toUpperCase(), softWrap: true)),
          // : DataCell(Text(AddBatchesDetails(DomainValues: data.domain)
          //     .DomainValues!
          //     .toUpperCase())),
          // const DataCell(Text('', softWrap: true)),

          DataCell(Text(data.week, softWrap: true)),
          // DataCell(Text(data.score
          //     // int.parse(data.score) <= 167
          //     //     ? 'BELOW AVERAGE'
          //     //     : (int.parse(data.score) > 167 && int.parse(data.score) <= 334
          //     //         ? 'AVERAGE'
          //     //         : 'EXCELLENT'),
          //     // softWrap: true
          //     )),
        ],
      );
    });
  }

  void onSort(int columnIndex, bool ascending, int dataIndex) {
    adminList.sort((user1, user2) {
      switch (columnIndex) {
        case 1:
          return compareString(ascending, user1.name, user2.name);
        case 2:
          return compareString(ascending, user1.batch, user2.batch);
        case 3:
          return compareString(ascending, user1.domain!, user2.domain!);
        case 5:
          return compareString(ascending, user1.week, user2.week);
        case 6:
          return compareString(ascending, user1.score, user2.score);
        default:
          return 0;
      }
    });

    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) {
    return ascending ? value1.compareTo(value2) : value2.compareTo(value1);
  }
}
