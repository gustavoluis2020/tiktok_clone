import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/components/colors/colors_app.dart';
import 'package:tiktok_clone/app/models/user_model.dart';
import 'package:tiktok_clone/app/routes/app_routes.dart';
import 'package:tiktok_clone/app/components/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:tiktok_clone/app/ui/search/search_controller.dart';

class SearchPage extends GetView<SearchController2> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        return Scaffold(
          bottomNavigationBar: BottomNavBar(),
          appBar: AppBar(
            titleSpacing: 6,
            backgroundColor: AppColors.primary,
            title: TextFormField(
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent, width: 2),
                  borderRadius: BorderRadius.circular(6),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent, width: 2),
                  borderRadius: BorderRadius.circular(6),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent, width: 2),
                  borderRadius: BorderRadius.circular(6),
                ),
                hintText: 'Busca',
                hintStyle: const TextStyle(fontSize: 18, color: Colors.white),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              onFieldSubmitted: (textInput) {
                controller.searchForUser(textInput);
              },
            ),
          ),
          body: controller.userSearchList.isEmpty
              ? const Center(child: Icon(Icons.search, color: AppColors.primary, size: 160))
              : ListView.builder(
                  itemCount: controller.userSearchList.length,
                  itemBuilder: (context, index) {
                    UserModel eachSearchUserRecord = controller.userSearchList[index];

                    return Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 4),
                      child: Card(
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(
                              Routes.profilePage,
                              arguments: eachSearchUserRecord.uid.toString(),
                            );
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                eachSearchUserRecord.image.toString(),
                              ),
                            ),
                            title: Text(
                              eachSearchUserRecord.name!,
                              style: const TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            subtitle: Text(
                              eachSearchUserRecord.email!,
                              style: const TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.navigate_next_outlined,
                                size: 30,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      }),
    );
  }
}
