import 'package:flutter/material.dart';
import 'package:prototype/components/app_bar.dart';
import 'package:prototype/controller/hive_add_batch.dart';
import 'package:prototype/models/admin_batch_model.dart';
import 'package:prototype/view/admin/attendence/studentdata/data_table.dart';


class AttendencePage extends StatefulWidget {
  const AttendencePage({super.key});

  @override
  State<AttendencePage> createState() => _AttendencePageState();
}

class _AttendencePageState extends State<AttendencePage> {
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
            appbartitle: 'Attendence',
            automaticallyImplyLeading: false,
          )),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(0.8),
          child: ValueListenableBuilder(
              valueListenable: batches,
              builder: (context, List<AddBatchModel> batchesList, child) {
                batchesList
                    .sort((a, b) => int.parse(a.batch) - int.parse(b.batch));
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    final data = batchesList[index];
                    return Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
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
                        // trailing:
                        // onTap: () =>
                        // selectedColor: Colors.grey,
                        // selected: true  ,

                        // shape: RoundedRectangleBorder(
                        //   side: BorderSide(color: Colors.black),
                        //   borderRadius: BorderRadius.all(Radius.circular(10))),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (ctx) => StudentData(batches:data.batch,))),
                      ),
                    );
                  },
                  itemCount: batchesList.length,
                );
              }),
        )),
      ),
    );
  }
}
