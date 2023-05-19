import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_corner/Components/pets_controller.dart';
import 'package:app_corner/routes/app_pages.dart';

class YourPets extends GetView<PetsController> {
  const YourPets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Get.toNamed(AppPages.HOME);
          },
          color: Colors.black
        ),
        title: Align(
          alignment: Alignment.centerRight,
          child: Stack(children: [
            Text(
              //Texto de bienvenida
              "PetFeed",
              style: TextStyle(
                fontSize: 40.0,
                fontFamily: 'LilitaOne',
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 5
                  ..color = Colors.black,
              ),
            ),
            Text(
              //Texto de bienvenida
              "PetFeed",
              style: TextStyle(
                fontSize: 40.0,
                fontFamily: 'LilitaOne',
                letterSpacing: 1.0,
                color: Colors.grey[100],
              ),
            ),
          ]),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: const Text(
                    "Your pets:",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontFamily: 'JosefinSans',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10.0),

          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.itemCount.value,
              itemBuilder: ((context, index) {
                final cat = controller.cats.value[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: ListTile(
                      title: Text(
                        controller.cats.value[index].name,
                        style: TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'JosefinSans',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                        color: Colors.grey[800],
                        ),
                      ),
                      trailing: GestureDetector(
                        child: const Icon(
                          Icons.delete, 
                          color: Colors.black,
                        ),
                        onTap: () {
                          controller.removeCat(index);
                        },
                      ),
                      leading: const CircleAvatar(  
                        backgroundImage: AssetImage(
                        "images/profile.jpg",  //TODO: Hacer que esto se pueda cambiar a gusto
                        ),
                        radius: 30.0,
                      ),
                      contentPadding: EdgeInsets.all(15.0),
                      tileColor: Colors.grey[350],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                      onTap: () {
                        Get.toNamed(AppPages.PET, arguments: cat);
                      },
                    ),
                  ),
                );
              })
            )),
          ),
        ],
      ),
    );
  }
}
