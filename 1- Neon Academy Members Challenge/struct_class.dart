import 'dart:io';

class NeonAcademyMember {
  String fullName = "",
      title = "",
      horoscope = "",
      memberLevel = "",
      homeTown = "";
  int age = 0, id;
  ContactInformation? contactInformation;

  NeonAcademyMember({
    required this.id,
    required this.age,
    required this.contactInformation,
    required this.fullName,
    required this.homeTown,
    required this.horoscope,
    required this.memberLevel,
    required this.title,
  });
}

class ContactInformation {
  String phoneNumber, email;
  ContactInformation({required this.email, required this.phoneNumber});
}

List<NeonAcademyMember> members = [];

ContactInformation c1 = ContactInformation(
    email: 'derinonursahin@gmail.com', phoneNumber: '+90 538 206 91 20');

NeonAcademyMember m1 = NeonAcademyMember(
    id: 1,
    age: 24,
    contactInformation: c1,
    fullName: "Onur Şahin",
    homeTown: "Sivas",
    horoscope: "Yengeç",
    memberLevel: "A1",
    title: "Flutter Developer");

ContactInformation c2 = ContactInformation(
    email: 'member2@gmail.com', phoneNumber: '+90 522 222 22 22');

NeonAcademyMember m2 = NeonAcademyMember(
    id: 2,
    age: 100,
    contactInformation: c2,
    fullName: "Member Two",
    homeTown: "Space",
    horoscope: "All",
    memberLevel: "Senior",
    title: "Fullstack Developer");
void main() {
  members.add(m1);
  members.add(m2);
  bool exit = false;
  while (!exit) {
    print("\nNeon Academy Members");
    print("\n[1] Show List");
    print("\n[2] Add New Member");
    print("\n[3] Exit");

    stdout.write('Enter the option number to take action.');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case "1":
        if (members.isEmpty) {
          print("There are no members yet.");
        } else {
          memberList();
          break;
        }
      case "2":
        newMember();
        break;
      case "3":
        exit = true;
        print("Exiting the program...");
        break;
      default:
        print("Invalid selection, try again");
        print("");
    }
  }
}

newMember() {
  print("Add New Member");
  String fullName, title, horoscope, memberLevel, homeTown, email, phoneNumber;
  int age = 0, id = members.length + 1;
  while (true) {
    stdout.write('Full Name: ');
    String? fullNameInput = stdin.readLineSync();
    if (fullNameInput != null && fullNameInput.isNotEmpty) {
      fullName = fullNameInput;
      break;
    } else {
      print('Invalid input. Full Name must be a non-empty value.');
    }
  }

  stdout.write('Title: ');
  title = stdin.readLineSync()!;
  stdout.write('Horoscope: ');
  horoscope = stdin.readLineSync()!;
  stdout.write('Member Level: ');
  memberLevel = stdin.readLineSync()!;
  stdout.write('Home Town: ');
  homeTown = stdin.readLineSync()!;
  stdout.write('Age: ');
  String? ageInput = stdin.readLineSync();
  if (ageInput != null && ageInput.isNotEmpty) {
    age = int.parse(ageInput);
  }
  stdout.write('Email: ');
  email = stdin.readLineSync()!;
  stdout.write('Phone Number: ');
  phoneNumber = stdin.readLineSync()!;

  ContactInformation contactInfo =
      ContactInformation(email: email, phoneNumber: phoneNumber);

  NeonAcademyMember newMember = NeonAcademyMember(
      id: id,
      age: age,
      fullName: fullName,
      homeTown: homeTown,
      horoscope: horoscope,
      memberLevel: memberLevel,
      title: title,
      contactInformation: contactInfo);

  members.add(newMember);
  print("Added New Member.");
  print("");
}

memberList() {
  print("\nAll Members List");
  for (int i = 0; i < members.length; i++) {
    print("ID: ${members[i].id}");
    print("Full Name: ${members[i].fullName}");
    print("Title: ${members[i].title}");
    print("Horoscope: ${members[i].horoscope}");
    print("Member Level: ${members[i].memberLevel}");
    print("Home Town: ${members[i].homeTown}");
    print("Age: ${members[i].age}");
    print("Phone Number: ${members[i].contactInformation!.phoneNumber}");
    print("Email: ${members[i].contactInformation!.email}");
    print("------------------------------");
  }
  print("");
}
