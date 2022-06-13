import 'package:flutter/material.dart';
import 'package:leggo/model/app/recomendasi_model.dart';
import 'package:leggo/tool/hex_color.dart';

class HomeDetailPage extends StatefulWidget {
  final RecomendationModel data;

  const HomeDetailPage({Key? key, required this.data}) : super(key: key);

  @override
  State<HomeDetailPage> createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: double.infinity,
          color: Colors.white,
        ),
        Container(
          height: MediaQuery.of(context).size.height * .6,
          decoration: BoxDecoration(
            color: HexColor("#F6F6F9"),
          ),
          child: Container(
            child: Image.asset(
              widget.data.image!,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 25,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.only(
              top: 24,
              left: 24,
              right: 24,
            ),
            width: width,
            height: MediaQuery.of(context).size.height * .55,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.name!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.data.description!,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
