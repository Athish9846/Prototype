import 'package:flutter/material.dart';
import 'package:prototype/components/app_bar.dart';
import 'package:prototype/controller/hive_add_batch.dart';
import 'package:prototype/models/admin_batch_model.dart';
import 'package:prototype/view/Admin/BATCHES/show_addStudent.dart';
import 'package:prototype/view/admin/dashboard/home_page.dart';

class ShowBatches extends StatefulWidget {
  final String? batch;
  const ShowBatches({
    super.key,
    required this.batch,
  });

  @override
  State<ShowBatches> createState() => _ShowBatchesState();
}

class _ShowBatchesState extends State<ShowBatches> {
  @override
  void initState() {
    getBatches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: MyAppBar(
            automaticallyImplyLeading: true,
            appbartitle: '',
            iconThemeData: const IconThemeData(color: Colors.white),
          )),
      // AppBar(
      //   title: const Text(''),
      //   backgroundColor: Colors.black87,
      // ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
        child: ValueListenableBuilder(
          valueListenable: batches,
          builder: (context, List<AddBatchModel> batchesList, child) {
            batchesList.sort(
              (a, b) => int.parse(a.batch) - int.parse(b.batch),
            );
            return ListView.separated(
                itemBuilder: (context, index) {
                  final data = batchesList[index];

                  return
                      // Dismissible(
                      //   key: UniqueKey(),
                      //   background: Container(
                      //     color: Colors.red,
                      //   ),
                      //   onDismissed: (direction) {
                      //     direction == DismissDirection.endToStart;
                      //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      //         backgroundColor: Colors.red,
                      //         elevation: 5,
                      //         behavior: SnackBarBehavior.floating,
                      //         duration: Duration(seconds: 2),
                      //         margin: EdgeInsets.all(10),
                      //         content: Text('Deleted')));
                      //     //  Hive.box('batches_db').delete(UniqueKey());

                      //     deleteValue(data);
                      //   },
                      // child:
                      Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/studentbatch.png',
                        width: 30,
                      ),
                      title: Text(
                        'Batch - ${data.batch}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      // subtitle: Row(
                      //   children: [
                      //     const Text('Show Data'),
                      // IconButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (ctx) =>
                      //                   const StudentProfile()));
                      //     },
                      //     icon: const Icon(Icons.arrow_drop_down))
                      // ],
                      // ),
                      trailing: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            // fixedSize: MaterialStatePropertyAll(Size(90, 20)),

                            backgroundColor:
                                MaterialStatePropertyAll(Colors.grey.shade900)),
                        onPressed: () {
                          print(data.batch);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => ShowAddStudent(
                                        batch: data.batch,
                                      )));
                        },
                        child: const Text('Add Student',
                            style: TextStyle(fontSize: 12)),
                      ),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => HomePage(batch: data.batch))),
                      // selectedColor: Colors.grey,
                      // selected: true  ,

                      // shape: RoundedRectangleBorder(
                      //   side: BorderSide(color: Colors.black),
                      //   borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(),
                itemCount: batchesList.length);
          },
        ),
      )),
    );
  }
}
