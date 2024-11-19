import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:prototype/components/delete.dart';
import 'package:prototype/controller/hive_alumni.dart';
import 'package:prototype/models/alumni_model.dart';

// ValueNotifier<BatchModel?> domain=ValueNotifier({null});
class ShowAlumniDetails extends StatefulWidget {
  // final String? domain;
  final String? DomainValues;
  const ShowAlumniDetails({
    super.key,
    required this.DomainValues,
    // required this.domain
  });

  @override
  State<ShowAlumniDetails> createState() => _ShowAlumniDetailsState();
}

class _ShowAlumniDetailsState extends State<ShowAlumniDetails> {
  List<AlumniModel> alumniList = [];
  //  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    sortedAlumni();

    super.initState();
  }

  // Sorted domain show

  void sortedAlumni() async {
    await getAlumni();
    List<AlumniModel> tempList = [];

    alumniList = alumniNotifier.value;
    // if (widget.DomainValues != '') {
    for (var model in alumniList) {
      if (model.domain == widget.DomainValues) {
        tempList.add(model);
      }
    }
    setState(() {
      alumniList = tempList;
    });
  }

  String query = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(116),
          child: Column(
            children: [
              AppBar(
                iconTheme: const IconThemeData(color: Colors.red),
                backgroundColor: Colors.black,
                title: const Text(
                  'A L U M N I',
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
              ),
              Container(
                height: 60,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.black),
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
                          borderRadius: BorderRadius.circular(50),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 18,
                            fontStyle: FontStyle.italic)),
                  ),
                ),
              )
            ],
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ValueListenableBuilder(
            valueListenable: alumniNotifier,
            builder: (BuildContext ctx, List<AlumniModel> list, Widget? child) {
              final sortedList = list
                  .where(
                    (element) =>
                        element.name
                            .toLowerCase()
                            .contains(query.toLowerCase()) ||
                        element.batch
                            .toLowerCase()
                            .contains(query.toLowerCase()) ||
                        element.count!
                            .toLowerCase()
                            .contains(query.toLowerCase()),
                  )
                  .toList();

              return ListView.separated(
                separatorBuilder: (ctx, index) {
                  return const Divider(
                    color: Colors.brown,
                    height: 20,
                  );
                },
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final data = sortedList[index];
                  return Slidable(
                    startActionPane:
                        ActionPane(motion: const BehindMotion(), children: [
                      SlidableAction(
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                          label: 'Delete',
                          onPressed: (ctx) {
                            setState(() {
                              ShowDeleteDialog.showDeleteConformationDialog(
                                  context, data);
                            });
                          })
                    ]),
                    child: ListTile(
                      leading: GestureDetector(
                          onTap: () {
                            if (data.imageurl != null) {
                              showDialog(
                                context: ctx,
                                builder: (context) => ImageDialog(
                                  alumni: data,
                                ),
                              );
                            }
                          },
                          child: data.imageurl != null
                              ? CircleAvatar(
                                  radius: 30,
                                  backgroundImage: data.imageurl != null
                                      ? FileImage(File(data.imageurl!))
                                      : null)
                              : const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.black,
                                )),
                      title: Text(
                        data.name.toUpperCase(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle:
                          // Text(),
                          Text(
                        '${data.ctc} LPA',
                        style: const TextStyle(fontSize: 16),
                      ),
                      trailing: Text(
                        'Placement Count: ${data.count}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
                itemCount: alumniList.length,
              );
            },
          ),
        ),
      ),
    );
  }
}

class ImageDialog extends StatelessWidget {
  final AlumniModel alumni;
  const ImageDialog({super.key, required this.alumni});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.greenAccent[300],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: SizedBox(
        height: 500,
        width: 500,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.all(Radius.circular(10)),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: FileImage(File(alumni.imageurl!)),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(
                height: 20,
              ),
              Text('Name : ${alumni.name.toUpperCase()}',
                  style: const TextStyle(fontSize: 20)),
              Text('Batch : ${alumni.batch.toUpperCase()}',
                  style: const TextStyle(fontSize: 20)),
              Text('Company : ${alumni.company!.toUpperCase()}',
                  style: const TextStyle(fontSize: 20)),
              alumni.ctc!.isEmpty
                  ? Text(
                      'CTC: Non - Disclosable'.toUpperCase(),
                      style: const TextStyle(fontSize: 20),
                    )
                  : Text('CTC : ${alumni.ctc} LPA',
                      style: const TextStyle(fontSize: 20)),
              Text('Placement Count : ${alumni.count}',
                  style: const TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
