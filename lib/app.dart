import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'data/portfolio_data.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/hero_section.dart';
import 'sections/projects_section.dart';
import 'theme/app_theme.dart';
import 'widgets/common.dart';
import 'widgets/sidebar.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Yasin Khan | Full Stack Developer ',
    theme: AppTheme.light,
    home: const PortfolioPage(),
  );
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final controller = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final keys = List.generate(4, (_) => GlobalKey());
  final labels = const ['Home', 'About Me', 'Portfolio', 'Contact'];
  int active = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(_trackSection);
  }

  @override
  void dispose() {
    controller.removeListener(_trackSection);
    controller.dispose();
    super.dispose();
  }

  void _trackSection() {
    var found = 0;
    for (var i = 0; i < keys.length; i++) {
      final sectionContext = keys[i].currentContext;
      final renderObject = sectionContext?.findRenderObject();
      if (renderObject is RenderBox &&
          renderObject.localToGlobal(Offset.zero).dy < 200) {
        found = i;
      }
    }
    if (found != active && mounted) {
      setState(() => active = found);
    }
  }

  Future<void> scrollTo(int index) async {
    if (scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.pop(context);
    }
    final target = keys[index].currentContext;
    if (target != null) {
      await Scrollable.ensureVisible(
        target,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final desktop = MediaQuery.sizeOf(context).width >= 900;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: desktop
          ? null
          : MobileNavDrawer(labels: labels, active: active, onTap: scrollTo),
      body: Row(
        children: [
          if (desktop)
            PortfolioSidebar(labels: labels, active: active, onTap: scrollTo),
          Expanded(
            child: Stack(
              children: [
                CustomScrollView(
                  controller: controller,
                  slivers: [
                    if (!desktop)
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: AppColors.sidebar,
                        foregroundColor: Colors.white,
                        leading: IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () =>
                              scaffoldKey.currentState?.openDrawer(),
                        ),
                        title: const Text(
                          'YK.',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                          ),
                        ),
                        actions: [
                          ...[
                            (
                              FontAwesomeIcons.github,
                              'GitHub',
                              PortfolioData.github,
                            ),
                            (
                              FontAwesomeIcons.linkedinIn,
                              'LinkedIn',
                              PortfolioData.linkedin,
                            ),
                            (
                              FontAwesomeIcons.instagram,
                              'Instagram',
                              PortfolioData.instagram,
                            ),
                            (
                              FontAwesomeIcons.snapchat,
                              'Snapchat',
                              PortfolioData.snapchat,
                            ),
                          ].map(
                            (social) => IconButton(
                              constraints: const BoxConstraints.tightFor(
                                width: 38,
                                height: 48,
                              ),
                              padding: EdgeInsets.zero,
                              icon: FaIcon(social.$1, size: 17),
                              tooltip: social.$2,
                              onPressed: () =>
                                  openExternalUrl(context, social.$3),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    SliverToBoxAdapter(
                      child: KeyedSubtree(
                        key: keys[0],
                        child: HeroSection(
                          onProjects: () => scrollTo(2),
                          onAbout: () => scrollTo(1),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: KeyedSubtree(
                        key: keys[1],
                        child: AboutSection(scrollController: controller),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: KeyedSubtree(
                        key: keys[2],
                        child: ProjectsSection(scrollController: controller),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: KeyedSubtree(
                        key: keys[3],
                        child: ContactSection(scrollController: controller),
                      ),
                    ),
                    const SliverToBoxAdapter(child: _Footer()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) => Container(
    color: AppColors.sidebar,
    padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 40),
    child: Row(
      children: [
        const Text(
          'YK.',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        const Spacer(),
        Text(
          '© ${DateTime.now().year} Yasin Khan ·  Full Stack Developer ',
          style: TextStyle(color: AppColors.sidebarMuted, fontSize: 12),
        ),
      ],
    ),
  );
}
