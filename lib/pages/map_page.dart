import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:universal_io/io.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _controller;
  final Set<Marker> _markers = {};
  bool _showList = false;

  static const LatLng _center = LatLng(48.8566, 2.3522);

  @override
  void initState() {
    super.initState();
    if (!Platform.isWindows) {
      _markers.add(
        const Marker(
          markerId: MarkerId('monoprix'),
          position: LatLng(48.864716, 2.349014),
          infoWindow: InfoWindow(title: 'Monoprix'),
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _toggleList() {
    setState(() {
      _showList = !_showList;
    });
  }

  Widget _buildInfoBox(String title, String address, String hours, {String? distance}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const[BoxShadow(color: Colors.black26, blurRadius: 10.0)],
      ),
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Image.asset('assets/images/station.png', height: 50),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF687890),
                ),
              ),
              if (distance != null)
                Text(
                  distance,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Rubik',
                    color: Color(0xFF687890),
                  ),
                ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Image.asset('assets/images/power.png', height: 20),
                  const SizedBox(width: 5),
                  const Text(
                    'x3',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Rubik',
                      color: Color(0xFF687890),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                address,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Rubik',
                  color: Color(0xFF687890),
                ),
              ),
              Text(
                hours,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Rubik',
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: _center,
              zoom: 13.0,
            ),
            markers: _markers,
          ),
          Positioned(
            top: 50.0,
            left: 15.0,
            right: 15.0,
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const[BoxShadow(color: Colors.black26, blurRadius: 10.0)],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Rechercher un lieu',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15.0),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 180.0,
            left: 15.0,
            right: 15.0,
            child: _showList
                ? SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return _buildInfoBox(
                          'Monoprix',
                          '11 Rue de Molinel, 10eme arr. Paris',
                          'Ouvert - 22h00',
                          distance: '.2km',
                        );
                      },
                    ),
                  )
                : _buildInfoBox(
                    'Monoprix',
                    '11 Rue de Molinel, 10eme arr. Paris',
                    'Ouvert - 22h00',
                  ),
          ),
          if (_showList)
            Positioned(
              top: 50.0,
              right: 15.0,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: _toggleList,
              ),
            ),
          Positioned(
            bottom: 20.0,
            left: 15.0,
            right: 15.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _toggleList,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF799CF0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                  ),
                  child: Text(
                    _showList ? 'La Carte' : 'Voir la Liste',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Rubik',
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF799CF0), width: 4),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.offAllNamed('/home');
                    },
                    icon: const Icon(Icons.home, size: 30, color: Color(0xFF799CF0)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF132FBA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                  ),
                  child: const Text(
                    'Itinéraire',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Rubik',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
