import 'package:flutter/material.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/animations.dart';
import '../widgets/common.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) => SectionBlock(
    background: AppColors.surface,
    child: ScrollReveal(
      scrollController: scrollController,
      child: Column(
        children: [
          const SectionTitleBox(title: 'About Me'),
          const SizedBox(height: 48),
          Text(
            '${PortfolioData.name}, ${PortfolioData.role} & Problem Solver.',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              'I\'m a Flutter and Full Stack Software Developer focused on cross-platform applications for Android and iOS, with practical backend experience using Firebase, Supabase, and Node.js. I build applications end to end — from architecture and polished responsive interfaces through REST API integration, authentication, cloud data, and release preparation.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 48),
          _StatsGrid(scrollController: scrollController),
          const SizedBox(height: 56),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'WHAT I DO',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
                color: AppColors.text,
              ),
            ),
          ),
          const SizedBox(height: 28),
          LayoutBuilder(
            builder: (context, c) {
              final cols = c.maxWidth > 700 ? 2 : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: PortfolioData.whatIDo.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: cols == 2 ? 2.4 : 2.0,
                ),
                itemBuilder: (context, i) {
                  final item = PortfolioData.whatIDo[i];
                  return HoverCard(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: .1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            item.$1,
                            color: AppColors.accent,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.$2,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                item.$3,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    ),
  );
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
    decoration: BoxDecoration(
      color: AppColors.statsBg,
      borderRadius: BorderRadius.circular(4),
    ),
    child: LayoutBuilder(
      builder: (context, c) {
        final cols = c.maxWidth > 600 ? 4 : 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: PortfolioData.stats.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: 16,
            mainAxisSpacing: 24,
            childAspectRatio: cols == 4 ? 1.6 : 1.4,
          ),
          itemBuilder: (context, i) {
            final stat = PortfolioData.stats[i];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedCounter(
                  value: stat.$1,
                  scrollController: scrollController,
                  style: const TextStyle(
                    color: AppColors.accent,
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  stat.$2.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .7),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        );
      },
    ),
  );
}
