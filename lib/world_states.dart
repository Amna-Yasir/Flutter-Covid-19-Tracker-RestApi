import 'package:covid_app/countrylist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'model/covidmodel.dart';
import 'services/utilities/covid_services.dart';

class worldstats extends StatefulWidget {
  const worldstats({super.key});

  @override
  State<worldstats> createState() => _weatherscreen();
}

class _weatherscreen extends State<worldstats> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  Widget build(BuildContext context) {
    covidservices Weatherservices = covidservices();
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FutureBuilder(
                future: Weatherservices.fetchwordstatsapi(),
                builder: (context, AsyncSnapshot<Covidmodel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.black,
                          size: 50,
                          controller: _controller,
                        ));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          PieChart(
                              chartRadius:
                                  MediaQuery.of(context).size.width / 3.2,
                              ringStrokeWidth: 15,
                              legendOptions: LegendOptions(
                                  legendPosition: LegendPosition.left),
                              chartType: ChartType.ring,
                              chartValuesOptions: ChartValuesOptions(
                                  showChartValuesInPercentage: true),
                              dataMap: {
                                'total': double.parse(
                                    snapshot.data!.cases.toString()),
                                'death': double.parse(
                                    snapshot.data!.deaths.toString()),
                                'recover': double.parse(
                                    snapshot.data!.recovered.toString())
                              }),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * .06),
                            child: Card(
                              child: Column(
                                children: [
                                  ReusableRow(
                                      title: 'Total',
                                      value: snapshot.data!.cases.toString()),
                                  Divider(),
                                  ReusableRow(
                                      title: 'Death',
                                      value: snapshot.data!.deaths.toString()),
                                  Divider(),
                                  ReusableRow(
                                      title: 'Recoverd',
                                      value:
                                          snapshot.data!.recovered.toString()),
                                  Divider(),
                                  ReusableRow(
                                      title: 'Active',
                                      value: snapshot.data!.active.toString()),
                                  Divider(),
                                  ReusableRow(
                                      title: 'Affected Countries',
                                      value: snapshot.data!.affectedCountries
                                          .toString()),
                                  Divider(),
                                  ReusableRow(
                                      title: 'Today Recoverd',
                                      value: snapshot.data!.todayRecovered
                                          .toString()),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('tap');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => countrylist()));
                            },
                            child: Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Track Countries'),
                              )),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    )));
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(value),
                ],
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        )
      ],
    );
  }
}
