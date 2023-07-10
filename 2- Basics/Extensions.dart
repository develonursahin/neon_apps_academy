import 'dart:io';

void main() {
  extensionOperations();
}

//General Menu Operations
menuOption() {
  stdout.write(
      'Enter [b] to return to the previous menu, [m] to return to the main menu, or [q] to exit: ');
  var choice = stdin.readLineSync()!;
  switch (choice) {
    case "q":
      print("Exiting program...");
      exit(0);
    case "b":
      print("Returning to the previous menu...");
      extensionOperations();
      break;
    case "m":
      print("Returning to the main menu...");
      return;
    default:
      print("Invalid selection, try again");
      print("");
      menuOption();
      break;
  }
}
//Extensions Operations

//Extensions Menu
extensionOperations() {
  print("\n [1] Palindrome Word Control");
  print("\n [1] Prime Number Control");
  print("\n [3] Days Between Dates Control");
  print("\n [4] Boolean Control");
  print("\n [5] Set Control");
  print("\n [6] Map Control");
  stdout.write("Select the action you want to take.");
  String? choice = stdin.readLineSync();
  switch (choice) {
    case "1":
      palindromeFunc();
    case "2":
      primeNumberFunc();
    case "3":
      dateTimeFunc();
    case "4":
      boolFunc();
    case "5":
      setFunc();
    case "6":
      mapFunc();
  }
  menuOption();
}

//Palindrome Operations
extension StringPalindromeCheck on String {
  bool isPalindrome() {
    String reversed = this.split('').reversed.join('');
    return this.toLowerCase() == reversed.toLowerCase();
  }
}

palindromeFunc() {
  stdout.write('Enter word: ');
  String word = stdin.readLineSync()!;

  if (word.isPalindrome()) {
    print('The entered word is a palindrome.');
  } else {
    print('The entered word is not a palindrome.');
  }
}

// Prime Number Operations
extension IntExtensions on int {
  bool isPrime() {
    if (this < 2) {
      return false;
    }
    for (int i = 2; i <= this / 2; i++) {
      if (this % i == 0) {
        return false;
      }
    }
    return true;
  }
}

primeNumberFunc() {
  stdout.write('Enter number: ');
  String? numberInput = stdin.readLineSync();
  if (numberInput != null && numberInput.isNotEmpty) {
    int number = int.parse(numberInput);
    if (number.isPrime()) {
      print('The entered number is a prime.');
    } else {
      print('The entered number is not a prime.');
    }
  }
}

//DateTime Operations
extension DateTimeExtensions on DateTime {
  int calculateDaysBetween(DateTime endDate) {
    final difference = endDate.difference(this).inDays;
    return difference.abs();
  }
}

dateTimeFunc() {
  stdout.write('Enter start date (yyyy-MM-dd): ');
  String? startDateInput = stdin.readLineSync();
  stdout.write('Enter end date (yyyy-MM-dd): ');
  String? endDateInput = stdin.readLineSync();

  if (startDateInput != null && endDateInput != null) {
    DateTime startDate = DateTime.parse(startDateInput);
    DateTime endDate = DateTime.parse(endDateInput);

    int daysBetween = startDate.calculateDaysBetween(endDate);
    print("Days Between: $daysBetween");
  } else {
    print('Invalid input.');
  }
}

//Bool Operations
extension VotingEligibility on String {
  bool isEligibleForVoting(int age, bool isCitizen) {
    return age >= 18 && isCitizen;
  }
}

void boolFunc() {
  bool? personIsCitizen;
  stdout.write('Enter person age: ');
  int? personAge = int.parse(stdin.readLineSync()!);
  if (personAge < 18) {
    print("This person can't vote.");
    return;
  } else {
    stdout.write('Is the person a citizen? [Yes] or [No]: ');
    String? citizen = stdin.readLineSync();
    if (citizen == "Yes") {
      personIsCitizen = true;
    } else {
      personIsCitizen = false;
    }
  }

  bool isEligible =
      personAge.toString().isEligibleForVoting(personAge, personIsCitizen);
  if (isEligible) {
    print("This person can vote.");
  } else {
    print("This person can't vote.");
  }
}

//Set Operations
extension UniqueElements<T> on Set<T> {
  Set<T> removeDuplicates() {
    return toSet();
  }
}

setFunc() {
  Set<int> numbers = Set<int>();
  for (int i = 1; i < 6; i++) {
    stdout.write("$i. Add Number");
    int? numberInput = int.parse(stdin.readLineSync()!);
    numbers.add(numberInput);
  }
  Set<int> uniqueNumbers = numbers.removeDuplicates();
  print(uniqueNumbers);
}

//Map Operations
extension PopulationManagement on Map<String, List<String>> {
  void addFamilyMember(String lastName, String memberName) {
    if (this.containsKey(lastName)) {
      this[lastName]!.add(memberName);
    } else {
      this[lastName] = [memberName];
    }
  }
}

mapFunc() {
  Map<String, List<String>> population = {};

  //Default Members
  population.addFamilyMember("Sahin", "Onur");
  population.addFamilyMember("Sahin", "Ali");
  population.addFamilyMember("Sahin", "Veli");
  population.addFamilyMember("Sahin", "Ayse");
  population.addFamilyMember("Sucu", "Fatma");
  population.addFamilyMember("Demir", "Mehmet");
  population.addFamilyMember("Demir", "Ahmet");
  population.addFamilyMember("Dogan", "Can");
  population.addFamilyMember("Dogan", "Selin");
  population.addFamilyMember("Tas", "Ugur");
  population.addFamilyMember("Tas", "Burak");
  population.addFamilyMember("Kahraman", "Asli");
  population.addFamilyMember("Duz", "Beyza");

  print('\nPopulation List:');
  population.forEach((lastName, members) {
    print('Last Name: $lastName');
    members.forEach((member) => print('- $member'));
  });
}
