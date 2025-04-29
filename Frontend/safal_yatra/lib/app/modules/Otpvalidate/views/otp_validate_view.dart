import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/custom_button.dart';

import '../controllers/otp_validate_controller.dart';

class OtpValidateView extends GetView<OtpValidateController> {
  const OtpValidateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: AppColors.buttonColor,
        automaticallyImplyLeading: false,
        title: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const Text(
                'Verify Your Email',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Inter",
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: Get.height * 0.8,
          ),
          child: Column(
            children: [
              ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  AppColors
                      .backGroundColor, // Set the desired color for filtering
                  BlendMode.darken,
                ),
                child: Lottie.asset(
                  'lib/assets/animation/otp_code.json'

                
               
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Please enter the 6 digit code sent to',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${controller.code?['email'] ?? ''}',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: controller.formKey,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 30,
                    ),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      blinkWhenObscuring: true,
                      validator: (v) {
                        if (v!.length < 6) {
                          return "OTP must be of 6 digits";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        inactiveColor: const Color.fromARGB(255, 63, 112, 198),
                        // inactiveColor: Colors.black,

                        selectedColor: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,

                        activeFillColor:
                            Colors.transparent, // Set transparent color
                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      errorAnimationController: controller.errorController,
                      controller: controller.textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        debugPrint("Completed");
                      },
                      onTap: () {
                        print("Pressed");
                      },
                      onChanged: (value) {
                        debugPrint(value);
                        controller.currentText = value;
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        print('167843');
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Obx(() => CustomButton(
                  isLoading: controller.isLoading.value,
                  title: 'Verify OTP',
                  onTap: () {
                    controller.onVerifyOTP();
                  }))
            ],
          ),
        ),
      ),
    );
  }
}