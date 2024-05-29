import 'dart:developer';
import 'dart:io';
import 'package:air_log/api_services/flight_services/chat_services.dart';
import 'package:air_log/helpers/helpers/genenal_helpers.dart';
import 'package:air_log/models/flight_check_in_model.dart';
import 'package:air_log/providers/userprofile_provider.dart';
import 'package:air_log/views/universal_screens/authorization_screens/auth_handler.dart';
import 'package:air_log/views/widgets/custom_loader.dart';
import 'package:air_log/views/widgets/dialogs/confirmation_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerCheckOutScreen extends StatefulWidget {
  const QRScannerCheckOutScreen({super.key,});

  @override
  _QRScannerCheckOutScreenState createState() => _QRScannerCheckOutScreenState();
}

class _QRScannerCheckOutScreenState extends State<QRScannerCheckOutScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late UserProfileProvider userProfileProvider;
  late CrewScheduleEntry crewMemberEntry;
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void initState() {
    super.initState();
    userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: scanArea
          ),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),

        Positioned(
          top: 32,
          left: 8,
          right: 0,
          child: ListTile(
            leading: Builder(
              builder: (context){
                return Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                  ),
                  child: IconButton(
                      onPressed: ()=> Helpers.back(context),
                      icon: const Icon(
                          Icons.arrow_back
                      )
                  ),
                );
              },
            ),



            trailing: FutureBuilder(
                future: controller?.getFlashStatus(),
                builder: (context, snapshot) {
                  return Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                    ),
                    child: IconButton(
                        onPressed: ()async {
                          await controller?.toggleFlash();
                        },
                        icon: Icon(
                            snapshot.data == true
                                ? Icons.flash_on
                                : Icons.flash_off
                        )
                    ),
                  );
                }
            ),
          ),
        )
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if(result != null){
        controller.pauseCamera();
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context){
              return CustomConfirmationDialog(
                  message: "Would you like to check out Flight No\n ${result!.code}",
                  onYesConfirmTap: () async{
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const CustomLoader(message: 'Checking in');
                        }
                    );

                    final userProfile = userProfileProvider.userProfile;

                    FlightServices.checkout(uid: currentUser!.uid, signatureOut: userProfile!.fullName.split(' ').last,).then((entryResponse) {
                      Navigator.of(context).pop(); // Pop CustomLoader
                      Navigator.of(context).pop(); // Pop CustomConfirmationDialog
                      if (entryResponse == 'success') {
                        Helpers.permanentNavigator(context, const AuthHandler());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Check-out failed: $entryResponse'))
                        );
                      }
                    }).catchError((error) {
                      Navigator.of(context).pop(); // Pop CustomLoader
                      Navigator.of(context).pop(); // Pop CustomConfirmationDialog
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $error'))
                      );
                    });

                  },
                  onNoTap: (){
                    controller.resumeCamera();
                    Helpers.back(context);
                  },
                  yesConfirmText: 'Yes',
                  noText: 'No'
              );
            }
        );
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}