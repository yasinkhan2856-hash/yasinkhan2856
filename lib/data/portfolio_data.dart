import 'package:flutter/material.dart';
import '../models/project.dart';

abstract final class PortfolioData {
  static const name = 'Yasin Khan';
  static const role = 'Full Stack Developer ';
  static const subtitle = 'Flutter & Full Stack Developer (Node.js)';
  static const github = 'https://github.com/yasinkhan2856-hash';
  static const linkedin = 'https://www.linkedin.com/in/yasinkhan2856/';
  static const instagram = 'https://www.instagram.com/yasin_khan_285/';
  static const snapchat =
      'https://www.snapchat.com/add/yasin_k1284?share_id=B_Q-pEwjdG0&locale=en-US';
  static const email = 'yasinkhan2856@gmail.com';
  static const formspreeFormId = 'YOUR_FORMSPREE_FORM_ID';
  static const phone = '0341-9493288';
  static const location = 'Islamabad, Pakistan';

  static const stats = [
    ('2+', 'Years Experience'),
    ('5+', 'Projects Completed'),
    ('15+', 'Technologies'),
    ('100%', 'Client Focus'),
  ];

  static const whatIDo = [
    (
      Icons.phone_android_outlined,
      'Mobile Development',
      'Cross-platform Flutter apps for Android & iOS with polished UI and smooth performance.',
    ),
    (
      Icons.cloud_outlined,
      'Backend & Cloud',
      'Firebase, Supabase, and Node.js integrations with secure auth and real-time data.',
    ),
    (
      Icons.api_outlined,
      'API Integration',
      'RESTful APIs, JSON parsing, error handling, and third-party SDK integrations.',
    ),
    (
      Icons.architecture_outlined,
      'Clean Architecture',
      'MVVM, SOLID principles, offline-first patterns, and maintainable codebases.',
    ),
  ];

  static const portfolioFilters = ['All', 'Flutter', 'Android'];

  static const skillGroups = <String, List<String>>{
    'Mobile Development': [
      'Flutter',
      'Android (Java)',
      'iOS',
      'Material Design 3',
    ],
    'Backend & Cloud': [
      'Firebase Auth',
      'Firestore',
      'Realtime DB',
      'Cloud Functions',
      'Supabase',
      'Node.js',
    ],
    'State & Data': [
      'GetX',
      'Provider',
      'Bloc',
      'Riverpod',
      'RESTful APIs',
      'JSON',
      'SQL',
      'SQLite',
    ],
    'Programming': ['Dart', 'Java', 'C++', 'Python'],
    'Architecture & Tools': [
      'Clean Architecture',
      'MVVM',
      'SOLID',
      'Offline-First',
      'Git/GitHub',
      'Android Studio',
      'VS Code',
    ],
  };

  /// Projects from CV — same order as Yasin_Khan_CV_full_stack_developer.pdf
  static const projects = <Project>[
    Project(
      title: 'Doctor Appointment App',
      category: 'Healthcare / Telehealth',
      filterTag: 'Flutter',
      description:
          'Healthcare platform connecting patients and doctors with role-based Firebase Authentication, real-time appointment booking, video consultation, and secure payments.',
      technologies: [
        'Flutter',
        'Dart',
        'Firebase Auth',
        'Firestore',
        'Cloud Functions',
        'GetX',
      ],
      features: [
        'Patient and doctor roles',
        'Real-time appointment booking',
        'Video consultation module',
        'Secure payment integration',
        'Responsive Android and iOS UI',
      ],
      icon: Icons.health_and_safety_outlined,
      color: Color(0xFF6366F1),
      githubUrl: github,
      demoUrl:
          'https://www.linkedin.com/posts/yasin-khan-b924a23b4_finalyearproject-sehatapp-flutter-activity-7468755046239825921-Et8x?utm_source=share&utm_medium=member_desktop&rcm=ACoAAGUp7h4BRtSLpCQCaGfwC1BevC2gdnGfcT4',
      imageAsset: 'assets/doctor_app.png',
      featured: true,
    ),
    Project(
      title: 'Food App',
      category: 'Food Delivery / Mobile UI',
      filterTag: 'Flutter',
      description:
          'Food delivery app UI covering restaurant listings, menu browsing, cart, checkout, and order tracking with animated navigation.',
      technologies: ['Flutter', 'Dart', 'Material Design 3'],
      features: [
        'Animated bottom navigation',
        'Smooth screen transitions',
        'Responsive layouts',
        'Cart and checkout flow',
      ],
      icon: Icons.lunch_dining_outlined,
      color: Color(0xFF0EA5E9),
      githubUrl: 'https://github.com/yasinkhan2856-hash/Food_App',
      demoUrl: 'https://lnkd.in/p/dBx88U24',
      imageAsset: 'assets/food_app.png',
    ),
    Project(
      title: 'NeoBank',
      category: 'FinTech / Digital Banking',
      filterTag: 'Flutter',
      description:
          'Fintech banking app UI with dashboard, virtual card display, send-money flow, and expense/income analytics charts.',
      technologies: ['Flutter', 'Dart', 'GetX', 'MVVM', 'Material Design 3'],
      features: [
        'Analytics charts',
        'Glassmorphism styling',
        'Dark mode support',
        'MVVM architecture',
      ],
      icon: Icons.account_balance_wallet_outlined,
      color: Color(0xFF8B5CF6),
      githubUrl: 'https://github.com/yasinkhan2856-hash/NeoBank',
      demoUrl: 'https://lnkd.in/p/dBx88U24',
      imageAsset: 'assets/NeoBank.png',
    ),
    Project(
      title: 'E-Commerce Store',
      category: 'E-Commerce / Android',
      filterTag: 'Android',
      description:
          'Java shopping app with 50+ products, dynamic cart, Firebase Authentication, search, filtering, and category browsing.',
      technologies: [
        'Java',
        'XML',
        'Firebase Realtime Database',
        'Firebase Auth',
      ],
      features: [
        '50+ products',
        'Real-time price calculation',
        'Search and filtering',
        'RecyclerView adapters',
      ],
      icon: Icons.shopping_bag_outlined,
      color: Color(0xFF14B8A6),
      githubUrl: 'https://github.com/yasinkhan2856-hash/ecommerce-platform',
      imageAsset: 'assets/ecommerce.png',
    ),
    Project(
      title: 'AeroPass',
      category: 'Travel / Airline Booking',
      filterTag: 'Flutter',
      description:
          'Premium airline booking UI with interactive seat selection, digital boarding pass, QR/barcode ticket, and downloadable PDF.',
      technologies: ['Flutter', 'Dart', 'GetX', 'MVVM', 'Material Design 3'],
      features: [
        'Interactive seat selection',
        'QR/barcode ticket',
        'Downloadable PDF boarding pass',
        'Animated booking flow',
      ],
      icon: Icons.flight_takeoff_outlined,
      color: Color(0xFF3B82F6),
      githubUrl: 'https://github.com/yasinkhan2856-hash/Aero_pass',
      demoUrl: 'https://lnkd.in/p/dBrQqQqu',
      imageAsset: 'assets/aeropass.png',
    ),
  ];

  static const services = [
    'Flutter Mobile App Development',
    'Android App Development',
    'UI/UX Implementation',
    'Firebase Integration',
    'REST API Integration',
    'AI API Integration',
    'Backend Integration',
    'Responsive UI Development',
  ];
}
