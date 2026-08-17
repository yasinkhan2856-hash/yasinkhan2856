import 'package:flutter/material.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/animations.dart';
import '../widgets/common.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onProjects,
    required this.onAbout,
  });

  final VoidCallback onProjects;
  final VoidCallback onAbout;

  @override
  Widget build(BuildContext context) => SectionBlock(
    padding: const EdgeInsets.only(top: 60, bottom: 70),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        const Positioned.fill(child: GradientBlobs()),
        LayoutBuilder(
          builder: (context, constraints) {
            final desktop = constraints.maxWidth >= 720;
            return Column(
              children: [
                desktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 11,
                            child: _HeroCopy(
                              onProjects: onProjects,
                              onAbout: onAbout,
                            ),
                          ),
                          const SizedBox(width: 48),
                          const Expanded(flex: 9, child: _HeroPhoto()),
                        ],
                      )
                    : Column(
                        children: [
                          _HeroCopy(onProjects: onProjects, onAbout: onAbout),
                          const SizedBox(height: 40),
                          const _HeroPhoto(),
                        ],
                      ),
              ],
            );
          },
        ),
      ],
    ),
  );
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({required this.onProjects, required this.onAbout});
  final VoidCallback onProjects;
  final VoidCallback onAbout;

  @override
  Widget build(BuildContext context) => FadeSlideIn(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'HI THERE!',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 4,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 10),
        GradientText(
          text: "I'M ${PortfolioData.name.toUpperCase()}",
          style: TextStyle(
            fontSize: MediaQuery.sizeOf(context).width >= 720 ? 52 : 36,
            height: 1.08,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.heroTag.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.heroTag.withValues(alpha: .3)),
          ),
          child: Text(
            PortfolioData.role.toUpperCase(),
            style: const TextStyle(
              color: AppColors.heroTag,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 24),
        TypewriterText(
          text: PortfolioData.subtitle,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 18),
        Text(
          'Flutter Developer and Full Stack Developer with 2+ years of hands-on experience building cross-platform mobile applications and backend integrations for Android and iOS.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            PremiumButton(
              label: 'View My Work',
              icon: Icons.arrow_downward,
              onPressed: onProjects,
            ),
            PremiumButton(
              label: 'More About Me',
              outlined: true,
              icon: Icons.person_outline,
              onPressed: onAbout,
            ),
          ],
        ),
      ],
    ),
  );
}

class _HeroPhoto extends StatelessWidget {
  const _HeroPhoto();

  @override
  Widget build(BuildContext context) => FadeSlideIn(
    delay: const Duration(milliseconds: 200),
    child: FloatingAnimation(
      child: Container(
        height: MediaQuery.sizeOf(context).width >= 720 ? 480 : 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .12),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/profile_pic.jpg',
                fit: BoxFit.cover,
                alignment: const Alignment(0, -0.25),
                filterQuality: FilterQuality.high,
                errorBuilder: (_, _, _) => ColoredBox(
                  color: AppColors.statsBg,
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: AppColors.muted.withValues(alpha: .5),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: .75),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        PortfolioData.name.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        PortfolioData.subtitle,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: .85),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
