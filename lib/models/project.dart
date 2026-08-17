import 'package:flutter/material.dart';

class Project {
  const Project({
    required this.title,
    required this.category,
    required this.description,
    required this.technologies,
    required this.filterTag,
    this.features = const [],
    required this.icon,
    required this.color,
    required this.githubUrl,
    this.demoUrl,
    this.imageAsset,
    this.featured = false,
  });

  final String title;
  final String category;
  final String description;
  final List<String> technologies;
  final List<String> features;
  final String filterTag;
  final IconData icon;
  final Color color;
  final bool featured;
  final String githubUrl;
  final String? demoUrl;
  final String? imageAsset;
}
