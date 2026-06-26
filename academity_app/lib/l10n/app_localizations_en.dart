// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginButton => 'Login';

  @override
  String get switchLanguageLabel => 'Switch Language';

  @override
  String get englishLabel => 'English';

  @override
  String get arabicLabel => 'Arabic';

  @override
  String get saveButton => 'Save';

  @override
  String get enterCredentials => 'Enter Your Credentials';

  @override
  String get signUpButton => 'Sign Up';

  @override
  String get createYourAccount => 'Create Your Account';

  @override
  String get alreadyHaveAnAccount => 'Already have an account? ';

  @override
  String get personalInfoTitle => 'Personal Info';

  @override
  String get accountInfoTitle => 'Account Info';

  @override
  String get fullNameLabel => 'Full Name';

  @override
  String get fullNameError => 'Please enter your full name';

  @override
  String get phoneNumberLabel => 'Phone Number';

  @override
  String get phoneNumberError => 'Please enter your phone number';

  @override
  String get genderLabel => 'Gender';

  @override
  String get dayLabel => 'Day';

  @override
  String get monthLabel => 'Month';

  @override
  String get yearLabel => 'Year';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailError => 'Please enter your email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordError => 'Please enter a password';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get confirmPasswordError => 'Passwords do not match';

  @override
  String get continueButtonText => 'Continue';

  @override
  String get backButtonText => 'Back';

  @override
  String get maleGender => 'Male';

  @override
  String get femaleGender => 'Female';

  @override
  String get formErrorPersonalInfo =>
      'Please correct the errors in the personal information form.';

  @override
  String get formErrorAccountInfo =>
      'Please correct the errors in the account information form.';

  @override
  String get signupSuccessMessage => 'Sign up successful! Welcome!';

  @override
  String get signupFailureMessage =>
      'Failed to sign up. Please check your information and try again.';

  @override
  String get loginScreenTitle => 'Enter Your Credentials';

  @override
  String get loginFailedSnackbar => 'Login failed';

  @override
  String get exploreTitle => 'Explore';

  @override
  String get noSportsAvailable => 'No sports available';

  @override
  String get loadingSports => 'Loading sports...';

  @override
  String get noAcademiesAvailable => 'Coming Soon';

  @override
  String get descriptionTitle => 'Description';

  @override
  String get classesTitle => 'Classes';

  @override
  String get loadingClasses => 'Loading classes...';

  @override
  String get noClassesAvailable => 'Coming Soon';

  @override
  String classNameTitle(String className) {
    return 'Class Name';
  }

  @override
  String priceTitle(String price) {
    return 'Price: BD $price';
  }

  @override
  String sportTitle(String sportTitle) {
    String _temp0 = intl.Intl.selectLogic(
      sportTitle,
      {
        'basketball': 'Basketball',
        'football': 'Football',
        'boxing': 'Boxing',
        'taekwondo': 'Taekwondo',
        'fencing': 'Fencing',
        'swimming': 'Swimming',
        'padel': 'Padel',
        'other': 'sport',
      },
    );
    return '$_temp0';
  }

  @override
  String get customerSupportLabel => 'Customer Support';

  @override
  String get playerLabel => 'Player';

  @override
  String get coachLabel => 'Coach';

  @override
  String get swapToLabel => 'Swap To';

  @override
  String get userLabel => 'User';

  @override
  String get trainingDaysTitle => 'Training Days';

  @override
  String get noTimingsAvailable => 'No timings available';

  @override
  String get noClassDetailsAvailable => 'No class details available';

  @override
  String get registerButtonText => 'Register';

  @override
  String get enterReferralCodeDialogTitle => 'Enter Referral Code';

  @override
  String get referralCodeHint => 'Referral Code';

  @override
  String get cancelButtonText => 'Cancel';

  @override
  String get submitButtonText => 'Submit';

  @override
  String successfullyEnrolledMessage(String code) {
    return 'Successfully enrolled with code';
  }

  @override
  String get myAcademyTitle => 'My Academy';

  @override
  String locationLabel(String location) {
    return 'Location';
  }

  @override
  String get timeLabel => 'Time';

  @override
  String get ageLabel => 'Age';

  @override
  String get notEnrolledMessage => 'You are not enrolled in any academies';

  @override
  String get registrationDateLabel => 'Registration Date';

  @override
  String get renewalDateLabel => 'Renewal Date';

  @override
  String get dobLabel => 'Date of Birth';

  @override
  String get priceLabel => 'Price';

  @override
  String get scheduleTitle => 'Schedule';

  @override
  String get userProfileTitle => 'User Profile';

  @override
  String get noUserDataFound => 'No user data found';

  @override
  String get accountSectionTitle => 'Account';

  @override
  String get profileActionTitle => 'Profile';

  @override
  String get privacyAndSecurityActionTitle => 'Privacy and Security';

  @override
  String get actionsSectionTitle => 'Actions';

  @override
  String get reportAProblemActionTitle => 'Report A Problem';

  @override
  String get profileUpdatedSuccess => 'Profile updated successfully';

  @override
  String get profileUpdateFailed => 'Failed to update profile';

  @override
  String get studentDetailsTitle => 'Student Details';

  @override
  String get studentName => 'Student Name';

  @override
  String get studentPhone => 'Student Phone';

  @override
  String get medicalCondition => 'Medical Condition';

  @override
  String get medicalConditionNone => 'No Outstanding Medical Condition';

  @override
  String get presentButton => 'Present';

  @override
  String get absentButton => 'Absent';

  @override
  String get logoutActionTitle => 'Logout';

  @override
  String get delectAccountActionTitle => 'Delete Account';

  @override
  String get dayOfWeekMon => 'Mon';

  @override
  String get dayOfWeekTue => 'Tue';

  @override
  String get dayOfWeekWed => 'Wed';

  @override
  String get dayOfWeekThu => 'Thu';

  @override
  String get dayOfWeekFri => 'Fri';

  @override
  String get dayOfWeekSat => 'Sat';

  @override
  String get dayOfWeekSun => 'Sun';

  @override
  String appVersion(String versionNumber) {
    return 'Version $versionNumber';
  }

  @override
  String get errorUnknown => 'Unknown Error Occured';

  @override
  String get errorCannotDeleteAccount =>
      'Cannot delete academy owner account in the app, please contact customer support to delete your account.';

  @override
  String get errorCouldNotDeleteAccount => 'Could not delete user account.';

  @override
  String get errorInvalidCredentials => 'Invalid credentials';
}
