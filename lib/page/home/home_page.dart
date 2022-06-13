import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leggo/common/constans/string.dart';
import 'package:leggo/dialog/exit_dialog.dart';
import 'package:leggo/model/app/destinasi_populer_model.dart';
import 'package:leggo/model/app/destination_model.dart';
import 'package:leggo/model/app/recomendasi_model.dart';
import 'package:leggo/model/app/singleton_model.dart';
import 'package:leggo/page/home/home_detail_page.dart';
import 'package:leggo/tool/helper.dart';
import 'package:leggo/tool/hex_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late SingletonModel _model;
  late TextEditingController _controller;
  late List<RecomendationModel> _recomenModel;
  late List<DestinasiPopulerModel> _populerModel;
  List<DestinationModel>? _destination;
  late bool _search;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey();
    _model = SingletonModel.withContext(context);
    _controller = TextEditingController();
    _search = false;
    _recomenModel = [
      RecomendationModel(
          id: 0,
          name: "Candi Borobudur",
          image: "assets/images/borobudur_img.png",
          description:
              "Candi borobudur diperkirakan dibangun pada tahun 750 masehi oleh kerajaan syailendra yang pada waktu itu menganut agama budha, pembangunan itu sangat misterius karena manusia pada abad ke 7 belum mengenal perhitungan arsitektur yang tinggi tetapi borobudur dibangun perhitungan arsitektur yang...."),
      RecomendationModel(
          id: 1,
          name: "Labuan Bajo",
          image: "assets/images/bajo_img.png",
          description:
              "Labuan Bajo merupakan salah satu kota yang berada di kecamatan Komodo, Kabupaten Manggarai Barat, provinsi Nusa Tenggara Timur, Indonesia. Kota Labuan Bajo juga merupakan ibu kota dari kecamatan Kecamatan Komodo dan ibu kota Kabupaten Manggarai Barat. Sedang diwacanakan pengembangan Kota Labuan Bajo."),
      RecomendationModel(
          id: 2,
          name: "Lawang Sewu",
          image: "assets/images/lawang_sewu_img.jpg",
          description:
              "Lawang Sewu adalah bangunan perkantoran yang terletak di seberang Tugu Muda, Kota Semarang, Jawa Tengah, Indonesia, yang dibangun sebagai kantor pusat Nederlandsch-Indische Spoorweg Maatschappij."),
    ];
    _populerModel = [
      DestinasiPopulerModel(
          id: 0,
          name: "Gunung Bromo",
          image: "assets/images/bromo_img.jpg",
          description:
              "Gunung Bromo atau dalam bahasa Tengger dieja 'Brama', juga disebut Kaldera Tengger, adalah sebuah gunung berapi aktif di Jawa Timur, Indonesia."),
      DestinasiPopulerModel(
          id: 1,
          name: "Pantai Kuta",
          image: "assets/images/kuta_img.png",
          description:
              "Kecamatan Kuta adalah sebuah Kecamatan di Kabupaten Badung, Provinsi Bali, Indonesia. Wilayah ini yang seluas 17,52 km² memiliki tempat wisata di Indonesia yang terkenal hingga ke manca negara, yaitu pantai Kuta, terutama bagi penggemar olahraga selancar."),
      DestinasiPopulerModel(
          id: 2,
          name: "Kawah Ijen",
          image: "assets/images/kawah_ijen_img.jpg",
          description:
              "Gunung Ijen adalah sebuah gunung berapi yang terletak di perbatasan Kabupaten Banyuwangi dan Kabupaten Bondowoso, Jawa Timur, Indonesia. Gunung ini memiliki ketinggian 2.386 mdpl dan terletak berdampingan dengan Gunung Merapi. Gunung Ijen terakhir meletus pada tahun 1999."),
      DestinasiPopulerModel(
          id: 3,
          name: "Danau Toba",
          image: "assets/images/danau_toba_img.jpg",
          description:
              "Danau Toba adalah danau alami berukuran besar di Indonesia yang berada di kaldera Gunung Supervulkan. Danau ini memiliki panjang 100 kilometer, lebar 30 kilometer, dan kedalaman 1.666 meter. Danau ini terletak di tengah pulau Sumatra bagian utara dengan ketinggian permukaan sekitar 900 meter."),
    ];
  }

  Future<bool> _onWillPop() async {
    bool exit = await openExitDialog(context) ?? false;
    return exit;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        _destination = kRecentDestination;
      });
    } else {
      setState(() {
        _destination =
            kSDestination.where((d) => d.name!.contains(query)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: HexColor("F0F4FD"),
          body: !_search ? _buildBody() : _searchView(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .08),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Text(
                        "Halo, ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${_model.getUser?.username}!" ?? "User!",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3),
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage("assets/images/user.jpg"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              onTap: () {
                setState(() {
                  _search = !_search;
                  _destination = kRecentDestination;
                });
              },
              decoration: InputDecoration(
                hintText: "Temukan destinasimu!",
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.fromLTRB(
                  20.0,
                  20.0,
                  20.0,
                  20.0,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.white,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Rekomendasi Liburan",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: _recomenModel.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () => Helper().jumpToPage(
                    context,
                    page: HomeDetailPage(data: _recomenModel[i]),
                  ),
                  child: Container(
                    height: 190,
                    width: 240,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                          _recomenModel[i].image!,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 10,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite_border_outlined,
                              size: 30,
                            ),
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                            right: 0,
                            left: 10,
                            bottom: 10,
                            child: Text(
                              _recomenModel[i].name!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 20);
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Destinasi Populer",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: _populerModel.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                return Container(
                  height: 150,
                  width: 200,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                        _populerModel[i].image!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          right: 0,
                          left: 10,
                          bottom: 10,
                          child: Text(
                            _populerModel[i].name!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ))
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 20);
              },
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _searchView() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  setState(() {
                    _search = !_search;
                    _controller.clear();
                  });
                },
              ),
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  onChanged: (value) {
                    _filterSearchResults(value);
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusColor: Colors.black,
                    hintText: "Where you going?",
                    suffixIcon: _controller.text.isEmpty
                        ? null
                        : InkWell(
                            child: SvgPicture.asset(
                                "assets/icons/clear_button_icon.svg"),
                            onTap: () {
                              _controller.clear();
                              setState(() {
                                _destination = kRecentDestination;
                              });
                            },
                          ),
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
          _controller.text.isEmpty
              ? Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        children: const [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey,
                          ),
                          Expanded(
                            child: Text(
                              "Explore Nearby Destination",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Recent search",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => ListTile(
                            onTap: () {},
                            // Helper().jumpToPage(context,
                            //     page: const DestinationPage()),
                            leading: const Icon(Icons.watch_later_outlined),
                            title: Text("${_destination?[index].name}"),
                          ),
                          itemCount: _destination!.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(color: Colors.black12),
                        ),
                      )
                    ],
                  ),
                )
              : Expanded(
                  child: InkWell(
                    onTap: () {},
                    // _helper.jumpToPage(
                    //   context,
                    //   page: const DestinationPage(),
                    // ),
                    child: ListView.builder(
                      itemCount: _destination!.length,
                      itemBuilder: (context, index) {
                        String name = _destination![index].name!;
                        String cName = name.replaceAll(
                            _controller.text, "#${_controller.text}#");
                        List<String> sss = cName.split("#");
                        List<TextSpan> children = [];
                        for (var d in sss) {
                          children.add(
                            TextSpan(
                              text: d,
                              style: TextStyle(
                                fontWeight: d == _controller.text
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: d.isEmpty ? Colors.black : Colors.grey,
                              ),
                            ),
                          );
                        }
                        return ListTile(
                          title: RichText(
                            text: TextSpan(
                              children: children,
                            ),
                          ),
                          leading: const Icon(Icons.location_on_outlined),
                        );
                      },
                      shrinkWrap: true,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
