import 'dart:io';

class NeonAcademyMember {
  String fullName = "",
      title = "",
      horoscope = "",
      memberLevel = "",
      homeTown = "";
  int age = 0, id;
  ContactInformation? contactInformation;
  Team? team;
  NeonAcademyMember({
    required this.team,
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

enum Team { FlutterDevelopment, iOSDevelopment, AndroidDevelopment, UIDesign }

class ContactInformation {
  String phoneNumber, email;
  ContactInformation({required this.email, required this.phoneNumber});
}

List<NeonAcademyMember> members = [];

//Default Members
NeonAcademyMember m1 = NeonAcademyMember(
    id: 1,
    age: 24,
    contactInformation: ContactInformation(
        email: 'derinonursahin@gmail.com', phoneNumber: '+90 538 206 91 20'),
    fullName: "Onur Sahin",
    homeTown: "Sivas",
    horoscope: "Yengeç",
    memberLevel: "A1",
    title: "Flutter Developer",
    team: Team.FlutterDevelopment);

NeonAcademyMember m2 = NeonAcademyMember(
    id: 2,
    age: 100,
    contactInformation: ContactInformation(
        email: 'member2@gmail.com', phoneNumber: '+90 522 222 22 22'),
    fullName: "Member Two",
    homeTown: "Space",
    horoscope: "All",
    memberLevel: "Senior",
    title: "Android Developer",
    team: Team.AndroidDevelopment);

//Main Function
void main() {
  members.add(m1);
  members.add(m2);
  bool exit = false;
  while (!exit) {
    print("\nNeon Academy Members");
    print("\n[1] Show Lists");
    print("\n[2] Add New Member");
    print("\n[3] Delete A Member");
    print("\n[4] Enum and Switch Operations");
    print("\n[q] Exit");

    stdout.write('Enter the option number to take action.');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case "1":
        if (members.isEmpty) {
          print("There are no members yet.");
        } else {
          memberListOptions();
        }
        break;
      case "2":
        newMember();
        break;
      case "3":
        deleteMember();
        break;
      case "q":
        exit = true;
        print("Exiting the program...");
        break;
      case "4":
        enumAndSwitchOperations();
        break;
      default:
        print("Invalid selection, try again");
        print("");
        break;
    }
  }
}

//Enum & Switch Operations Beginning
enumAndSwitchOperations() {
  print("\n Enum And Switch Operations");
  stdout.write("\n[1] Flutter Development Team Members");
  stdout.write("\n[2] Number of UI/UX Design Team Members");
  stdout.write("\n[3] List the Members of the Team You Specified");
  stdout.write("\n[4] Learn a member's skill.");
  stdout.write("\n[5] Sort members over the age of your choice by team.");
  stdout.write("\n[6] Promote members by team.");
  stdout.write("\n[7] Calculate the average age of members of a team.");
  stdout.write("\n[8] Read different messages for teams.");
  stdout.write("\n[9] List the contact information of a team member.");
  stdout.write("\n[10] Get messages based on a member's team and age.");
  String? choice = stdin.readLineSync();
  switch (choice) {
    case "1":
      printFlutterTeamMembers();
    case "2":
      printUXTeamMemberCount();
    case "3":
      printMembersOfTeam();
    case "4":
      processMemberByTeam();
    case "5":
      printMembersAboveAgeByTeam();
    case "6":
      stdout.write("Enter the full name of the member you want to promote: ");
      String? fullName = stdin.readLineSync();

      if (fullName != null) {
        updateMemberLevel(fullName);
      } else {
        print("Invalid team input.");
      }
      break;
    case "7":
      calculateTeamAverageAge();
    case "8":
      printTeamMessage();
    case "9":
      printTeamContacts();
    case "10":
      processMember();
    default:
      print("Invalid selection, try again");
      print("");
  }
  menuOptions1();
}

//Enum & Switch Operations
Team? validateTeamInput(String teamInput) {
  switch (teamInput.toLowerCase()) {
    case "flutter":
      return Team.FlutterDevelopment;
    case "ios":
      return Team.iOSDevelopment;
    case "android":
      return Team.AndroidDevelopment;
    case "ui/ux":
      return Team.UIDesign;
    default:
      return null;
  }
}

void printFlutterTeamMembers() {
  List<String> flutterTeamMembers = [];
  for (var member in members) {
    if (member.team == Team.FlutterDevelopment) {
      flutterTeamMembers.add(member.fullName);
    }
  }
  print("Flutter Development Team Members:");
  for (var memberName in flutterTeamMembers) {
    print(memberName);
  }
}

void printUXTeamMemberCount() {
  int uxTeamMemberCount = 0;
  for (var member in members) {
    if (member.team == Team.UIDesign) {
      uxTeamMemberCount++;
    }
  }
  print("UI/UX Design Team Member Count: $uxTeamMemberCount");
}

void printMembersOfTeam() {
  stdout.write('Enter the team (Flutter, iOS, Android, UI/UX): ');
  var teamInput = stdin.readLineSync();
  Team? selectedTeam = validateTeamInput(teamInput!);

  if (selectedTeam == null) {
    print('Invalid team selection.');
    return;
  }

  print("Members of $selectedTeam:");
  for (var member in members) {
    if (member.team == selectedTeam) {
      print(member.fullName);
    }
  }
}

void processMemberByTeam() {
  stdout.write('Enter member\'s full name: ');
  var fullNameInput = stdin.readLineSync();

  NeonAcademyMember? selectedMember;
  for (var member in members) {
    if (member.fullName == fullNameInput) {
      selectedMember = member;
      break;
    }
  }

  if (selectedMember == null) {
    print('Member not found.');
    return;
  }

  switch (selectedMember.team) {
    case Team.FlutterDevelopment:
      print('This member is a talented Flutter developer.');
      break;
    case Team.iOSDevelopment:
      print('This member is a skilled iOS developer.');
      break;
    case Team.AndroidDevelopment:
      print('This member is a proficient Android developer.');
      break;
    case Team.UIDesign:
      print('This member is a talented designer.');
      break;
    default:
      print('Invalid team for the member.');
      break;
  }
}

void printMembersAboveAgeByTeam() {
  int? age;
  stdout.write("Enter the age: ");
  var ageInput = stdin.readLineSync();
  if (ageInput != null && ageInput.isNotEmpty) {
    age = int.parse(ageInput);
  }
  if (age == null) {
    print('Invalid age input. Please enter a valid integer.');
    return;
  }
  print('Members above $age years old by team:\n');

  Map<Team, List<String>> membersByTeam = {
    Team.FlutterDevelopment: [],
    Team.iOSDevelopment: [],
    Team.AndroidDevelopment: [],
    Team.UIDesign: [],
  };

  for (var member in members) {
    if (member.age > age) {
      membersByTeam[member.team]!.add(member.fullName);
    }
  }
  String teamToString(Team team) {
    switch (team) {
      case Team.FlutterDevelopment:
        return 'Flutter Development';
      case Team.iOSDevelopment:
        return 'iOS Development';
      case Team.AndroidDevelopment:
        return 'Android Development';
      case Team.UIDesign:
        return 'UI/UX Design';
    }
  }

  membersByTeam.forEach((team, members) {
    print('${teamToString(team)} Team:');
    if (members.isNotEmpty) {
      members.forEach((member) {
        print('- $member');
      });
    } else {
      print('No members above $age years old');
    }
    print('');
  });
}

void calculateTeamAverageAge() {
  stdout.write("Enter the team: ");
  String? teamInput = stdin.readLineSync();
  if (teamInput == null || teamInput.isEmpty) {
    print("Invalid input.");
    return;
  }

  Team? team = validateTeamInput(teamInput);
  if (team == null) {
    print("Invalid team.");
    return;
  }

  List<NeonAcademyMember> teamMembers = [];

  for (var member in members) {
    if (member.team == team) {
      teamMembers.add(member);
    }
  }

  if (teamMembers.isEmpty) {
    print("There are no members in the team.");
    return;
  }

  int totalAge = 0;
  for (var member in teamMembers) {
    totalAge += member.age;
  }
  double averageAge = totalAge / teamMembers.length;

  print(switch (team) {
    Team.FlutterDevelopment =>
      "The Flutter Development Team is the backbone of our academy.",
    Team.iOSDevelopment =>
      "The iOS Development Team is the face of our academy.",
    Team.AndroidDevelopment =>
      "The Android Development Team is the bridge of our academy.",
    Team.UIDesign => "The UI/UX Design Team is a favorite of our academy."
  });

  print("Average Age: ${averageAge.toStringAsFixed(1)}");
}

void printTeamMessage() {
  stdout.write("Enter the team: ");
  String? teamInput = stdin.readLineSync();
  if (teamInput == null || teamInput.isEmpty) {
    print("Invalid input.");
    return;
  }

  Team? team = validateTeamInput(teamInput);
  if (team == null) {
    print("Invalid team.");
    return;
  }

  print(switch (team) {
    Team.FlutterDevelopment =>
      "Flutter Development Team is the backbone of our academy.",
    Team.iOSDevelopment =>
      "iOS Development Team is the backbone of our academy.",
    Team.AndroidDevelopment =>
      "Android Development Team is the backbone of our academy.",
    Team.UIDesign => "UI/UX Design Team is the face of our academy.",
    // ignore: unreachable_switch_case
    _ => "Invalid team."
  });
}

void printTeamContacts() {
  stdout.write("Enter the team: ");
  String? teamInput = stdin.readLineSync();
  if (teamInput == null || teamInput.isEmpty) {
    print("Invalid input.");
    return;
  }

  Team? team = validateTeamInput(teamInput);
  if (team == null) {
    print("Invalid team.");
    return;
  }

  List<NeonAcademyMember> teamMembers = [];

  for (var member in members) {
    if (member.team == team) {
      teamMembers.add(member);
    }
  }

  if (teamMembers.isEmpty) {
    print("There are no members in the team.");
  } else {
    print("Contact information for the team members:");
    for (var member in teamMembers) {
      print("Full Name: ${member.fullName}");
      print("Email: ${member.contactInformation?.email}");
      print("Phone Number: ${member.contactInformation?.phoneNumber}");
      print("");
    }
  }
}

void processMember() {
  stdout.write("Enter the member's full name: ");
  String? fullName = stdin.readLineSync();

  if (fullName == null || fullName.isEmpty) {
    print("Invalid full name.");
    return;
  }

  NeonAcademyMember? member;

  // Find the member based on the full name
  for (var mem in members) {
    if (mem.fullName == fullName) {
      member = mem;
      break;
    }
  }

  if (member == null) {
    print("Member not found.");
    return;
  }

  // Print messages based on team and age
  if (member.team == Team.FlutterDevelopment) {
    if (member.age > 23) {
      print("${member.fullName} is an experienced Flutter developer.");
    } else {
      print(
          "${member.fullName} is exploring new talents in the Flutter world.");
    }
  } else if (member.team == Team.UIDesign) {
    if (member.age < 24) {
      print("${member.fullName} is a rising star in the world of design.");
    } else {
      print("${member.fullName} is an experienced designer.");
    }
  } else if (member.team == Team.iOSDevelopment) {
    if (member.age > 25) {
      print("${member.fullName} is a seasoned iOS developer.");
    } else {
      print("${member.fullName} is an aspiring iOS developer.");
    }
  } else if (member.team == Team.AndroidDevelopment) {
    if (member.age >= 22 && member.age <= 30) {
      print("${member.fullName} is a dedicated Android developer.");
    } else {
      print("${member.fullName} is an enthusiastic Android developer.");
    }
  } else {
    print("Invalid team.");
  }
}

//End of Enum & Switch Operations

//Member Delete Function
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

//Member ID Update Function
updateMemberIds() {
  for (int i = 0; i < members.length; i++) {
    members[i].id = i + 1;
  }
}

//Member Level Update Function
void updateMemberLevel(String fullName) {
  NeonAcademyMember? member;

  // Tam adı kullanarak üyeyi bulma
  for (var m in members) {
    if (m.fullName == fullName) {
      member = m;
      break;
    }
  }

  if (member == null) {
    print("Member not found.");
    return;
  }

  // Üyenin takımına bağlı olarak memberLevel'i güncelleme
  switch (member.team) {
    case Team.FlutterDevelopment:
    case Team.iOSDevelopment:
    case Team.AndroidDevelopment:
      member.memberLevel = "Senior";
      break;
    case Team.UIDesign:
      member.memberLevel = "Lead";
      break;
    default:
      print("Invalid team.");
      return;
  }

  print("$fullName is promoted to ${member.memberLevel}.");
}

//General Menu Operations for Arrays Operations
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

//General Menu Operations for Enum & Switch Operations
void menuOptions1() {
  stdout.write(
      'Enter [b] to return to the previous menu, [m] to return to the main menu, or [q] to exit: ');
  var choice = stdin.readLineSync()!;

  switch (choice) {
    case "q":
      print("Exiting program...");
      exit(0);
    case "b":
      print("Returning to the previous menu...");
      enumAndSwitchOperations();
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

//New Member Add
newMember() {
  String fullName, title, horoscope, memberLevel, homeTown, email, phoneNumber;
  int age = 0, id = members.length + 1;
  Team? team;

  print("Add New Member");

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
  stdout.write('If the member is a Mentor, type [Yes] otherwise [No]:');
  var option = stdin.readLineSync();
  if (option == "No") {
    stdout.write('Title: ');
    title = stdin.readLineSync()!;
  } else if (option == "Yes") {
    title = "Mentor";
  } else {
    title = "";
  }
  stdout.write('Member Level: ');
  memberLevel = stdin.readLineSync()!;
  stdout.write('Horoscope: ');
  horoscope = stdin.readLineSync()!;

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

  stdout.write('Team: ');
  var teamInput = stdin.readLineSync();
  if (teamInput == "Flutter") {
    team = Team.FlutterDevelopment;
  } else if (teamInput == "iOS") {
    team = Team.iOSDevelopment;
  } else if (teamInput == "Android") {
    team = Team.AndroidDevelopment;
  } else if (teamInput == "UI/UX") {
    team = Team.UIDesign;
  } else {
    team = null;
  }

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
    contactInformation: contactInfo,
    team: team,
  );

  members.add(newMember);
  print("Added New Member.");
  print("");
}

//Default Member List
memberList() {
  for (int i = 0; i < members.length; i++) {
    print("ID: ${members[i].id}");
    print("Full Name: ${members[i].fullName}");
    print("Title: ${members[i].title}");
    print("Title: ${members[i].team}");
    print("Horoscope: ${members[i].horoscope}");
    print("Member Level: ${members[i].memberLevel}");
    print("Home Town: ${members[i].homeTown}");
    print("Age: ${members[i].age}");
    print("Phone Number: ${members[i].contactInformation!.phoneNumber}");
    print("Email: ${members[i].contactInformation!.email}");
    print("------------------------------");
  }
}

//Arrays
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
