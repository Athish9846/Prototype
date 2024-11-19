
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:pdf/widgets.dart' as pdf;
import 'package:prototype/controller/hive_batch.dart';
import 'package:prototype/models/admin_model.dart';
import 'package:prototype/view/admin/dashboard/show_profile.dart';

class HomePage extends StatefulWidget {
  final String batch;

  const HomePage({
    Key? key,
    required this.batch,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  final columns = [
    'No',
    'NAME',
    'BATCH',
    'DOMAIN',
    // 'ATTENDANCE',
    'WEEK',
    'PROGRESS'
  ];

  int? sortColumnIndex;
  bool isAscending = false;
  List<BatchModel> adminList = [];

  List<BatchModel> tempList = [];
  List<BatchModel> selectedUser = [];
  @override
  void initState() {
    sortedBatch();
    selectedUser = [];
    super.initState();
  }

  void sortedBatch() async {
    await getValue();
    adminList = batchNotifier.value;
    if (widget.batch != '') {
      for (var model in batchNotifier.value) {
        if (model.batch == widget.batch) {
          tempList.add(model);
        }
      }
      setState(() {
        adminList = tempList;
      });
    }
  }

  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(116),
        child: Column(
          children: [
            AppBar(
              iconTheme: const IconThemeData(color: Colors.red),
              backgroundColor: Colors.black,
              title: const Text(
                'STUDENTS DATA',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
            ),
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
                    setState(() {
                      query = value;
                    });
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
      body: SafeArea(
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: batchNotifier,
              builder:
                  (BuildContext ctx, List<BatchModel> list, Widget? child) {
                final sortedList = list
                    .where(
                      (element) =>
                          element.name
                              .toLowerCase()
                              .contains(query.toLowerCase()) ||
                          element.batch
                              .toLowerCase()
                              .contains(query.toLowerCase()) ||
                          element.domain!
                              .toLowerCase()
                              .contains(query.toLowerCase()),
                    )
                    .toList();

                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Slidable(
                          startActionPane: ActionPane(
                              motion: const BehindMotion(),
                              children: [
                                SlidableAction(
                                    backgroundColor: Colors.red,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                    onPressed: (context) {
                                      // showDeleteConfirmationDialog(
                                      //     context,);
                                    })
                              ]),
                          child: Container(
                              // width: MediaQuery.sizeOf(context).width,
                              padding: const EdgeInsets.all(10),
                              // margin: EdgeInsets.symmetric(horizontal: 25),
                              color: Colors.black,
                              child: const Center(
                                child: Text(
                                  'Status > > >  On Going Students',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 20),
                                ),
                              )),
                        ),
                        buildDataTable(sortedList),
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
    double columnSpacingFraction = 0.02;
    return DataTable(
      // decoration:  BoxDecoration(
      //     // color: Colors.yellow[100], backgroundBlendMode: BlendMode.luminosity
      //     color:Colors.grey.shade300,
      //     ),
      sortColumnIndex: sortColumnIndex,
      sortAscending: isAscending,
      border: TableBorder.all(width: 0.1),
      dataTextStyle:
          const TextStyle(wordSpacing: 1, fontSize: 13, color: Colors.black),
      columnSpacing: screenWidth * columnSpacingFraction,
      headingRowColor: MaterialStatePropertyAll(Colors.grey.shade800),
      columns: buildDataColumns(),
      rows: buildDataRows(adminList),
    );
  }

  List<DataColumn> buildDataColumns() {
    return columns.asMap().entries.map((entry) {
      final dataindex = entry.key;
      final col = entry.value;
      return DataColumn(
        // numeric: true,
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

  List<DataRow> buildDataRows(List<BatchModel> adminList) {
    // Sort batches in ascending order
    // adminList.sort((a, b) => int.parse(a.batch) - int.parse(b.batch));
    adminList.sort((a, b) {
      int aBatch = int.tryParse(a.batch) ?? 0;
      int bBatch = int.tryParse(b.batch) ?? 0;

      return aBatch - bBatch;
    });

    return List.generate(adminList.length, (index) {
      final data = adminList[index];

      return DataRow(
        // key: ValueKey(data.id.toString()),
        selected: selectedUser.contains(data),
        onSelectChanged: (value) {
          onSelectedRow(value!, data);
        },

        onLongPress: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) =>
                      ShowProfile(studentData: adminList[index])));
        },
        cells: [
          DataCell(Text('${index + 1}', softWrap: true)),
          DataCell(Text(data.name.toUpperCase(), softWrap: true)),
          // value
          //  ?
          DataCell(Text('${data.hub} - ${data.batch}'.toUpperCase(),
              softWrap: true)),
          //  :DataCell(Text(AddBatchesDetails(DomainValues: null, batchValues: data.batch).batchValues!)),

          // value
          // ?
          DataCell(Text(data.domain!.toUpperCase(), softWrap: true)),
          // : DataCell(Text(AddBatchesDetails(DomainValues: data.domain)
          //     .DomainValues!
          //     .toUpperCase())),
          // const DataCell(Text('', softWrap: true)),
          DataCell(Center(child: Text(data.week, softWrap: true))),
          DataCell(Center(
            child: Text(
              data.score,
              // int.parse(data.score) <= 167
              //     ? 'BELOW AVERAGE'
              //     : (int.parse(data.score) > 167 && int.parse(data.score) <= 334
              //         ? 'AVERAGE'
              //         : 'EXCELLENT'),
              // softWrap: true
            ),
          )),
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

  void onSelectedRow(bool selected, BatchModel user) async {
    setState(() {
      if (selected) {
        selectedUser.add(user);
      } else {
        selectedUser.remove(user);
      }
    });
    if (selected) {
      bool deleteData = await showDeleteConfirmationDialog(context, user);
      if (deleteData) {
        selectedUser.remove(user);
      } else {
        setState(() {
          selectedUser.remove(user);
        });
      }
      // if (user is BatchModel) {
      //   bool deleteData = await showDeleteConfirmationDialog(context, user);
      //   if (deleteData) {
      //     setState(() {
      //       deleteBatch(user.toString());
      //       adminList.remove(user);
      //       selectedUser.remove(user);

      //     });
      //   } else if (user is AddBatchModel) {
      //     bool deleteData = await showDeleteConfirmationDialog(context, user);
      //     if (deleteData) {
      //        adminList.remove(user);
      //       selectedUser.remove(user);
      //       deleteValue();
      //     }
      //   }
      // }
      // }
    }
    // else {
    //   selectedUser.remove(user);
    // }
  }

  Future showDeleteConfirmationDialog(
    BuildContext context,
    BatchModel user,
  ) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmation Delete'),
          content: const Text('Are you sure want to terminate the student?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                // setState(() {
                //   selectedUser.indexWhere(
                //       (element) => element.id == deleteStudentData(user));
                // });
                setState(() {
                  deleteStudentData(user);
                });
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
    // .then((value) {
    //   if (value != null && value) {

    //     // if (user is BatchModel) {
    //     //   deleteBatch(user.toString());
    //     // } else if (user is AddBatchModel) {
    //     //   deleteValue(user);
    //     // }
    //   }
    // }
    // );
  }

// extension DataRowExtension on DataRow {
//   Widget wrapWithSlidable(BatchModel data) {
//     return Slidable(
//       key: ValueKey(data.id.toString()),
//       child: Container(child: this,color: Colors.white,),
//       startActionPane: ActionPane(

//         motion: StretchMotion(),
//         children: [
//          SlidableAction(onPressed: (Context){},backgroundColor: Colors.red,icon: Icons.delete,)
//         ]),
//     );
//   }
// }
}
