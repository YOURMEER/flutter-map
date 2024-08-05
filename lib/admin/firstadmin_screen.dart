
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermap/admin/admin_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Admindashboard extends StatefulWidget {
  const Admindashboard({super.key});

  @override
  State<Admindashboard> createState() => _AdmindashboardState();
}

class _AdmindashboardState extends State<Admindashboard> {

  List vectorImages = ["images/fire.png","images/soles.png","images/distance.png","images/night.png"];
  List vectorText = ["305","10,939","7km","7h48m"];
  List vectorSubText = ["305","10,939","7km","7h48m"];



  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];

  @override
  Widget build(BuildContext context) {
    final reswidth = MediaQuery.of(context).size.width;
    final resheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF171821),
      drawer: DrawerAdmin(),
     // endDrawer: AdminProfile(),


      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              child:  Row(
                  children: [
                    Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          icon: Icon(Icons.view_headline_outlined,color: Colors.grey[600],size: 30,),
                          onPressed: () {Scaffold.of(context).openDrawer();},
                        );
                      },
                    ),



                    // Padding(
                    //   padding: const EdgeInsets.all(1.0),
                    //   child: Container(
                    //     width: reswidth * 0.75,
                    //     height: resheight * 0.04,
                    //     child: TextFormField(
                    //       decoration: InputDecoration(
                    //         prefixIcon: Icon(Icons.search_outlined),
                    //         filled: true,
                    //         fillColor: Color(0xFF21222D), // Set the background color of the field
                    //         hintText: 'Search',
                    //         hintStyle: TextStyle(color: Colors.grey[600]), // Set the color of the hint text
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.all(Radius.circular(12.0)), // Optional: rounded corners
                    //           borderSide: BorderSide.none, // No border
                    //         ),
                    //         contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Adjust the padding
                    //       ),
                    //       style: TextStyle(color: Colors.white), // Set the text color
                    //       cursorColor: Colors.white, // Set the cursor color
                    //     ),
                    //   ),
                    // ),

                    // Icon(Icons.search_outlined,color: Colors.white,),
                    Spacer(),
                    // SizedBox(width: reswidth * 0.03),

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
                                    child:ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image(
                                          fit: BoxFit.fill,
                                          image: AssetImage("images/adminpagepfp.jpeg")
                                      ),
                                    ),
                                  )
                              );
                            }
                        )
                    )
                  ]
              ),
            ),

            SizedBox(height: resheight * 0.02,),

            Container(
              width: reswidth * 0.9,
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search_outlined),
                  filled: true,
                  fillColor: Color(0xFF21222D), // Set the background color of the field
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey[600]), // Set the color of the hint text
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)), // Optional: rounded corners
                    borderSide: BorderSide.none, // No border
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Adjust the padding
                ),
                style: TextStyle(color: Colors.white), // Set the text color
                cursorColor: Colors.white, // Set the cursor color
              ),
            ),

            SizedBox(height: resheight * 0.05,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10),
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
                              )
                          ),
                        ),
                        Text(vectorText[index],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                        Text(vectorSubText[index],style: TextStyle(color: Colors.white,fontSize: 14),)
                      ],
                    ),
                  );
                },),
            ),

            SizedBox(height: resheight * 0.05,),

            SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart title
                title: ChartTitle(text: 'Half yearly sales analysis'),
                // Enable legend
                legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries<_SalesData, String>>[
                  LineSeries<_SalesData, String>(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'Sales',
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ]),

            Padding(
              padding: const EdgeInsets.all(32.0),
              //Initialize the spark charts widget
              child: SfSparkLineChart.custom(
                //Enable the trackball
                trackball: SparkChartTrackball(
                    activationMode: SparkChartActivationMode.tap),
                //Enable marker
                marker: SparkChartMarker(
                    displayMode: SparkChartMarkerDisplayMode.all),
                //Enable data label
                labelDisplayMode: SparkChartLabelDisplayMode.all,
                xValueMapper: (int index) => data[index].year,
                yValueMapper: (int index) => data[index].sales,
                dataCount: 5,
              ),
            ),


          ],
        ),
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}


final List<_SalesData> data = [
  _SalesData('2016', 35),
  _SalesData('2017', 7),
  _SalesData('2018', 10),
  _SalesData('2019', 6),
  _SalesData('2020', 40),
  _SalesData('2021', 52),
  _SalesData('2022', 55),
  _SalesData('2023', 8),
  _SalesData('2024', 47),
  _SalesData('2025', 50),
];