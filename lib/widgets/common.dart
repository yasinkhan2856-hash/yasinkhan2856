import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'url_opener.dart';

const double maxContentWidth = 960;
const double sidebarWidth = 260;

void openExternalUrl(BuildContext context, String url) {
  if (url.startsWith('ADD_')) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'This link is a placeholder. Add the real URL before publishing.',
        ),
      ),
    );
    return;
  }
  openPlatformUrl(url);
}

class ContentWidth extends StatelessWidget {
  const ContentWidth({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 40),
  });
  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: maxContentWidth),
      child: Padding(padding: padding, child: child),
    ),
  );
}

class SectionTitleBox extends StatefulWidget {
  const SectionTitleBox({super.key, required this.title});
  final String title;

  @override
  State<SectionTitleBox> createState() => _SectionTitleBoxState();
}

class _SectionTitleBoxState extends State<SectionTitleBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.border, width: 1.5),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            widget.title.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              letterSpacing: 3,
              color: AppColors.text,
            ),
          ),
        ),
      ),
      const SizedBox(height: 14),
      Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) => FractionallySizedBox(
            widthFactor: 0.35 + 0.65 * Curves.easeInOut.transform(_controller.value),
            child: Container(
              height: 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF7C3AED), Color(0xFF0EA5E9)],
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

class SectionBlock extends StatelessWidget {
  const SectionBlock({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 80),
    this.background = AppColors.background,
  });
  final Widget child;
  final EdgeInsets padding;
  final Color background;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: background,
    child: ContentWidth(
      child: Padding(padding: padding, child: child),
    ),
  );
}

class Pill extends StatelessWidget {
  const Pill(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: AppColors.surface,
      border: Border.all(color: AppColors.borderLight),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      label,
      style: const TextStyle(fontSize: 11, color: AppColors.muted),
    ),
  );
}

class PremiumButton extends StatefulWidget {
  const PremiumButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.outlined = false,
    this.icon,
  });
  final String label;
  final VoidCallback onPressed;
  final bool outlined;
  final IconData? icon;

  @override
  State<PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => hovered = true),
    onExit: (_) => setState(() => hovered = false),
    child: AnimatedScale(
      scale: hovered ? 1.04 : 1,
      duration: const Duration(milliseconds: 180),
      child: widget.outlined
          ? OutlinedButton.icon(
              onPressed: widget.onPressed,
              icon: Icon(widget.icon ?? Icons.arrow_forward, size: 18),
              label: Text(widget.label),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.text,
                side: const BorderSide(color: AppColors.border),
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            )
          : FilledButton.icon(
              onPressed: widget.onPressed,
              icon: Icon(widget.icon ?? Icons.arrow_forward, size: 18),
              label: Text(widget.label),
              style: FilledButton.styleFrom(
                backgroundColor: hovered
                    ? AppColors.accentDark
                    : AppColors.accent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 16,
                ),
              ),
            ),
    ),
  );
}

class HoverCard extends StatefulWidget {
  const HoverCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
  });
  final Widget child;
  final EdgeInsets padding;

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => hovered = true),
    onExit: (_) => setState(() => hovered = false),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      transform: Matrix4.translationValues(0, hovered ? -6 : 0, 0),
      padding: widget.padding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(
          color: hovered
              ? AppColors.accent.withValues(alpha: .4)
              : AppColors.borderLight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: hovered
            ? [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: .12),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: widget.child,
    ),
  );
}

class FadeSlideIn extends StatefulWidget {
  const FadeSlideIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offsetY = 30,
  });
  final Widget child;
  final Duration delay;
  final double offsetY;

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _slide = Tween<Offset>(
      begin: Offset(0, widget.offsetY / 100),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: _fade,
    child: SlideTransition(position: _slide, child: widget.child),
  );
}

class ScrollReveal extends StatefulWidget {
  const ScrollReveal({
    super.key,
    required this.child,
    required this.scrollController,
    this.delay = Duration.zero,
  });
  final Widget child;
  final ScrollController scrollController;
  final Duration delay;

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    widget.scrollController.addListener(_checkVisibility);
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  @override
  void didUpdateWidget(covariant ScrollReveal oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scrollController != widget.scrollController) {
      oldWidget.scrollController.removeListener(_checkVisibility);
      widget.scrollController.addListener(_checkVisibility);
      _checkVisibility();
    }
  }

  void _checkVisibility() {
    if (!mounted || _revealed) return;
    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return;
    final position = renderObject.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.sizeOf(context).height;
    if (position.dy < screenHeight * 0.95) {
      _revealed = true;
      widget.scrollController.removeListener(_checkVisibility);
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_checkVisibility);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
            .animate(
              CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
            ),
        child: widget.child,
      ),
    );
  }
}
