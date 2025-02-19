import 'package:intl/intl.dart';
import 'package:rider/controller/socket_controller.dart';
import 'package:rider/controller/user_controller.dart';
import 'package:rider/models/chat_model.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/pages/chat/chat_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rider/widgets/snack_bar.dart';

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
  final _userController = Get.find<UserController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _socketController.joinRoom(roomId: widget.rideId);
    _socketController.getChatHistory(widget.rideId);
    super.initState();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true, // 🔥 Resize screen for keyboard
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          "Clara Smith",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // Hide keyboard on tap
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (_socketController.chatModelList.isEmpty) {
                  return const Center(
                    child: Text(
                      "No messages yet",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) => _scrollToBottom(),
                  );
                  return ListView.builder(
                    controller: _scrollController,
                    reverse: false,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    itemCount: _socketController.chatModelList.length,
                    itemBuilder: (context, index) {
                      ChatModel chatModel =
                          _socketController.chatModelList[index];
                      final isSender = chatModel.sender ==
                          _userController.userModel.value?.id;
                      return isSender
                          ? SenderCard(chat: chatModel)
                          : ReceiverCard(chat: chatModel);
                    },
                  );
                }
              }),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewPadding.bottom,
                left: 15,
                right: 15,
                top: 10,
              ),
              child: TextFormField(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                controller: _textController,
                maxLines: null,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.grey),
                  ),
                  hintText: "Type here",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 2,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (_socketController.socket?.disconnected == true) {
                        return CustomSnackbar.showErrorSnackBar(
                          "Socket disconnected",
                        );
                      }
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
            ),
          ],
        ),
      ),
    );
  }
}

class ReceiverCard extends StatelessWidget {
  final ChatModel chat;
  const ReceiverCard({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IntrinsicWidth(
        // Auto-size based on content
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chat.message,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                DateFormat("hh:mma").format(chat.timestamp),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SenderCard extends StatelessWidget {
  final ChatModel chat;
  const SenderCard({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: IntrinsicWidth(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chat.message,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                DateFormat("hh:mma").format(chat.timestamp),
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
