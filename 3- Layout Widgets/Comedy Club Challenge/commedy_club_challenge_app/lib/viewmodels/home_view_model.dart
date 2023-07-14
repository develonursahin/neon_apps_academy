import 'package:commedy_club_challenge_app/models/models.dart';

class HomeViewModel {
  List<Event> events = [
    Event(
        eventName: "Güldür Güldür",
        eventImageUrl:
            "https://mo.ciner.com.tr/showturk/iu/1020x510/guldur-guldur.jpg?v=1688769440",
        tickets: [
          Ticket(ticketName: "VIP", ticketPiece: 80, ticketPrice: 670),
          Ticket(ticketName: "Economy", ticketPiece: 20, ticketPrice: 450),
        ],
        dateTime: DateTime(2023, 1, 28)),
    Event(
        eventName: "Çok Güzel Hareketler Bunlar",
        eventImageUrl:
            "https://i.hbrcdn.com/haber/2021/02/14/cok-guzel-hareketler-bunlar-canli-izle-kanal-d-13926938_145_amp.jpg",
        tickets: [
          Ticket(ticketName: "VIP", ticketPiece: 80, ticketPrice: 670),
          Ticket(ticketName: "Economy", ticketPiece: 20, ticketPrice: 450),
        ],
        dateTime: DateTime(2020, 6, 14)),
    Event(
        eventName: "Zafer Algöz & Can Yılmaz ile Ormanda Stand-Up",
        eventImageUrl:
            "https://cdn.bubilet.com.tr/files/Etkinlik/zafer-algoz-can-yilmaz-ile-ormanda-stand-up-13065.jpg",
        tickets: [
          Ticket(ticketName: "VIP", ticketPiece: 80, ticketPrice: 500),
          Ticket(ticketName: "Economy", ticketPiece: 20, ticketPrice: 250),
        ],
        dateTime: DateTime(2023, 7, 16)),
    Event(
        eventName: "Rota Stand Up Gecesi",
        eventImageUrl:
            "https://cdn.bubilet.com.tr/files/Etkinlik/rota-stand-up-gecesi-42760.png",
        tickets: [
          Ticket(ticketName: "VIP", ticketPiece: 80, ticketPrice: 220),
          Ticket(ticketName: "Economy", ticketPiece: 20, ticketPrice: 163),
        ],
        dateTime: DateTime(2023, 5, 5)),
    Event(
        eventName: "Taksim Açık Mikrofon",
        eventImageUrl:
            "https://cdn.bubilet.com.tr/files/Etkinlik/taksim-acik-mikrofon-68141.jpg",
        tickets: [
          Ticket(ticketName: "VIP", ticketPiece: 80, ticketPrice: 110),
          Ticket(ticketName: "Economy", ticketPiece: 20, ticketPrice: 56),
        ],
        dateTime: DateTime(2023, 7, 23)),
    Event(
        eventName: "Beşiktaş Stand Up Gecesi",
        eventImageUrl:
            "https://cdn.bubilet.com.tr/files/Etkinlik/besiktas-stand-up-gecesi-97829.jpeg",
        tickets: [
          Ticket(ticketName: "VIP", ticketPiece: 80, ticketPrice: 170),
          Ticket(ticketName: "Economy", ticketPiece: 20, ticketPrice: 110),
        ],
        dateTime: DateTime(2023, 2, 11)),
    Event(
        eventName: "Cem Adrian",
        eventImageUrl:
            "https://upload.wikimedia.org/wikipedia/commons/f/fd/Cem_Adrian.jpg",
        tickets: [
          Ticket(ticketName: "VIP", ticketPiece: 100, ticketPrice: 500),
          Ticket(ticketName: "Economy", ticketPiece: 10, ticketPrice: 180),
        ],
        dateTime: DateTime(2023, 9, 30)),
    Event(
        eventName: "Yıldız Tilbe",
        eventImageUrl:
            "https://upload.wikimedia.org/wikipedia/commons/7/7f/Y%C4%B1ld%C4%B1z_Tilbe_-_Konser01_%28cropped%29.jpg",
        tickets: [
          Ticket(ticketName: "VIP", ticketPiece: 80, ticketPrice: 480),
          Ticket(ticketName: "Economy", ticketPiece: 20, ticketPrice: 190),
        ],
        dateTime: DateTime(2023, 12, 25)),
  ];

}
