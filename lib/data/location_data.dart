/// Location data provider for Iran states, cities, and areas
/// Provides hierarchical location data for user selection
class LocationData {
  /// Available states in Iran with their cities and areas
  static const Map<String, Map<String, List<String>>> statesData = {
    'تهران': {
      'تهران': [
        'تهرانپارس',
        'سعادت آباد',
        'ونک',
        'نیاوران',
        'شهرک غرب',
        'پونک',
        'جنت آباد',
        'فرمانیه',
        'قیطریه',
        'کامرانیه',
        'پاسداران',
        'میرداماد',
        'ولنجک',
        'درکه',
        'اختیاریه',
        'زعفرانیه',
        'دیزین',
        'چیذر',
        'لواسان',
        'شمیران',
      ],
      'ری': [
        'شهر ری',
        'کهریزک',
        'فشاپویه',
      ],
      'شمیرانات': [
        'شمیران',
        'تجریش',
        'فشم',
      ],
    },
    'البرز': {
      'کرج': [
        'گوهردشت',
        'مهرشهر',
        'فردیس',
        'ماهدشت',
        'کمال شهر',
        'رجایی شهر',
        'گلشهر',
        'باغستان',
        'شهر جدید هشتگرد',
        'نظرآباد',
        'طالقان',
        'اشتهارد',
        'محمدشهر',
        'مارلیک',
        'صفادشت',
      ],
      'طالقان': [
        'طالقان',
        'دیزین',
      ],
      'نظرآباد': [
        'نظرآباد',
        'چهارباغ',
      ],
    },
    'اصفهان': {
      'اصفهان': [
        'نقش جهان',
        'چهارباغ',
        'خیابان سی تیر',
        'پل چوبی',
        'شهرک صنعتی',
        'خیابان کاشانی',
        'خیابان زینبیه',
        'خیابان شریعتی',
        'خیابان امام خمینی',
        'جی',
        'گلدشت',
        'شهرک ولیعصر',
        'شهرک امام حسین',
        'شهرک بهارستان',
        'شهرک قدس',
      ],
      'کاشان': [
        'کاشان مرکزی',
        'فین',
        'نیاسر',
        'آران و بیدگل',
      ],
      'نجف آباد': [
        'نجف آباد',
        'شهرک صنعتی',
      ],
    },
  };

  /// Get all available states
  static List<String> getStates() {
    return statesData.keys.toList();
  }

  /// Get cities for a given state
  static List<String> getCitiesForState(String state) {
    return statesData[state]?.keys.toList() ?? [];
  }

  /// Get areas for a given state and city
  static List<String> getAreasForCity(String state, String city) {
    return statesData[state]?[city] ?? [];
  }
}
