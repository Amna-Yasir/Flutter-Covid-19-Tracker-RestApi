import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'services/utilities/covid_services.dart';

class countrylist extends StatefulWidget {
  const countrylist({super.key});

  @override
  State<countrylist> createState() => _countrylistState();
}

class _countrylistState extends State<countrylist> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    covidservices countryservices = covidservices();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: searchController,
              decoration: InputDecoration(
                  hintText: 'Search by country name',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: countryservices.fetchcountrylistapi(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String countryname =
                                snapshot.data![index]['country'];
                            if (searchController.text.isEmpty) {
                              return Column(
                                children: [
                                  ListTile(
                                    subtitle: Text(
                                        snapshot.data![index]['continent']),
                                    trailing: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag'])),
                                  ),
                                  Divider()
                                ],
                              );
                            } else if (countryname.toLowerCase().contains(
                                searchController.text.toLowerCase())) {
                              return Column(
                                children: [
                                  ListTile(
                                    subtitle: Text(
                                        snapshot.data![index]['continent']),
                                    trailing: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag'])),
                                  ),
                                  Divider()
                                ],
                              );
                            }
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }))
        ],
      )),
    );
  }
}
