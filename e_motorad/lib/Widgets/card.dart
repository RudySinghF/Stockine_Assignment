import 'dart:convert';

import 'package:e_motorad/Model/DataModel.dart';
import 'package:e_motorad/NetworkHandler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RouteDetails extends StatefulWidget {
  const RouteDetails({super.key});

  @override
  State<RouteDetails> createState() => _RouteDetailsState();
}

class _RouteDetailsState extends State<RouteDetails> {
  NetworkHandler networkHandler = NetworkHandler();

  int called = 0;
  bool flag = false;

  Future<List<Ride>> getAllPackage() async {
    setState(() {
      called++;
    });

    try {
      List<Ride> rides = [];
      var response = await networkHandler.get("/v1/markets/news");

      // Check if the response contains the "body" key
      if (response.containsKey('body') && response['body'] is List) {
        // Access the list under the "body" key
        List<dynamic> bodyList = response['body'];

        // Map the list to Ride objects using Ride.fromJson
        rides = List<Ride>.from(bodyList.map((e) => Ride.fromJson(e)));
      }

      return rides;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<List<Ride>>(
        future: getAllPackage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      child: Container(
                        // height: 200,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(vertical: 10),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 20,
                              child: Text(
                                  "Title:    ${snapshot.data![index].title}" ??
                                      ""),
                              padding: EdgeInsets.all(1),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 20,
                              child: Text(
                                  "Link:    ${snapshot.data![index].link}" ??
                                      ""),
                              padding: EdgeInsets.all(1),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 20,
                              child: Text(
                                  "Publish Date:    ${snapshot.data![index].pubDate}" ??
                                      ""),
                              padding: EdgeInsets.all(1),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 20,
                              child: Text(
                                  "Source:    ${snapshot.data![index].source}" ??
                                      ""),
                              padding: EdgeInsets.all(1),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 20,
                              child: Text(
                                  "Guid:    ${snapshot.data![index].guid}" ??
                                      ""),
                              padding: EdgeInsets.all(1),
                            ),
                          ],
                        ),
                      ),
                    );
                  }));
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return Center(
                child: Text("Something went wrong"),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
