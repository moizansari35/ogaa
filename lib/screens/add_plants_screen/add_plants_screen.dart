// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:ogaa/provider/app_provider.dart';
// import 'package:provider/provider.dart';

// class AddPlantsScreen extends StatefulWidget {
//   const AddPlantsScreen({super.key});

//   @override
//   _AddPlantsScreenState createState() => _AddPlantsScreenState();
// }

// class _AddPlantsScreenState extends State<AddPlantsScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _soilTypeController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   double _minTemp = 20.0;
//   double _maxTemp = 35.0;
//   File? _image;
//   final List<String> _selectedWeather = [];
//   final List<String> _selectedCategories = [];
//   bool _isLoading = false;

//   // List of weather types and categories for selection
//   final List<String> weatherTypes = [
//     'Sunny',
//     'Cloudy',
//     'Rainy',
//     'Windy',
//     'Hot',
//     'Cold',
//     'Warm',
//     'Windy',
//     'Dry',
//     'Tropical',
//     'Humid',
//     'Cool',
//   ];
//   final List<String> categoryTypes = ['Indoor', 'Outdoor', 'Garden'];

//   final ImagePicker _picker = ImagePicker();

//   // Method to pick an image from the gallery
//   Future<void> _pickImage() async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   // Method to submit plant data to Firebase
//   Future<void> _submitPlant() async {
//     if (_formKey.currentState!.validate() &&
//         _selectedWeather.isNotEmpty &&
//         _selectedCategories.isNotEmpty) {
//       setState(() {
//         _isLoading = true;
//       });

//       String name = _nameController.text;
//       String soilType = _soilTypeController.text;
//       String description = _descriptionController.text;

//       String imageUrl = _image != null
//           ? _image!.path
//           : "https://png.pngtree.com/png-vector/20240207/ourmid/pngtree-indoor-plant-flowerpot-png-image_11669796.png";

//       try {
//         Provider.of<AppProvider>(context, listen: false).addPlantFirebase(
//           imageUrl,
//           name,
//           soilType,
//           _selectedWeather,
//           _selectedCategories,
//           description,
//           _minTemp,
//           _maxTemp,
//         );

//         Fluttertoast.showToast(
//           msg: "Plant added successfully!",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//         );

//         _clearForm();
//       } catch (error) {
//         Fluttertoast.showToast(
//           msg: "Failed to add plant: $error",
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.BOTTOM,
//         );
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     } else {
//       Fluttertoast.showToast(
//         msg: "Please fill all fields and make selections!",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//       );
//     }
//   }

//   // Method to clear the form fields
//   void _clearForm() {
//     _nameController.clear();
//     _soilTypeController.clear();
//     _descriptionController.clear();
//     setState(() {
//       _image = null;
//       _selectedWeather.clear();
//       _selectedCategories.clear();
//       _minTemp = 20.0;
//       _maxTemp = 35.0;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Plant'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: CircleAvatar(
//                     radius: 60,
//                     backgroundColor: Colors.grey.shade200,
//                     child: _image != null
//                         ? ClipOval(
//                             child: Image.file(
//                               _image!,
//                               width: 120,
//                               height: 120,
//                               fit: BoxFit.cover,
//                             ),
//                           )
//                         : const Icon(
//                             Icons.camera_alt,
//                             size: 60,
//                             color: Colors.grey,
//                           ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: _pickImage,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Theme.of(context).primaryColor,
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 10),
//                     ),
//                     child: const Text(
//                       'Pick an Image',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: _nameController,
//                   decoration: const InputDecoration(labelText: 'Plant Name'),
//                   validator: (value) =>
//                       value == null || value.isEmpty ? 'Enter a name' : null,
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: _soilTypeController,
//                   decoration: const InputDecoration(labelText: 'Soil Type'),
//                   validator: (value) =>
//                       value == null || value.isEmpty ? 'Enter soil type' : null,
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: _descriptionController,
//                   decoration: const InputDecoration(labelText: 'Description'),
//                   validator: (value) => value == null || value.isEmpty
//                       ? 'Enter a description'
//                       : null,
//                 ),
//                 const SizedBox(height: 10),
//                 const Text('Select Weather Types:'),
//                 Wrap(
//                   spacing: 8.0,
//                   children: weatherTypes.map((weather) {
//                     return ChoiceChip(
//                       label: Text(weather),
//                       selected: _selectedWeather.contains(weather),
//                       onSelected: (selected) {
//                         setState(() {
//                           selected
//                               ? _selectedWeather.add(weather)
//                               : _selectedWeather.remove(weather);
//                         });
//                       },
//                     );
//                   }).toList(),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text('Select Categories:'),
//                 Wrap(
//                   spacing: 8.0,
//                   children: categoryTypes.map((category) {
//                     return ChoiceChip(
//                       label: Text(category),
//                       selected: _selectedCategories.contains(category),
//                       onSelected: (selected) {
//                         setState(() {
//                           selected
//                               ? _selectedCategories.add(category)
//                               : _selectedCategories.remove(category);
//                         });
//                       },
//                     );
//                   }).toList(),
//                 ),
//                 const SizedBox(height: 10),
//                 // Minimum Temperature Slider with value display
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text('Min Temp:'),
//                     Text('$_minTemp°C'), // Display the value dynamically
//                   ],
//                 ),
//                 Slider(
//                   value: _minTemp,
//                   min: -10,
//                   max: 50,
//                   divisions: 60,
//                   label: '$_minTemp°C',
//                   onChanged: (value) {
//                     setState(() {
//                       _minTemp = value;
//                     });
//                   },
//                 ),

// // Maximum Temperature Slider with value display
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text('Max Temp:'),
//                     Text('$_maxTemp°C'), // Display the value dynamically
//                   ],
//                 ),
//                 Slider(
//                   value: _maxTemp,
//                   min: -10,
//                   max: 50,
//                   divisions: 60,
//                   label: '$_maxTemp°C',
//                   onChanged: (value) {
//                     setState(() {
//                       _maxTemp = value;
//                     });
//                   },
//                 ),

//                 const SizedBox(height: 20),
//                 Center(
//                   child: _isLoading
//                       ? const CircularProgressIndicator()
//                       : ElevatedButton(
//                           onPressed: _submitPlant,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Theme.of(context).primaryColor,
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 50, vertical: 15),
//                           ),
//                           child: const Text(
//                             'Submit Plant',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

/////////////////////////////////////////////////////////
library;

import 'package:flutter/material.dart';
import 'package:ogaa/constants/colors.dart';
import 'package:ogaa/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';

class AddPlantScreen extends StatelessWidget {
  const AddPlantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Plants'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Call the function to add plants to Firebase
            await FirebaseFirestoreHelper.instance
                .addMultiplePlantsToFirebase();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                'Plants added successfully to Firebase!',
              )),
            );
          },
          child: const Text(
            'Upload Plants to Firebase',
            style: TextStyle(
              color: MyColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
