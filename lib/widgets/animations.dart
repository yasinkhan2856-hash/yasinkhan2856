import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class TypewriterText extends StatefulWidget {
  const TypewriterText({
    super.key,
    required this.text,
    this.style,
    this.period = const Duration(milliseconds: 45),
  });

  final String text;
  final TextStyle? style;
  final Duration period;

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  Timer? _typeTimer;
  Timer? _blinkTimer;
  int _chars = 0;
  bool _cursorOn = true;

  @override
  void initState() {
    super.initState();
    _typeTimer = Timer.periodic(widget.period, (_) {
      if (!mounted) return;
      if (_chars >= widget.text.length) {
        _typeTimer?.cancel();
        return;
      }
      setState(() => _chars++);
    });
    _blinkTimer = Timer.periodic(const Duration(milliseconds: 530), (_) {
      if (!mounted) return;
      setState(() => _cursorOn = !_cursorOn);
    });
  }

  @override
  void dispose() {
    _typeTimer?.cancel();
    _blinkTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final done = _chars >= widget.text.length;
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: widget.text.substring(0, _chars)),
          TextSpan(
            text: _cursorOn || !done ? '|' : ' ',
            style: const TextStyle(
              color: AppColors.accent,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      style: widget.style,
    );
  }
}

class GradientText extends StatefulWidget {
  const GradientText({super.key, required this.text, required this.style});

  final String text;
  final TextStyle style;

  @override
  State<GradientText> createState() => _GradientTextState();
}

class _GradientTextState extends State<GradientText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _controller,
    builder: (context, _) {
      final angle = _controller.value * 2 * math.pi;
      return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => LinearGradient(
          begin: Alignment(math.cos(angle), math.sin(angle)),
          end: Alignment(-math.cos(angle), -math.sin(angle)),
          colors: const [
            Color(0xFF2563EB),
            Color(0xFF7C3AED),
            Color(0xFF0EA5E9),
            Color(0xFF2563EB),
          ],
        ).createShader(bounds),
        child: Text(widget.text, style: widget.style.copyWith(color: Colors.white)),
      );
    },
  );
}

class GradientBlobs extends StatefulWidget {
  const GradientBlobs({super.key});

  @override
  State<GradientBlobs> createState() => _GradientBlobsState();
}

class _GradientBlobsState extends State<GradientBlobs>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _controller,
    builder: (context, _) {
      final t = _controller.value;
      return IgnorePointer(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: -120 + t * 80,
              top: -90 + (1 - t) * 60,
              child: _Blob(
                color: AppColors.accent.withValues(alpha: .16),
                size: 320,
              ),
            ),
            Positioned(
              right: -110 + (1 - t) * 90,
              top: 60 + t * 40,
              child: _Blob(
                color: const Color(0xFF7C3AED).withValues(alpha: .13),
                size: 280,
              ),
            ),
            Positioned(
              left: 30 + t * 50,
              bottom: -40,
              child: _Blob(
                color: const Color(0xFF0EA5E9).withValues(alpha: .12),
                size: 240,
              ),
            ),
          ],
        ),
      );
    },
  );
}

class _Blob extends StatelessWidget {
  const _Blob({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        colors: [color, color.withValues(alpha: 0)],
      ),
    ),
  );
}

class FloatingAnimation extends StatefulWidget {
  const FloatingAnimation({
    super.key,
    required this.child,
    this.distance = 9,
    this.duration = const Duration(seconds: 4),
  });

  final Widget child;
  final double distance;
  final Duration duration;

  @override
  State<FloatingAnimation> createState() => _FloatingAnimationState();
}

class _FloatingAnimationState extends State<FloatingAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);
    _anim = Tween<double>(begin: -widget.distance, end: widget.distance).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _anim,
    builder: (context, child) =>
        Transform.translate(offset: Offset(0, _anim.value), child: child),
    child: widget.child,
  );
}

class AnimatedCounter extends StatefulWidget {
  const AnimatedCounter({
    super.key,
    required this.value,
    required this.style,
    required this.scrollController,
    this.duration = const Duration(milliseconds: 1400),
  });

  final String value;
  final TextStyle style;
  final ScrollController scrollController;
  final Duration duration;

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool _started = false;

  double get _target => double.parse(
    widget.value.replaceAll(RegExp(r'[^0-9.]'), ''),
  );

  String get _suffix => widget.value.replaceAll(RegExp(r'[0-9.]'), '');

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    widget.scrollController.addListener(_check);
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (_started || !mounted) return;
    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return;
    final position = renderObject.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.sizeOf(context).height;
    if (position.dy < screenHeight * 0.95) {
      _started = true;
      widget.scrollController.removeListener(_check);
      _controller.forward();
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_check);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPercent = _suffix == '%';
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final v = _animation.value * _target;
        final text = isPercent ? v.toStringAsFixed(0) : v.round().toString();
        return Text('$text$_suffix', style: widget.style);
      },
    );
  }
}