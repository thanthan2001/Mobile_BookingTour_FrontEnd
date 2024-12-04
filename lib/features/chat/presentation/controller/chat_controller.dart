import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/services/api_service.dart';
import 'package:reading_app/core/services/models/authentication_model.dart';
import 'package:reading_app/core/services/models/message_model.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  final GetuserUseCase _getUserUseCase;
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  RxList<MessageModel> messages = <MessageModel>[].obs;
  RxBool isConnected = false.obs;
  late IO.Socket socket;
  late String userId;
  late AuthenticationModel? authModel;

  ChatController(this._getUserUseCase);

  @override
  void onInit() {
    super.onInit();
    initializeChat();
  }

  // Khởi tạo chức năng chat
  void initializeChat() async {
    authModel = await _getUserUseCase.getToken();
    if (authModel == null || authModel!.metadata.isEmpty) {
      print("Error: Token is missing");
      return;
    }

    userId = authModel!.idUser; // Đảm bảo rằng `idUser` là đúng tên trường
    connectToSocket();
    await fetchOldMessages('66ed4a45ee69c51c9f156920');
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  // Kết nối với Socket.IO
  void connectToSocket() {
    socket = IO.io('http://10.0.2.2:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'auth': {'token': authModel!.metadata}, // Đảm bảo metadata chứa token
    });

    socket.connect();

    // Xử lý sự kiện kết nối thành công
    socket.onConnect((_) {
      isConnected.value = true;
      print('Kết nối thành công với socket server');
      socket.emit('join', userId);
    });

    // Xử lý lỗi kết nối
    socket.onConnectError((error) {
      print('Lỗi kết nối socket: $error');
    });

    // Xử lý sự kiện nhận tin nhắn
    socket.on('receiveMessage', (data) {
      messages.add(MessageModel.fromJson(data));
    });

    // Xử lý sự kiện mất kết nối
    socket.onDisconnect((_) {
      isConnected.value = false;
      print('Mất kết nối với socket server');
    });
  }

  // Gửi tin nhắn
  void sendMessage() {
    if (messageController.text.trim().isEmpty ||
        messageController.text.length > 500) {
      print("Tin nhắn trống hoặc quá dài");
      return;
    }

    final messageData = {
      'senderId': userId,
      'receiverId':
          '66ed4a45ee69c51c9f156920', // Thay thế với ID người nhận thực tế nếu cần
      'content': messageController.text.trim(),
    };

    socket.emit('sendMessage', messageData);
    messageController.clear();
    scrollToBottom(); // Cuộn xuống cuối khi gửi tin nhắn mới
  }

// Hàm để lấy tin nhắn cũ

  Future<void> fetchOldMessages(String receiverId) async {
    final authModel = await _getUserUseCase.getToken();
    userId = authModel!.idUser;
    if (authModel == null || authModel.metadata.isEmpty) {
      print("Error: Token is missing");
      return;
    }

    final apiService = ApiService("http://10.0.2.2:3000", authModel.metadata);
    final String endpoint = "/messages/$userId/$receiverId";

    try {
      final response = await apiService.getDataJSON(endpoint);
      if (response["success"] == true && response["data"] != null) {
        // Sắp xếp tin nhắn theo thứ tự createdAt từ cũ đến mới
        messages.value = List<MessageModel>.from(
            response["data"].map((json) => MessageModel.fromJson(json)))
          ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

        print("Old messages fetched successfully: " +
            messages.map((e) => e.content).toString());
      } else {
        print("Error fetching old messages: ${response["message"]}");
      }
    } catch (e) {
      print("Error 1: $e");
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    socket.dispose();
    super.onClose();
  }
}
