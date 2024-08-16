import 'package:flutter/material.dart';
import 'package:fluttermap/admin/admin_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Admindashboard extends StatefulWidget {
  const Admindashboard({super.key});

  @override
  State<Admindashboard> createState() => _AdmindashboardState();
}

class _AdmindashboardState extends State<Admindashboard> with TickerProviderStateMixin {
  List vectorImages = ["images/fire.png", "images/soles.png", "images/distance.png", "images/night.png"];
  List vectorText = ["305", "10,939", "7km", "7h48m"];
  List vectorSubText = ["305", "10,939", "7km", "7h48m"];

  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];

  late AnimationController _colorAnimationController;
  late Animation<Color?> _colorTween;

  @override
  void initState() {
    super.initState();
    _colorAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _colorTween = ColorTween(
      begin: Colors.white,
      end: Colors.blueAccent,
    ).animate(_colorAnimationController)
      ..addListener(() {
        setState(() {});
      });

    _colorAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _colorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reswidth = MediaQuery.of(context).size.width;
    final resheight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFF171821),
      drawer: DrawerAdmin(),
      body: Stack(
        children: [
          // Animated gradient background
          AnimatedContainer(
            duration: const Duration(seconds: 3),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_colorTween.value!, Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Floating elements
          Positioned(
            top: 50,
            left: 30,
            child: FloatingElement(),
          ),
          Positioned(
            top: 200,
            right: 30,
            child: FloatingElement(),
          ),
          Positioned(
            bottom: 100,
            left: 80,
            child: FloatingElement(),
          ),
          Positioned(
            bottom: 50,
            right: 100,
            child: FloatingElement(),
          ),
          // Foreground content
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Builder(
                        builder: (BuildContext context) {
                          return IconButton(
                            icon: Icon(Icons.view_headline_outlined, color: Colors.grey[600], size: 30),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          );
                        },
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Builder(
                          builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: () {
                                Scaffold.of(context).openEndDrawer();
                              },
                              child: CircleAvatar(
                                radius: 15,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image(
                                    fit: BoxFit.fill,
                                    image: AssetImage("images/adminpagepfp.jpeg"),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: resheight * 0.02),
                  Container(
                    width: reswidth * 0.9,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search_outlined),
                        filled: true,
                        fillColor: Color(0xFF21222D),
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      ),
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: resheight * 0.05),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
                      itemCount: 4,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          width: reswidth * 0.35,
                          height: resheight * 0.35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF21222D),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Container(
                                width: reswidth * 0.1,
                                height: resheight * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFF21222D),
                                  image: DecorationImage(
                                    image: AssetImage(vectorImages[index]),
                                  ),
                                ),
                              ),
                              Text(vectorText[index], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                              Text(vectorSubText[index], style: TextStyle(color: Colors.white, fontSize: 14)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: resheight * 0.05),
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    title: ChartTitle(text: 'Half yearly sales analysis'),
                    legend: Legend(isVisible: true),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <CartesianSeries<_SalesData, String>>[
                      LineSeries<_SalesData, String>(
                        dataSource: data,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: 'Sales',
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: SfSparkLineChart.custom(
                      trackball: SparkChartTrackball(activationMode: SparkChartActivationMode.tap),
                      marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
                      labelDisplayMode: SparkChartLabelDisplayMode.all,
                      xValueMapper: (int index) => data[index].year,
                      yValueMapper: (int index) => data[index].sales,
                      dataCount: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class FloatingElement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.5),
      ),
    );
  }
}
