// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:image_picker/image_picker.dart';

// class JsonHome extends StatefulWidget {
//   const JsonHome({super.key});

//   @override
//   State<JsonHome> createState() => _JsonHomeState();
// }

// class _JsonHomeState extends State<JsonHome> {
//   List<dynamic> contactsList = [];
//   List<bool> _showOptions = [];
//   TextEditingController nameUp = TextEditingController();
//   TextEditingController phoneUp = TextEditingController();
//   TextEditingController nameCrt = TextEditingController();
//   TextEditingController phoneCrt = TextEditingController();
//   String? imagePathCrt;

//   @override
//   void initState() {
//     super.initState();
//     readJSON();
//   }

//   Future<void> pickImage(ImageSource source) async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? pickedFile = await picker.pickImage(source: source);

//     if (pickedFile != null) {
//       setState(() {
//         imagePathCrt = pickedFile.path;
//       });
//     }
//   }

//   Future<void> readJSON() async {
//     final Directory? appDir = await getDownloadsDirectory();
//     final File file = File('${appDir?.path}/contacts.json');
//     try {
//       String parsedJson = await file.readAsString();
//       setState(() {
//         contactsList = jsonDecode(parsedJson);
//         _showOptions = List.generate(contactsList.length, (index) => false);
//       });
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Failed to read contacts: $e");
//     }
//   }

//   Future<void> callJson() async {
//     final Directory? appDirectory = await getDownloadsDirectory();
//     final File file = File('${appDirectory?.path}/contacts.json');
//     String reParsedJson = jsonEncode(contactsList);
//     await file.writeAsString(reParsedJson);
//   }

//   void makePhoneCall(String tel) async {
//     if (await canLaunchUrl(Uri.parse(tel))) {
//       await launchUrl(Uri.parse(tel));
//     } else {
//       Fluttertoast.showToast(msg: "Could not launch phone dialer");
//     }
//   }

//   void updateJson(int index) {
//     nameUp.text = contactsList[index]['name'];
//     phoneUp.text = contactsList[index]['phone'];
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: Colors.blueGrey[800],
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         title: const Align(
//             alignment: Alignment.center,
//             child:
//                 Text('Update Contact', style: TextStyle(color: Colors.white))),
//         content: SizedBox(
//           height: 130,
//           child: Column(
//             children: [
//               TextField(
//                 controller: nameUp,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: const InputDecoration(
//                   labelText: 'Name',
//                   labelStyle: TextStyle(color: Colors.white),
//                 ),
//               ),
//               TextField(
//                 controller: phoneUp,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: const InputDecoration(
//                   labelText: 'Phone No.',
//                   labelStyle: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           ElevatedButton(
//               onPressed: () async {
//                 if (nameUp.text.isNotEmpty && phoneUp.text.isNotEmpty) {
//                   setState(() {
//                     contactsList[index]['name'] = nameUp.text;
//                     contactsList[index]['phone'] = phoneUp.text;
//                     callJson(); // Save changes
//                   });
//                   Navigator.pop(context);
//                 } else {
//                   Fluttertoast.showToast(msg: "Please enter a value");
//                 }
//               },
//               child: const Text("Update")),
//         ],
//       ),
//     );
//   }

//   void deleteJson(int index) async {
//     setState(() {
//       contactsList.removeAt(index);
//     });
//     callJson();
//   }

//   void addJson() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: Colors.blueGrey[800],
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         title: const Align(
//             alignment: Alignment.center,
//             child:
//                 Text('Create Contact', style: TextStyle(color: Colors.white))),
//         content: SizedBox(
//           height: 250,
//           child: Column(
//             children: [
//               GestureDetector(
//                 onTap: () => showModalBottomSheet(
//                   context: context,
//                   builder: (context) => Wrap(
//                     children: [
//                       ListTile(
//                         leading: const Icon(Icons.camera_alt),
//                         title: const Text('Camera'),
//                         onTap: () {
//                           pickImage(ImageSource.camera);
//                           Navigator.pop(context);
//                         },
//                       ),
//                       ListTile(
//                         leading: const Icon(Icons.photo_library),
//                         title: const Text('Gallery'),
//                         onTap: () {
//                           pickImage(ImageSource.gallery);
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 child: Center(
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundImage: imagePathCrt != null
//                         ? FileImage(File(imagePathCrt!))
//                         : null,
//                     child: imagePathCrt == null
//                         ? const Icon(Icons.add_a_photo, size: 50)
//                         : null,
//                   ),
//                 ),
//               ),
//               TextField(
//                 controller: nameCrt,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: const InputDecoration(
//                   labelText: 'Name',
//                   labelStyle: TextStyle(color: Colors.white),
//                 ),
//               ),
//               TextField(
//                 controller: phoneCrt,
//                 keyboardType: TextInputType.number,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: const InputDecoration(
//                   labelText: 'Phone No.',
//                   labelStyle: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           ElevatedButton(
//               onPressed: () async {
//                 if (nameCrt.text.isNotEmpty && phoneCrt.text.isNotEmpty) {
//                   setState(() {
//                     contactsList.add({
//                       "photo": imagePathCrt,
//                       "name": nameCrt.text,
//                       "phone": phoneCrt.text,
//                     });
//                     callJson();
//                     readJSON();
//                     imagePathCrt = null;
//                     nameCrt.clear();
//                     phoneCrt.clear();
//                   });
//                   Navigator.pop(context);
//                 } else {
//                   Fluttertoast.showToast(msg: "Please enter a value");
//                 }
//               },
//               child: const Text("Create")),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Contacts'),
//           backgroundColor: Colors.blueGrey[900],
//         ),
//         body: ListView.builder(
//           itemCount: contactsList.length,
//           itemBuilder: (context, index) => Card(
//             color: Colors.blueGrey[800],
//             margin: const EdgeInsets.all(10),
//             child: ListTile(
//               onTap: () => setState(() {
//                 _showOptions[index] = !_showOptions[index];
//               }),
//               title: Text(contactsList[index]['name'],
//                   style: const TextStyle(color: Colors.white)),
//               subtitle: Text(contactsList[index]['phone'],
//                   style: const TextStyle(color: Colors.white)),
//               leading: CircleAvatar(
//                 backgroundImage: contactsList[index]['photo'] != null
//                     ? FileImage(File(contactsList[index]['photo']))
//                     : null,
//               ),
//               trailing: _showOptions[index]
//                   ? Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.phone, color: Colors.white),
//                           onPressed: () => makePhoneCall(
//                               'tel:${contactsList[index]['phone']}'),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.edit, color: Colors.white),
//                           onPressed: () => updateJson(index),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete, color: Colors.red),
//                           onPressed: () => deleteJson(index),
//                         ),
//                       ],
//                     )
//                   : null,
//             ),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.blueGrey[900],
//           onPressed: addJson,
//           child: const Icon(Icons.add),
//         ),
//       ),
//     );
//   }
// }
