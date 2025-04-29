import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BoardingScreenView extends StatelessWidget {
  BoardingScreenView({Key? key}) : super(key: key);

  final RxString selectedRole = ''.obs;

  final List<Map<String, dynamic>> roles = [
    {'label': 'Login as user', 'icon': Icons.person_outline, 'route': 'user'},
    {
      'label': 'Login as car-operator',
      'icon': MdiIcons.carMultiple,
      'route': 'operator'
    },
    {'label': 'Login as driver', 'icon': MdiIcons.steering, 'route': 'driver'},
    {
      'label': 'Login as admin',
      'icon': Icons.admin_panel_settings,
      'route': 'admin'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              // App name
              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Safal',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: "Agbalumo",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'Yatra',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: "Agbalumo",
                          fontWeight: FontWeight.bold,
                          color: AppColors.buttonColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // const SizedBox(height: 10),

              const SizedBox(height: 30),

              // Motto
              const Text(
                'Your journey, our responsibility.',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),
              const SizedBox(height: 30),

              // // Full-width image
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(12),
              //   child: Image.asset(
              //     'lib/assets/images/test3.jpg',
              //     width: double.infinity,
              //     // width: 300,
              //     height: 310,
              //     fit: BoxFit.cover,
              //     // fit: BoxFit.scaleDown,
              //   ),
              // ),

              Center(
                child: Lottie.asset(
                  'lib/assets/animation/start.json',
                  // height: 300,
                  // width: 300
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 40),
              const SizedBox(height: 60),

              // Beautiful Dropdown
              Obx(() => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.buttonColor,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.buttonColor.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded,
                            color: Colors.white),
                        dropdownColor: AppColors.buttonColor,
                        borderRadius: BorderRadius.circular(12),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                        value: selectedRole.value.isEmpty
                            ? null
                            : selectedRole.value,
                        hint: const Text(
                          '🔐 Choose Login Role',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        items: roles.map((role) {
                          return DropdownMenuItem<String>(
                            value: role['label'],
                            child: Row(
                              children: [
                                Icon(role['icon'], color: Colors.white),
                                const SizedBox(width: 10),
                                Text(role['label']),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            selectedRole.value = value;
                            final selectedMap =
                                roles.firstWhere((r) => r['label'] == value);
                            Get.toNamed(Routes.LOGIN_PAGE,
                                arguments: {'role': selectedMap['route']});
                          }
                        },
                      ),
                    ),
                  )),

              const SizedBox(height: 60),

              // const Text(
              //   'By signing in, You accept our Terms of',
              //   style: TextStyle(
              //     fontSize: 14,
              //     fontWeight: FontWeight.w600,
              //     fontFamily: 'Inter',
              //   ),
              // ),
              // const Text(
              //   'Use and Privacy Policy',
              //   style: TextStyle(
              //     fontSize: 14,
              //     fontWeight: FontWeight.w600,
              //     fontFamily: 'Inter',
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
