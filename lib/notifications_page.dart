import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> notifications = [
      "🔥 New arrivals in Sneakers section!",
      "🎉 20% off on Football shoes this weekend!",
      "🛒 Your cart has items waiting!",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: notifications.isEmpty
          ? Center(child: Text("No new notifications."))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) => ListTile(
                leading: Icon(Icons.notifications, color: Colors.black),
                title: Text(notifications[index]),
              ),
            ),
    );
  }
}
