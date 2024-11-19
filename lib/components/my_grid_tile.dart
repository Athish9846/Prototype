import 'package:flutter/material.dart';
import 'package:prototype/components/show_domain.dart';
import 'package:prototype/view/admin/Alumni/add_alumni_details.dart';
import 'package:prototype/view/admin/batches/add_batches_details.dart';
import 'package:prototype/view/student/alumni/show_alumni.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prototype/main.dart';

class AlumniGridTile extends StatefulWidget {
  final Navigate navigate;
  final String? batch;
  const AlumniGridTile({super.key, required this.navigate, this.batch});

  @override
  State<AlumniGridTile> createState() => _AlumniGridTileState();
}

final Map<String, List<String?>> _domainMap = {
  'WEB DEVELOPMENT': [
    'MERN',
    'MEAN',
    'PYTHON',
    'PYTHON DJANGO + REACT',
    'REACT JS',
    '.NET',
    'JAVA',
    'GOLANG',
    'RUBY'
  ],
  'MOBILE APP DEVELOPMENT': ['FlUTTER', 'KOTLIN', 'REACT NATIVE', 'SWIFT'],
  'CYBER SECURITY': ['CYBER SECURITY'],
  'ARTIFICIAL INTELLIGENCE': ['ARTIFICIAL INTELLIGENCE'],
  'MACHINE LEARNING': ['MACHINE LEARNING'],
  'GAME DEVELOPMENT': ['GAME DEVELOPMENT'],
  'BLOCK CHAIN': ['BLOCK CHAIN'],
  'DATA SCIENCE': ['DATA SCIENCE'],
  'DEVOPS': ['DEVOPS'],
};

//  late Navigate navigate;
enum Navigate { addBatchesDetails, addAlumniDetails, showAlumniDetails }

class _AlumniGridTileState extends State<AlumniGridTile> {
  final List<List<String>> _domains = [
    ['WEB DEVELOPMENT', 'assets/images/webdevelop.png'],
    ['MOBILE APP DEVELOPMENT', 'assets/images/appdevelopment.png'],
    ['CYBER SECURITY', 'assets/images/cybersecurity.png'],
    ['ARTIFICIAL INTELLIGENCE', 'assets/images/ai.png'],
    ['MACHINE LEARNING', 'assets/images/machinelearninglogo.png'],
    ['GAME DEVELOPMENT', 'assets/images/game development.png'],
    ['BLOCK CHAIN', 'assets/images/block chain.png'],
    ['DATA SCIENCE', 'assets/images/datascience.png'],
    ['DEVOPS', 'assets/images/devops.png'],
  ];

  var value = false;
  Future<bool> isAdminLogin() async {
    final sharedPrefss = await SharedPreferences.getInstance();
    bool isLoggedIn = sharedPrefss.getBool(SAVE_KEY_NAME) == true;
    setState(() {
      value = isLoggedIn;
    });
    return isLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    isAdminLogin();

    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1 / .75),
      itemBuilder: ((context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                // if (!value) {
                if (_domainMap[_domains[index].first]!.length == 1) {
                  if (widget.navigate == Navigate.addBatchesDetails) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => AddBatchesDetails(
                          batch: widget.batch,
                          DomainValues:
                              _domainMap[_domains[index].first]!.first,
                        ),
                      ),
                    );
                  } else if (widget.navigate == Navigate.showAlumniDetails) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ShowAlumniDetails(
                            DomainValues:
                                _domainMap[_domains[index].first]!.first),
                      ),
                    );
                  } else {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => AddAlumniDetails(
                              domainValues:
                                  _domainMap[_domains[index].first]!.first,
                            )));
                  }
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ShowDomain(
                          batch: widget.batch,
                          navigate: widget.navigate,
                          domain: _domainMap[_domains[index].first]!),
                    ),
                  );
                }
              },
              child: Card(
                elevation: 10,
                color: Colors.grey[900],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //           fit: BoxFit.cover,
                    //           image: AssetImage(_domains[index][1]))),
                    // ),
                    Image.asset(
                      _domains[index][1],
                      height: 70,
                    ),
                    // Image(
                    //     height: 60,

                    //     image: AssetImage(_domains[index][1])),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        // margin: EdgeInsets.only(bottom:10 ),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: _domains[index][0] == 'ARTIFICIAL INTELLIGENCE'
                            ? const Text(
                                'ARTIFICIAL\nINTELLIGENCE',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              )
                            : _domains[index][0] == 'MOBILE APP DEVELOPMENT'
                                ? const Text(
                                    'MOBILE\nAPP DEVELOPMENT',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  )
                                : Text(
                                    _domains[index][0],
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  )),
                  ],
                ),
              ),
            ),
          )),
      itemCount: _domains.length,
    );
  }
}
