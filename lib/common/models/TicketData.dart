import 'package:flutter/material.dart';

class TicketData {
  final String imageUrl;
  final String title;
  final String location;
  final String statusLabel;
  final Color statusColor;
  final String date;
  final String time;
  final String ticketNumber;

  const TicketData({
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.statusLabel,
    required this.statusColor,
    required this.date,
    required this.time,
    required this.ticketNumber,
  });
}