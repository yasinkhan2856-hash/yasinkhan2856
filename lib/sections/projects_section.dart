import 'package:flutter/material.dart';
import '../data/portfolio_data.dart';
import '../models/project.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/project_visual.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String activeFilter = 'All';

  List<Project> get filteredProjects {
    if (activeFilter == 'All') return PortfolioData.projects;
    return PortfolioData.projects
        .where((p) => p.filterTag == activeFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) => SectionBlock(
    background: AppColors.surface,
    child: ScrollReveal(
      scrollController: widget.scrollController,
      child: Column(
        children: [
          const SectionTitleBox(title: 'Portfolio'),
          const SizedBox(height: 40),
          _FilterBar(
            filters: PortfolioData.portfolioFilters,
            active: activeFilter,
            onChanged: (f) => setState(() => activeFilter = f),
          ),
          const SizedBox(height: 40),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: LayoutBuilder(
              key: ValueKey(activeFilter),
              builder: (context, constraints) {
                final projects = filteredProjects;
                final cols = constraints.maxWidth > 720 ? 2 : 1;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: projects.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: cols,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    mainAxisExtent: cols == 2 ? 540 : 570,
                  ),
                  itemBuilder: (context, i) => _ProjectCard(
                    project: projects[i],
                    delay: Duration(milliseconds: i * 80),
                    featured: projects[i].featured,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({
    required this.filters,
    required this.active,
    required this.onChanged,
  });

  final List<String> filters;
  final String active;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) => Wrap(
    alignment: WrapAlignment.center,
    spacing: 8,
    runSpacing: 8,
    children: filters.map((filter) {
      final selected = filter == active;
      return _FilterChip(
        label: filter,
        selected: selected,
        onTap: () => onChanged(filter),
      );
    }).toList(),
  );
}

class _FilterChip extends StatefulWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_FilterChip> createState() => _FilterChipState();
}

class _FilterChipState extends State<_FilterChip> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => hovered = true),
    onExit: (_) => setState(() => hovered = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        decoration: BoxDecoration(
          color: widget.selected
              ? AppColors.accent
              : hovered
              ? AppColors.accent.withValues(alpha: .08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: widget.selected ? AppColors.accent : AppColors.border,
          ),
        ),
        child: Text(
          widget.label.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            color: widget.selected
                ? Colors.white
                : hovered
                ? AppColors.accent
                : AppColors.muted,
          ),
        ),
      ),
    ),
  );
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.project,
    required this.delay,
    this.featured = false,
  });
  final Project project;
  final Duration delay;
  final bool featured;

  @override
  Widget build(BuildContext context) => FadeSlideIn(
    delay: delay,
    child: HoverCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProjectVisual(project: project),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        project.category.toUpperCase(),
                        style: TextStyle(
                          color: project.color,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    if (featured)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'FEATURED',
                          style: TextStyle(
                            color: AppColors.accent,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  project.title,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 8),
                Text(
                  project.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: project.technologies.take(4).map(Pill.new).toList(),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _ProjectLink(
                      icon: Icons.code,
                      label: 'GitHub',
                      onTap: () => openExternalUrl(context, project.githubUrl),
                    ),
                    if (project.demoUrl != null)
                      _ProjectLink(
                        icon: Icons.play_circle_outline,
                        label: 'Watch Demo',
                        onTap: () => openExternalUrl(context, project.demoUrl!),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _ProjectLink extends StatefulWidget {
  const _ProjectLink({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  State<_ProjectLink> createState() => _ProjectLinkState();
}

class _ProjectLinkState extends State<_ProjectLink> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => hovered = true),
    onExit: (_) => setState(() => hovered = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: hovered
              ? AppColors.accent.withValues(alpha: .1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: hovered ? AppColors.accent : AppColors.borderLight,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              size: 16,
              color: hovered ? AppColors.accent : AppColors.muted,
            ),
            const SizedBox(width: 6),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: hovered ? AppColors.accent : AppColors.muted,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
