import 'package:e_motorad/Widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RideHistory extends StatefulWidget {
  const RideHistory({super.key});

  @override
  State<RideHistory> createState() => _RideHistoryState();
}

class _RideHistoryState extends State<RideHistory> {
  bool _showBackToTopButton = false;

  // scroll controller
  late ScrollController _scrollController;
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });

    super.initState();
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 3), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Stockine News",
          style: TextStyle(
              fontFamily: GoogleFonts.nunito().fontFamily, color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 5, 90, 181),
        leading: InkWell(
          onTap: () {},
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [RouteDetails()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollToTop,
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}
