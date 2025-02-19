import 'package:rider/controller/socket_controller.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/pages/chat/chat_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  final String rideId;
  const ChatScreen({
    super.key,
    required this.rideId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();
  final _socketController = Get.find<SocketController>();
  @override
  void initState() {
    _socketController.joinRoom(roomId: widget.rideId);
    _socketController.getChatHistory(widget.rideId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          "Clara Smith",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          const Icon(Icons.call),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Get.to(() => ChatMenuScreen());
            },
            child: const Icon(Icons.more_vert_sharp),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.topRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      color: AppColors.primaryColor,
                    ),
                    constraints: const BoxConstraints(
                      minHeight: 45,
                      maxWidth: 250,
                    ),
                    child: const Text(
                      "Hello Baby Girl, How're You sf ejh wasom uf wuwe spe bwew ofn ier krw ofrr sdhe wewej kde r weuwf fiowfr wiwe virk nnei dhe winfo",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    "3:45 PM",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    constraints: const BoxConstraints(
                      minHeight: 45,
                      maxWidth: 250,
                    ),
                    child: const Text(
                      "Hello Baby Girl, How're You sf ejh wo",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    "3:45 PM",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Obx(
              () => _socketController.chatModelList.isEmpty ? const SizedBox.shrink():   Expanded(
                child: ListView.builder(
                  itemCount: _socketController.chatModelList.length,
                  itemBuilder: (context, index) {
                    return Text(
                      _socketController.chatModelList[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
            ),
            TextFormField(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              controller: _textController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.grey,
                  ),
                ),
                hintText: "Type here",
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    width: 2,
                    color: AppColors.primaryColor,
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    _socketController.sendMessage(
                      message: _textController.text,
                      rideId: widget.rideId,
                    );
                    _textController.clear();
                  },
                  icon: Icon(
                    FontAwesomeIcons.paperPlane,
                    size: 18,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
