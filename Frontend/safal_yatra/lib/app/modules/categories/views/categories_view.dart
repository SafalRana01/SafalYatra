import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/custom_button.dart';
import '../controllers/categories_controller.dart';

class CategoriesView extends GetView<CategoriesController> {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoriesController controller = Get.put(CategoriesController());

    return Scaffold(
      backgroundColor: const Color(0xFFF3F2FA),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: AppColors.buttonColor,
        automaticallyImplyLeading: false,
        title: const Text(
          'Categories',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontFamily: "Inter",
          ),
        ),
        centerTitle: true,
      ),

      // code start for showing list of categories start from (37 - 218) which is commented for now
      body: GetBuilder<CategoriesController>(
        builder: (controller) {
          if (controller.categoriesResponse == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.buttonColor,
              ),
            );
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 15),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      controller.categoriesResponse?.categories?.length ?? 0,
                  itemBuilder: (context, index) {
                    var category =
                        controller.categoriesResponse!.categories![index];
                    var isDeleted = category.isDeleted == '1';

                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 8, horizontal: Get.width / 30),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width / 20, vertical: 18),
                        constraints: const BoxConstraints(minHeight: 50),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          border: Border.all(
                              color: const Color.fromRGBO(63, 93, 169, 255)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  category.categoryName ?? "",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Inter",
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Added Date:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Inter",
                                        color: Color.fromARGB(255, 86, 85, 85),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      category.addedDate != null
                                          ? DateFormat('yyyy-MMM-dd')
                                              .format(category.addedDate!)
                                          : '',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        isDeleted
                                            ? 'Restore Confirmation'
                                            : 'Delete Confirmation',
                                        style: TextStyle(
                                            fontFamily: 'Inter', fontSize: 20),
                                      ),
                                      content: Text(
                                        isDeleted
                                            ? 'Are you sure you want to restore this category?'
                                            : 'Are you sure you want to hide this category?',
                                        style: TextStyle(
                                            fontFamily: 'Inter', fontSize: 14),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () => Get.close(1),
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            backgroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () {
                                            controller.updateCategoryStatus(
                                              category.categoryId!,
                                              !isDeleted,
                                            );
                                            Get.close(1);
                                          },
                                          child: const Text(
                                            'Confirm',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(
                                isDeleted ? Icons.restore : Icons.delete,
                                color: !isDeleted ? Colors.red : Colors.green,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.buttonColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const AddCategoryDialog();
            },
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class AddCategoryDialog extends StatelessWidget {
  const AddCategoryDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoriesController>();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          // Wrap in Form widget
          key: controller.formKey, // Assign formKey correctly
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Category',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.buttonColor),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: controller.categoryTitle,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter category name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Category Name',
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                onTap: () {
                  controller.addCategory();
                },
                title: 'Add Category',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
