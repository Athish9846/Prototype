import 'package:flutter/material.dart';
import 'package:prototype/components/app_bar.dart';
import 'package:prototype/components/my_grid_tile.dart';
import 'package:prototype/view/admin/Alumni/add_alumni_details.dart';
import 'package:prototype/view/admin/batches/add_batches_details.dart';
import 'package:prototype/view/student/alumni/show_alumni.dart';

class ShowDomain extends StatelessWidget {
  final List<String?> domain;
  final Navigate navigate;
  final String? batch;
  ShowDomain(
      {super.key, required this.domain, required this.navigate, this.batch});

  final List<List<String?>> _showwebdomains = [
    [
      // 'MERN',
      'assets/images/MERN-logo.png',
    ],
    [
      // 'MEAN',
      'assets/images/mean-stack-2.png',
    ],
    [
      // 'Python',
      'assets/images/pythonlogo.png'
    ],
    [
      // 'Node.js',
      'assets/images/nodejs.png',
    ],
    [
      // 'PHP',
      'assets/images/php.png',
    ],
    [
      // '.Net',
      'assets/images/microsoft-dotnet-1-1175178.webp',
    ],
    [
      // 'Java',
      'assets/images/javadevelopment.png'
    ],
    [
      // 'Go',
      'assets/images/golang-img (1)2.png'
    ],
    [
      // 'Ruby',
      'assets/images/rubydevelopment.png'
    ],
  ];

  final List<List<String>> _showmobiledomains = [
    ['Kotlin', 'assets/images/kotlin.png'],
    ['Flutter', 'assets/images/flutter.png'],
    ['React Native', 'assets/images/reactnative.png']
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: MyAppBar(
            appbartitle: 'D O M A I N',
            automaticallyImplyLeading: true,
            iconThemeData: const IconThemeData(color: Colors.white),
          )),
      //  AppBar(
      //   backgroundColor: Colors.black87,
      //   title: const Text(
      //     '',
      //     style: TextStyle(
      //       fontSize: 30,
      //       // color: Colors.white,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView.separated(
          itemCount: domain.length,
          itemBuilder: (context, index) {
            // String key = domain.keys.elementAt(index);

            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Text(
                  'Domain: ${domain[index]}',
                  style: 'Domain'.startsWith('Domain')
                      ? const TextStyle(fontSize: 15)
                      : const TextStyle(fontWeight: FontWeight.w400),
                ),
                // Text('Domain: ${domain.entries.elementAt(index)}'),
                //     for(var entry in domain.entries){
                //     Text('Domain: ${entry.value}'),
                // }

                // Text(
                //   'Domain: ${_showwebdomains[index][0]}',
                //   style: const TextStyle(fontSize: 15),
                // ),

                // trailing: Image.asset(
                //   _showwebdomains[index][1]!,
                //   width: 60,
                //   height: 60,
                // ),
                trailing: const Icon(
                  Icons.arrow_right,
                  size: 25,
                ),
                onTap: () {
                  if (navigate == Navigate.addBatchesDetails) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => AddBatchesDetails(
                          batch: batch,
                          DomainValues: domain[index],
                        ),
                      ),
                    );
                  } else if (navigate == Navigate.showAlumniDetails) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ShowAlumniDetails(
                            // domain: domain[index],
                            DomainValues: domain[index]),
                      ),
                    );
                  } else {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => AddAlumniDetails(
                              domainValues: domain[index],
                            )));
                  }
                },
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
        ),
      ),
    );
  }
}
