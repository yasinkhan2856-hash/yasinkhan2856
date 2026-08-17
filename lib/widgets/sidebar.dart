import 'package:flutter/material.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'common.dart';

class PortfolioSidebar extends StatelessWidget {
  const PortfolioSidebar({
    super.key,
    required this.labels,
    required this.active,
    required this.onTap,
  });

  final List<String> labels;
  final int active;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) => Container(
    width: sidebarWidth,
    color: AppColors.sidebar,
    child: SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 36),
          _ProfileAvatar(onTap: () => onTap(0)),
          const SizedBox(height: 18),
          const _ProfileHeader(),
          const SizedBox(height: 32),
          ...List.generate(
            labels.length,
            (i) => _NavItem(
              label: labels[i],
              active: active == i,
              onTap: () => onTap(i),
            ),
          ),
          const Spacer(),
          _SocialRow(onOpen: (url) => openExternalUrl(context, url)),
          const SizedBox(height: 32),
        ],
      ),
    ),
  );
}

class MobileNavDrawer extends StatelessWidget {
  const MobileNavDrawer({
    super.key,
    required this.labels,
    required this.active,
    required this.onTap,
  });

  final List<String> labels;
  final int active;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) => Drawer(
    backgroundColor: AppColors.sidebar,
    child: SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 24),
          _ProfileAvatar(
            onTap: () {
              Navigator.pop(context);
              onTap(0);
            },
          ),
          const SizedBox(height: 18),
          const _ProfileHeader(),
          const SizedBox(height: 24),
          ...List.generate(
            labels.length,
            (i) => _NavItem(
              label: labels[i],
              active: active == i,
              onTap: () {
                Navigator.pop(context);
                onTap(i);
              },
            ),
          ),
          const Spacer(),
          _SocialRow(onOpen: (url) => openExternalUrl(context, url)),
          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.accent, width: 3),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: .25),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/profile_pic.jpg',
          fit: BoxFit.cover,
          alignment: const Alignment(0, -0.3),
          errorBuilder: (_, _, _) => const ColoredBox(
            color: AppColors.statsBg,
            child: Icon(Icons.person, color: AppColors.sidebarMuted, size: 40),
          ),
        ),
      ),
    ),
  );
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) => Column(
    children: [
      const Text(
        PortfolioData.name,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 19,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
      const SizedBox(height: 6),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: .15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.accent.withValues(alpha: .4)),
        ),
        child: const Text(
          'FULL STACK DEVELOPER',
          style: TextStyle(
            color: AppColors.accent,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
      ),
    ],
  );
}

class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => hovered = true),
    onExit: (_) => setState(() => hovered = false),
    child: GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: widget.active ? AppColors.accent : Colors.transparent,
              width: 3,
            ),
          ),
          color: widget.active || hovered
              ? Colors.white.withValues(alpha: .06)
              : Colors.transparent,
        ),
        child: Text(
          widget.label.toUpperCase(),
          style: TextStyle(
            color: widget.active
                ? Colors.white
                : hovered
                ? Colors.white.withValues(alpha: .9)
                : AppColors.sidebarMuted,
            fontSize: 12,
            fontWeight: widget.active ? FontWeight.w700 : FontWeight.w500,
            letterSpacing: 1.8,
          ),
        ),
      ),
    ),
  );
}

class _SocialRow extends StatelessWidget {
  const _SocialRow({required this.onOpen});

  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) => Wrap(
    alignment: WrapAlignment.center,
    spacing: 8,
    runSpacing: 8,
    children: [
      _SocialIcon(
        icon: Icons.code,
        tooltip: 'GitHub',
        onTap: () => onOpen(PortfolioData.github),
      ),
      _SocialIcon(
        icon: Icons.work_outline,
        tooltip: 'LinkedIn',
        onTap: () => onOpen(PortfolioData.linkedin),
      ),
      _SocialIcon(
        icon: Icons.camera_alt_outlined,
        tooltip: 'Instagram',
        onTap: () => onOpen(PortfolioData.instagram),
      ),
      _SocialIcon(
        icon: Icons.chat_bubble_outline,
        tooltip: 'Snapchat',
        onTap: () => onOpen(PortfolioData.snapchat),
      ),
    ],
  );
}

class _SocialIcon extends StatefulWidget {
  const _SocialIcon({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => hovered = true),
    onExit: (_) => setState(() => hovered = false),
    child: Tooltip(
      message: widget.tooltip,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: hovered
                ? AppColors.accent.withValues(alpha: .2)
                : Colors.white.withValues(alpha: .08),
            border: Border.all(
              color: hovered ? AppColors.accent : Colors.white24,
            ),
          ),
          child: Icon(
            widget.icon,
            color: hovered ? AppColors.accent : AppColors.sidebarMuted,
            size: 20,
          ),
        ),
      ),
    ),
  );
}
