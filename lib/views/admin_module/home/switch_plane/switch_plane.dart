import 'package:air_log/helpers/helpers/genenal_helpers.dart';
import 'package:air_log/views/universal_screens/authorization_screens/auth_handler.dart';
import 'package:air_log/views/widgets/custom_loader.dart';
import 'package:air_log/views/widgets/dialogs/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../constant/colors.dart';
import '../../../../providers/plane_provider.dart';
import '../../../widgets/custom_button.dart';

class AdminSwitchPlaneNumber extends StatefulWidget {
  const AdminSwitchPlaneNumber({super.key});

  @override
  State<AdminSwitchPlaneNumber> createState() => _AdminSwitchPlaneNumberState();
}

class _AdminSwitchPlaneNumberState extends State<AdminSwitchPlaneNumber> {
  List<Map<String, String>> availablePlanes = [
    {'number': 'PL123', 'type': 'Boeing 737'},
    {'number': 'PL124', 'type': 'Airbus A320'},
    {'number': 'PL125', 'type': 'Boeing 747'},
    {'number': 'PL126', 'type': 'Airbus A330'},
    {'number': 'PL127', 'type': 'Boeing 777'},
    {'number': 'PL128', 'type': 'Airbus A350'},
  ];

  String selectedPlaneNumber = '';

  @override
  Widget build(BuildContext context) {
    final planeProvider = Provider.of<PlaneProvider>(context);
    selectedPlaneNumber = planeProvider.planeNumber;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Select Plane Number',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        backgroundColor: Pallete.primaryColor,
      ),
      body: ListView.builder(
        itemCount: availablePlanes.length,
        itemBuilder: (context, index) {
          final plane = availablePlanes[index];
          selectedPlaneNumber = plane['number'].toString();
          return planeWidget(
            onTap: () {

              print(selectedPlaneNumber);
              showDialog(
                  context: context,
                  builder: (context){
                    return CustomConfirmationDialog(
                      message: 'Are you sure you want to select plane number $selectedPlaneNumber ?',
                        onYesConfirmTap: () async {
                          final selectedPlane = availablePlanes.firstWhere(
                                (plane) => plane['number'] == selectedPlaneNumber,
                            orElse: () => {'number': '', 'type': ''},
                          );
                          await planeProvider.setPlane(selectedPlane['number']!, selectedPlane['type']!);
                          Navigator.of(context).pop();
                          Helpers.permanentNavigator(context, AuthHandler());
                        },
                        onNoTap: ()=> Navigator.of(context).pop(),
                        yesConfirmText: 'Yes',
                        noText: 'No'
                    );
                  }
              );
            },
            color: selectedPlaneNumber != plane['number']
                ? Pallete.primaryColor
                : Colors.white,
            textIconColour: selectedPlaneNumber != plane['number']
                ? Colors.white
                : Pallete.primaryColor,
            title: plane['number'].toString(),
            subtitle: plane['type'].toString(),
            icon: FontAwesomeIcons.planeDeparture,
          );
        },
      ),
    );
  }

  Widget planeWidget({
    required Color color,
    required Color textIconColour,
    required void Function() onTap,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Pallete.primaryColor),
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(color: textIconColour, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(color: Colors.grey),
          ),
          leading: Icon(
            icon,
            color: textIconColour,
          ),
        ),
      ),
    );
  }
}