// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get switchLanguageLabel => 'تبديل اللغة';

  @override
  String get englishLabel => 'الإنجليزية';

  @override
  String get arabicLabel => 'العربية';

  @override
  String get saveButton => 'حفظ';

  @override
  String get enterCredentials => 'أدخل بيانات الخاصة بك';

  @override
  String get signUpButton => 'التسجيل';

  @override
  String get createYourAccount => 'إنشاء حسابك';

  @override
  String get alreadyHaveAnAccount => 'لديك حساب ?';

  @override
  String get personalInfoTitle => 'معلومات شخصية';

  @override
  String get accountInfoTitle => 'معلومات الحساب';

  @override
  String get fullNameLabel => 'الاسم الكامل';

  @override
  String get fullNameError => 'الرجاء إدخال اسمك الكامل';

  @override
  String get phoneNumberLabel => 'رقم الهاتف';

  @override
  String get phoneNumberError => 'الرجاء إدخال رقم هاتفك';

  @override
  String get genderLabel => 'نوع الجنس';

  @override
  String get dayLabel => 'اليوم';

  @override
  String get monthLabel => 'الشهر';

  @override
  String get yearLabel => 'السنة';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get emailError => 'الرجاء إدخال بريدك الإلكتروني';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get passwordError => 'الرجاء إدخال كلمة المرور';

  @override
  String get confirmPasswordLabel => 'تأكيد كلمة المرور';

  @override
  String get confirmPasswordError => 'كلمات المرور لا تتطابق';

  @override
  String get continueButtonText => 'تابع';

  @override
  String get backButtonText => 'العودة';

  @override
  String get maleGender => 'ذكر';

  @override
  String get femaleGender => 'أنثى';

  @override
  String get formErrorPersonalInfo =>
      'يرجى تصحيح الأخطاء في نموذج المعلومات الشخصية.';

  @override
  String get formErrorAccountInfo =>
      'يرجى تصحيح الأخطاء في نموذج معلومات الحساب.';

  @override
  String get signupSuccessMessage => 'اشتراك ناجح! أهلاً و سهلاً!';

  @override
  String get signupFailureMessage =>
      'فشل في التسجيل. يرجى التحقق من المعلومات الخاصة بك وحاول مرة أخرى.';

  @override
  String get loginScreenTitle => 'أدخل بيانات الاعتماد الخاصة بك';

  @override
  String get loginFailedSnackbar => 'فشل تسجيل الدخول';

  @override
  String get exploreTitle => 'استكشف';

  @override
  String get noSportsAvailable => 'لا رياضة متاحة';

  @override
  String get loadingSports => 'تحميل الرياضة...';

  @override
  String get noAcademiesAvailable => 'قريبا';

  @override
  String get descriptionTitle => 'الوصف';

  @override
  String get classesTitle => 'اسم الفئة';

  @override
  String get loadingClasses => 'تحميل حصص...';

  @override
  String get noClassesAvailable => 'قريبا';

  @override
  String classNameTitle(String className) {
    return 'اسم الفئة:';
  }

  @override
  String priceTitle(String price) {
    return 'السعر: دينار بحريني $price';
  }

  @override
  String sportTitle(String sportTitle) {
    String _temp0 = intl.Intl.selectLogic(
      sportTitle,
      {
        'basketball': 'كرة السلة',
        'football': 'كرة القدم',
        'boxing': 'الملاكمة',
        'taekwondo': 'التايكوندو',
        'fencing': 'المبارزة',
        'swimming': 'السباحة',
        'padel': 'بادل',
        'other': 'الرياضة',
      },
    );
    return '$_temp0';
  }

  @override
  String get customerSupportLabel => 'دعم العملاء';

  @override
  String get playerLabel => 'لاعب';

  @override
  String get coachLabel => 'مدرب';

  @override
  String get swapToLabel => 'مبادلة إلى';

  @override
  String get userLabel => 'المستخدم';

  @override
  String get trainingDaysTitle => 'أيام التدريب';

  @override
  String get noTimingsAvailable => 'لا يوجد توقيت متاح';

  @override
  String get noClassDetailsAvailable => 'لا تتوفر تفاصيل الفئة';

  @override
  String get registerButtonText => 'اشتراك';

  @override
  String get enterReferralCodeDialogTitle => 'أدخل رمز الإحالة';

  @override
  String get referralCodeHint => 'رمز الإحالة';

  @override
  String get cancelButtonText => 'إلغاء';

  @override
  String get submitButtonText => 'إرسال';

  @override
  String successfullyEnrolledMessage(String code) {
    return 'التحق بنجاح مع التعليمات البرمجية';
  }

  @override
  String get myAcademyTitle => 'أكاديمياتي';

  @override
  String locationLabel(String location) {
    return 'الموقع';
  }

  @override
  String get timeLabel => 'الوقت';

  @override
  String get ageLabel => 'العمر';

  @override
  String get notEnrolledMessage => 'أنت غير مسجل في أي أكاديميات';

  @override
  String get registrationDateLabel => 'تاريخ التسجيل';

  @override
  String get renewalDateLabel => 'تاريخ التجديد';

  @override
  String get dobLabel => 'تاريخ الميلاد';

  @override
  String get priceLabel => 'السعر';

  @override
  String get scheduleTitle => 'الجدول';

  @override
  String get userProfileTitle => 'ملف المستخدم';

  @override
  String get noUserDataFound => 'لم يتم العثور على بيانات المستخدم';

  @override
  String get accountSectionTitle => 'الحساب';

  @override
  String get profileActionTitle => 'الملف الشخصي';

  @override
  String get privacyAndSecurityActionTitle => 'الخصوصية والأمان';

  @override
  String get actionsSectionTitle => 'الإجراءات';

  @override
  String get reportAProblemActionTitle => 'الإبلاغ عن مشكلة';

  @override
  String get profileUpdatedSuccess => 'تم تحديث الملف الشخصي بنجاح';

  @override
  String get profileUpdateFailed => 'فشل في تحديث الملف الشخصي';

  @override
  String get studentDetailsTitle => 'تفاصيل الطالب';

  @override
  String get studentName => 'اسم الطالب';

  @override
  String get studentPhone => 'هاتف الطالب';

  @override
  String get medicalCondition => 'الحالة الطبية';

  @override
  String get medicalConditionNone => 'لا حالة طبية';

  @override
  String get presentButton => 'حاضر';

  @override
  String get absentButton => 'غائب';

  @override
  String get logoutActionTitle => 'تسجيل الخروج';

  @override
  String get delectAccountActionTitle => 'حذف الحساب';

  @override
  String get dayOfWeekMon => 'الاثنين';

  @override
  String get dayOfWeekTue => 'الثلاثاء';

  @override
  String get dayOfWeekWed => 'الأربعاء';

  @override
  String get dayOfWeekThu => 'الخميس';

  @override
  String get dayOfWeekFri => 'الجمعة';

  @override
  String get dayOfWeekSat => 'السبت';

  @override
  String get dayOfWeekSun => 'الأحد';

  @override
  String appVersion(String versionNumber) {
    return 'اصدار $versionNumber';
  }

  @override
  String get errorUnknown => 'حدث خلل غير معروف';

  @override
  String get errorCannotDeleteAccount =>
      'لا يمكن حذف حساب مالك الأكاديمية من خلال التطبيق. يرجى التواصل مع خدمة العملاء للإزالة.';

  @override
  String get errorCouldNotDeleteAccount => 'خلل: لم يتم حذف الحساب.';

  @override
  String get errorInvalidCredentials => 'كلمة السر غير صحيحة';
}
