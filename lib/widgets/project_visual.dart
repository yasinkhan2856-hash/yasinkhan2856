import 'package:flutter/material.dart';
import '../models/project.dart';
import '../theme/app_theme.dart';

class ProjectVisual extends StatefulWidget {
  const ProjectVisual({super.key, required this.project, this.large = false});
  final Project project;
  final bool large;

  @override
  State<ProjectVisual> createState() => _ProjectVisualState();
}

class _ProjectVisualState extends State<ProjectVisual> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final image = project.imageAsset;
    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        child: Container(
          height: widget.large ? 280 : 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: project.color.withValues(alpha: .08),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (image != null)
                AnimatedScale(
                  scale: hovered ? 1.06 : 1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutCubic,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    filterQuality: FilterQuality.high,
                    errorBuilder: (_, _, _) =>
                        _FallbackVisual(project: project),
                  ),
                )
              else
                _FallbackVisual(project: project),
              AnimatedOpacity(
                opacity: hovered ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  color: AppColors.sidebar.withValues(alpha: .72),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(project.icon, color: Colors.white, size: 36),
                      const SizedBox(height: 8),
                      Text(
                        project.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .92),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    project.filterTag.toUpperCase(),
                    style: TextStyle(
                      color: project.color,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FallbackVisual extends StatelessWidget {
  const _FallbackVisual({required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: _GridPainter(project.color.withValues(alpha: .12)),
    child: Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: project.color.withValues(alpha: .12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(project.icon, color: project.color, size: 36),
      ),
    ),
  );
}

class _GridPainter extends CustomPainter {
  _GridPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 32) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 32) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) =>
      oldDelegate.color != color;
}
