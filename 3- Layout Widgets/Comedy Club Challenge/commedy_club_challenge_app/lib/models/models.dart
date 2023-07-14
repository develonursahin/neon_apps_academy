class Event {
  String? eventName;
  String? eventImageUrl;
  List<Ticket>? tickets;
  DateTime? dateTime;
  Event({
    required this.eventName,
    required this.eventImageUrl,
    required this.tickets,
    required this.dateTime,
  });
}

class Ticket {
  String? ticketName;
  int? ticketPiece;
  double? ticketPrice;
  Ticket({
    required this.ticketName,
    required this.ticketPiece,
    required this.ticketPrice,
  });
}
