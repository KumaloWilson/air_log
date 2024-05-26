import 'package:air_log/helpers/flight_helpers.dart';
import 'package:air_log/helpers/helpers/genenal_helpers.dart';
import 'package:air_log/views/admin_module/home/total_employees/total_employees.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [

              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: ()=> Helpers.temporaryNavigator(context, const TotalEmployees()),
                      child: Container(
                        child: const Text(
                            'Total Employees'
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      child: const Text(
                          'Total Check in'
                      ),
                    ),
                  )
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: const Text(
                        'Total Employees'
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      child: const Text(
                        'Total Check in'
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}
