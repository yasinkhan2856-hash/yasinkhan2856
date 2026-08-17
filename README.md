# Yasin Khan — Flutter Web Portfolio
A responsive portfolio built entirely with Flutter, Dart, and Material 3.

## Run locally

```bash
flutter pub get
flutter run -d chrome
```

## Verify and build

```bash
flutter analyze
flutter test
flutter build web --base-href /yasinkhan2856/
```

The deployable output is generated in `build/web`.

## Portfolio links

GitHub, LinkedIn, email, phone, and individual project repository links are configured in `lib/data/portfolio_data.dart`.

## Deploy to GitHub Pages

Build with the repository base path:

```bash
flutter build web --release --base-href /yasinkhan2856/
```

Then publish the contents of `build/web` to the `gh-pages` branch. One simple approach is:

```bash
git subtree push --prefix build/web origin gh-pages
```

In GitHub, open **Settings → Pages** and select the `gh-pages` branch with the `/ (root)` directory. The site will be available at `https://yasinkhan2856-hash.github.io/yasinkhan2856/`.
