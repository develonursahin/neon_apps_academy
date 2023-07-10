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

//Default Members
NeonAcademyMember m1 = NeonAcademyMember(
    id: 1,
    age: 24,
    contactInformation: c1,
    fullName: "Onur Şahin",
    homeTown: "Sivas",
    horoscope: "Yengeç",
    memberLevel: "A1",
    title: "Flutter Developer");
ContactInformation c1 = ContactInformation(
    email: 'derinonursahin@gmail.com', phoneNumber: '+90 538 206 91 20');

NeonAcademyMember m2 = NeonAcademyMember(
    id: 2,
    age: 100,
    contactInformation: c2,
    fullName: "Member Two",
    homeTown: "Space",
    horoscope: "All",
    memberLevel: "Senior",
    title: "Fullstack Developer");
ContactInformation c2 = ContactInformation(
    email: 'member2@gmail.com', phoneNumber: '+90 522 222 22 22');

void main() {
  members.add(m1);
  members.add(m2);
  bool exit = false;
  while (!exit) {
    print("\nNeon Academy Members");
    print("\n[1] Show Lists");
    print("\n[2] Add New Member");
    print("\n[3] Delete A Member");
    print("\n[4] Exit");

    stdout.write('Enter the option number to take action.');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case "1":
        if (members.isEmpty) {
          print("There are no members yet.");
        } else {
          memberListOptions();
        }
      case "2":
        newMember();
        break;
      case "3":
        deleteMember();
        break;
      case "4":
        exit = true;
        print("Exiting the program...");
        break;
      default:
        print("Invalid selection, try again");
        print("");
    }
  }
}

deleteMember() {
  print("\nDelete a Member");
  print("\n[1] Deletion by ID.");
  print("\n[2] Delete by Member Level.");

  stdout.write('Select your deletion method.');
  String? choice = stdin.readLineSync();

  switch (choice) {
    case "1":
      stdout.write('Enter the member ID you want to delete.');
      String? choice = stdin.readLineSync();
      var id = int.parse(choice!);
      members.removeAt(id - 1);
      print("Deleted selected member.");
      updateMemberIds();
    case "2":
      stdout.write('Enter the member level you want to delete.');
      String? choice = stdin.readLineSync();
      members.removeWhere((member) => member.memberLevel == choice);
      updateMemberIds();
  }
}

updateMemberIds() {
  for (int i = 0; i < members.length; i++) {
    members[i].id = i + 1;
  }
}

void menuOptions() {
  stdout.write(
      'Enter [b] to return to the previous menu, [m] to return to the main menu, or [q] to exit: ');
  var choice = stdin.readLineSync()!;

  switch (choice) {
    case "q":
      print("Exiting program...");
      exit(0);
    case "b":
      print("Returning to the previous menu...");
      memberListOptions();
      break;
    case "m":
      print("Returning to the main menu...");
      return;
    default:
      print("Invalid selection, try again");
      print("");
      menuOptions();
      break;
  }
}

newMember() {
  String fullName, title, horoscope, memberLevel, homeTown, email, phoneNumber;
  int age = 0, id = members.length + 1;

  print("Add New Member or Mentor");

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
  stdout.write('Member or Mentor: ');
  var option = stdin.readLineSync();
  if (option == "Member") {
    stdout.write('Member Level: ');
    memberLevel = stdin.readLineSync()!;
  } else if (option == "Mentor") {
    memberLevel = "Mentor";
  } else
    memberLevel = "";
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
}

memberListOptions() {
  print("\n How would you like to rank the members?");
  print("\n[0] Sort members by ID.");
  print("\n[1] Sort members by age from largest to smallest.");
  print("\n[2] Sort members by name (Z-A).");
  print("\n[3] Sort members over 24 years old.");
  print("\n[4] Print the total number of members who are Flutter Developers.");
  print("\n[5] Sort members by memberLevel (high to low).");
  print("\n[6] Sort members with the same horoscope.");
  print("\n[7] Sort members' emails.");
  print("\n[8] Sort contact information of members with the same title.");
  print("\n[9] Average age of all members.");
  print("\n[10] The member with the highest age.");
  print("\n[11] The member with the longest name.");
  print("\n[12] Sort members by most Home Town.");
  print("\n[13] Find the index of a member.");

  stdout.write('Enter the number of the action you want to perform.');
  String? choice = stdin.readLineSync();

  switch (choice) {
    case "0":
      memberList();

    case "1":
      members.sort((a, b) => b.age.compareTo(a.age));
      print("\nAfter ranking members by age (largest to smallest):");
      memberList();

    case "2":
      members.sort((a, b) => a.fullName.compareTo(b.fullName));
      print("\nAfter sorting members by name (Z-A):");
      memberList();

    case "3":
      List<NeonAcademyMember> olderMembers =
          members.where((member) => member.age > 24).toList();
      print("\nMembers older than 24:");
      for (var member in olderMembers) {
        print(member.fullName);
      }

    case "4":
      int flutterDeveloperCount =
          members.where((member) => member.title == "Flutter Developer").length;
      print("\nTotal number of Flutter Developers: $flutterDeveloperCount");

    case "5":
      members.sort((a, b) => b.memberLevel.compareTo(a.memberLevel));
      print("Members sorted by memberLevel (highest to lowest):");

    case "6":
      Map<String, List<NeonAcademyMember>> horoscopeGroups = {};
      for (var member in members) {
        if (!horoscopeGroups.containsKey(member.horoscope)) {
          horoscopeGroups[member.horoscope] = [];
        }
        horoscopeGroups[member.horoscope]!.add(member);
      }

      for (var group in horoscopeGroups.values) {
        var horoscope = group.first.horoscope;
        print("$horoscope Horoscope");
        for (var member in group) {
          print(member.fullName);
        }

        print("");
      }

    case "7":
      List<ContactInformation> contactInfoList =
          members.map((member) => member.contactInformation!).toList();
      List<String> emailAddresses =
          contactInfoList.map((contact) => contact.email).toList();

      print("Email addresses of members:");
      for (var email in emailAddresses) {
        print(email);
      }

    case "8":
      Map<String, List<ContactInformation>> titleGroups = {};

      for (var member in members) {
        if (!titleGroups.containsKey(member.title)) {
          titleGroups[member.title] = [];
        }
        titleGroups[member.title]!.add(member.contactInformation!);
      }

      for (var entry in titleGroups.entries) {
        var title = entry.key;
        var group = entry.value;

        print("${title}s");
        for (var contact in group) {
          print(contact.phoneNumber);
        }
        print("");
      }

    case "9":
      double averageAge =
          members.map((member) => member.age).reduce((a, b) => a + b) /
              members.length;
      print("Average age of members: $averageAge");

    case "10":
      int maxAge =
          members.map((member) => member.age).reduce((a, b) => a > b ? a : b);
      NeonAcademyMember oldestMember =
          members.firstWhere((member) => member.age == maxAge);
      print("Full Name: ${oldestMember.fullName}");
      print("Age: ${oldestMember.age}");

    case "11":
      String longestName = members
          .map((member) => member.fullName)
          .reduce((a, b) => a.length > b.length ? a : b);
      NeonAcademyMember memberWithLongestName =
          members.firstWhere((member) => member.fullName == longestName);
      print("Full Name: ${memberWithLongestName.fullName}");
      print("Name Length: ${memberWithLongestName.fullName.length}");

    case "12":
      Map<String, List<NeonAcademyMember>> homeTownGroups = {};
      for (var member in members) {
        if (!homeTownGroups.containsKey(member.homeTown)) {
          homeTownGroups[member.homeTown] = [];
        }
        homeTownGroups[member.homeTown]!.add(member);
      }
      int maxCount = 0;
      String mostCommonHomeTown = "";
      for (var entry in homeTownGroups.entries) {
        if (entry.value.length > maxCount) {
          maxCount = entry.value.length;
          mostCommonHomeTown = entry.key;
        }
      }
      print("Most common hometown: $mostCommonHomeTown");
      print(
          "Number of members from the most common hometown: ${homeTownGroups[mostCommonHomeTown]!.length}");
    case "13":
      stdout.write('Full Name: ');
      var fullName = stdin.readLineSync()!;
      int index = members.indexWhere((member) => member.fullName == fullName);
      print("[$fullName]'s index: $index");

    default:
      print("Invalid selection, try again");
      print("");
  }
  menuOptions();
}
