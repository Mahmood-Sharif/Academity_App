import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// Text for the login button
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// Text for the Switch Language button
  ///
  /// In en, this message translates to:
  /// **'Switch Language'**
  String get switchLanguageLabel;

  /// Text for the English button
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get englishLabel;

  /// Text for the Arabic button
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabicLabel;

  /// Text for the save button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// Text for Enter Your Credentials
  ///
  /// In en, this message translates to:
  /// **'Enter Your Credentials'**
  String get enterCredentials;

  /// Text for the sign-up button
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpButton;

  /// Title text for the signup screen's AppBar
  ///
  /// In en, this message translates to:
  /// **'Create Your Account'**
  String get createYourAccount;

  /// Text preceding the 'Sign In' link on the signup screen
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAnAccount;

  /// Title for the personal information step in the signup form
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get personalInfoTitle;

  /// Title for the account information step in the signup form
  ///
  /// In en, this message translates to:
  /// **'Account Info'**
  String get accountInfoTitle;

  /// Label for the full name input field
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullNameLabel;

  /// Error message when the full name field is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter your full name'**
  String get fullNameError;

  /// Label for the phone number input field
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumberLabel;

  /// Error message when the phone number field is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get phoneNumberError;

  /// Label for the gender selection
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get genderLabel;

  /// Label for the day selection dropdown
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get dayLabel;

  /// Label for the month selection dropdown
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get monthLabel;

  /// Label for the year selection dropdown
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get yearLabel;

  /// Label for the email input field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// Error message when the email field is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get emailError;

  /// Label for the password input field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// Error message when the password field is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter a password'**
  String get passwordError;

  /// Label for the confirm password input field
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// Error message when the password and confirm password fields do not match
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get confirmPasswordError;

  /// Text for the continue button in the stepper
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButtonText;

  /// Text for the back button in the stepper
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButtonText;

  /// Option for male gender
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get maleGender;

  /// Option for female gender
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get femaleGender;

  /// Error message for personal information form validation
  ///
  /// In en, this message translates to:
  /// **'Please correct the errors in the personal information form.'**
  String get formErrorPersonalInfo;

  /// Error message for account information form validation
  ///
  /// In en, this message translates to:
  /// **'Please correct the errors in the account information form.'**
  String get formErrorAccountInfo;

  /// Success message after signing up
  ///
  /// In en, this message translates to:
  /// **'Sign up successful! Welcome!'**
  String get signupSuccessMessage;

  /// Failure message when signup is unsuccessful
  ///
  /// In en, this message translates to:
  /// **'Failed to sign up. Please check your information and try again.'**
  String get signupFailureMessage;

  /// Title for the login screen's AppBar
  ///
  /// In en, this message translates to:
  /// **'Enter Your Credentials'**
  String get loginScreenTitle;

  /// Message displayed in a snackbar when login fails
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailedSnackbar;

  /// Title for the home page shown in the AppBar
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get exploreTitle;

  /// Text displayed when no sports are available to show
  ///
  /// In en, this message translates to:
  /// **'No sports available'**
  String get noSportsAvailable;

  /// Text displayed while sports are being loaded
  ///
  /// In en, this message translates to:
  /// **'Loading sports...'**
  String get loadingSports;

  /// Text displayed when no academies data is available to show
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get noAcademiesAvailable;

  /// Title for the description section of an academy
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionTitle;

  /// Title for the classes section of an academy
  ///
  /// In en, this message translates to:
  /// **'Classes'**
  String get classesTitle;

  /// Text displayed while the classes data is being loaded
  ///
  /// In en, this message translates to:
  /// **'Loading classes...'**
  String get loadingClasses;

  /// Text displayed when no classes data is available to show
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get noClassesAvailable;

  /// Displays the class name in the modal
  ///
  /// In en, this message translates to:
  /// **'Class Name'**
  String classNameTitle(String className);

  /// Displays the price of the class
  ///
  /// In en, this message translates to:
  /// **'Price: BD {price}'**
  String priceTitle(String price);

  /// No description provided for @sportTitle.
  ///
  /// In en, this message translates to:
  /// **'{sportTitle, select, basketball{Basketball} football{Football} boxing{Boxing} taekwondo{Taekwondo} fencing{Fencing} swimming{Swimming} padel{Padel} other{sport}}'**
  String sportTitle(String sportTitle);

  /// Label for Customer Support
  ///
  /// In en, this message translates to:
  /// **'Customer Support'**
  String get customerSupportLabel;

  /// Label for Player
  ///
  /// In en, this message translates to:
  /// **'Player'**
  String get playerLabel;

  /// Label for coach
  ///
  /// In en, this message translates to:
  /// **'Coach'**
  String get coachLabel;

  /// Label for Swap To
  ///
  /// In en, this message translates to:
  /// **'Swap To'**
  String get swapToLabel;

  /// Label for User
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get userLabel;

  /// Title for the section listing the training days
  ///
  /// In en, this message translates to:
  /// **'Training Days'**
  String get trainingDaysTitle;

  /// Displayed when there are no timings available for the class
  ///
  /// In en, this message translates to:
  /// **'No timings available'**
  String get noTimingsAvailable;

  /// Displayed when no class details are available to show
  ///
  /// In en, this message translates to:
  /// **'No class details available'**
  String get noClassDetailsAvailable;

  /// Text for the register button
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButtonText;

  /// Title for the dialog where users can enter a referral code
  ///
  /// In en, this message translates to:
  /// **'Enter Referral Code'**
  String get enterReferralCodeDialogTitle;

  /// Hint text for the referral code input field in the dialog
  ///
  /// In en, this message translates to:
  /// **'Referral Code'**
  String get referralCodeHint;

  /// Text for a generic cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButtonText;

  /// Text for a generic submit button
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitButtonText;

  /// Snackbar message for successful enrollment with a referral code
  ///
  /// In en, this message translates to:
  /// **'Successfully enrolled with code'**
  String successfullyEnrolledMessage(String code);

  /// Title for the My Academy page
  ///
  /// In en, this message translates to:
  /// **'My Academy'**
  String get myAcademyTitle;

  /// Label showing the location of the academy
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String locationLabel(String location);

  /// Label for Time
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get timeLabel;

  /// Label for the age
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get ageLabel;

  /// Message displayed when a user is not enrolled in any academies
  ///
  /// In en, this message translates to:
  /// **'You are not enrolled in any academies'**
  String get notEnrolledMessage;

  /// Label for the registration date of a class
  ///
  /// In en, this message translates to:
  /// **'Registration Date'**
  String get registrationDateLabel;

  /// Label for the renewal date of a class subscription
  ///
  /// In en, this message translates to:
  /// **'Renewal Date'**
  String get renewalDateLabel;

  /// Label for the Date of Birth
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dobLabel;

  /// Label for the price of a class
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get priceLabel;

  /// Title for the schedule page
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get scheduleTitle;

  /// Title for the user profile page
  ///
  /// In en, this message translates to:
  /// **'User Profile'**
  String get userProfileTitle;

  /// Message displayed when no user data is available
  ///
  /// In en, this message translates to:
  /// **'No user data found'**
  String get noUserDataFound;

  /// Title for the account section in profile page
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountSectionTitle;

  /// Title for navigating to the user profile
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileActionTitle;

  /// Title for the privacy and security section
  ///
  /// In en, this message translates to:
  /// **'Privacy and Security'**
  String get privacyAndSecurityActionTitle;

  /// Title for the actions section in profile page
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actionsSectionTitle;

  /// Title for the action to report a problem
  ///
  /// In en, this message translates to:
  /// **'Report A Problem'**
  String get reportAProblemActionTitle;

  /// Message displayed when the profile is updated successfully
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdatedSuccess;

  /// Message displayed when the profile update fails
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile'**
  String get profileUpdateFailed;

  /// studentDetailsTitle
  ///
  /// In en, this message translates to:
  /// **'Student Details'**
  String get studentDetailsTitle;

  /// studentName
  ///
  /// In en, this message translates to:
  /// **'Student Name'**
  String get studentName;

  /// studentPhone
  ///
  /// In en, this message translates to:
  /// **'Student Phone'**
  String get studentPhone;

  /// medicalCondition
  ///
  /// In en, this message translates to:
  /// **'Medical Condition'**
  String get medicalCondition;

  /// No description provided for @medicalConditionNone.
  ///
  /// In en, this message translates to:
  /// **'No Outstanding Medical Condition'**
  String get medicalConditionNone;

  /// presentButton
  ///
  /// In en, this message translates to:
  /// **'Present'**
  String get presentButton;

  /// absentButton
  ///
  /// In en, this message translates to:
  /// **'Absent'**
  String get absentButton;

  /// Title for the logout action
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutActionTitle;

  /// Title for the Delete Account action
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get delectAccountActionTitle;

  /// Abbreviation for Monday
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get dayOfWeekMon;

  /// Abbreviation for Tuesday
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get dayOfWeekTue;

  /// Abbreviation for Wednesday
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get dayOfWeekWed;

  /// Abbreviation for Thursday
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get dayOfWeekThu;

  /// Abbreviation for Friday
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get dayOfWeekFri;

  /// Abbreviation for Saturday
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get dayOfWeekSat;

  /// Abbreviation for Sunday
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get dayOfWeekSun;

  /// Display the current version of the app
  ///
  /// In en, this message translates to:
  /// **'Version {versionNumber}'**
  String appVersion(String versionNumber);

  /// Help message for an generic error.
  ///
  /// In en, this message translates to:
  /// **'Unknown Error Occured'**
  String get errorUnknown;

  /// Help message for when the user cannot delete the account because of contractual obligations.
  ///
  /// In en, this message translates to:
  /// **'Cannot delete academy owner account in the app, please contact customer support to delete your account.'**
  String get errorCannotDeleteAccount;

  /// Error message when account deletion fails.
  ///
  /// In en, this message translates to:
  /// **'Could not delete user account.'**
  String get errorCouldNotDeleteAccount;

  /// Help message for the invalid credentials error.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials'**
  String get errorInvalidCredentials;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
