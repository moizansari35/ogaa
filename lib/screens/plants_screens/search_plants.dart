// import 'package:flutter/material.dart';
// import 'package:ogaa/screens/plants_screens/plantsList.dart';

// class PlantSearchScreen extends StatefulWidget {
//   const PlantSearchScreen({super.key});

//   @override
//   _PlantSearchScreenState createState() => _PlantSearchScreenState();
// }

// class _PlantSearchScreenState extends State<PlantSearchScreen> {
//   final TextEditingController _controller = TextEditingController();
//   List<Map<String, dynamic>> _searchedPlants = PlantLists.allPlants;

//   void _searchPlants(String query) {
//     final filteredPlants = PlantLists.allPlants.where((plant) {
//       final plantName = plant["name"].toLowerCase();
//       final searchQuery = query.toLowerCase();
//       return plantName.contains(searchQuery);
//     }).toList();

//     setState(() {
//       _searchedPlants = filteredPlants;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search Plants'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _controller,
//               onChanged: _searchPlants,
//               decoration: const InputDecoration(
//                 labelText: 'Search for a plant',
//                 border: OutlineInputBorder(),
//                 suffixIcon: Icon(Icons.search),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _searchedPlants.length,
//               itemBuilder: (context, index) {
//                 final plant = _searchedPlants[index];
//                 return ListTile(
//                   leading: Image.asset(plant['image']),
//                   title: Text(plant['name']),
//                   subtitle: Text(plant['soilType']),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
