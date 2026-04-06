# Video Manager + Login Background Video Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Login ekranına looping mute arka plan video eklemek, Hardware Manager Pattern'e uygun VideoManager singleton oluşturmak ve staggered giriş animasyonları ile premium his sağlamak.

**Architecture:** VideoManager singleton `core/services/` altında, `WidgetsBindingObserver` ile app lifecycle yönetimi. Login screen'e Stack ile video katmanı + overlay + mevcut CustomPaint gradient + staggered animasyonlu form. `video_player` + `visibility_detector` paketleri.

**Tech Stack:** Flutter, video_player, visibility_detector, Riverpod, AnimationController + Interval

---

## File Structure

| Dosya | Sorumluluk | İşlem |
|-------|-----------|-------|
| `qulov2/pubspec.yaml` | Paket + asset tanımı | Modify |
| `qulov2/lib/core/services/video_manager.dart` | Singleton video manager | Create |
| `qulov2/lib/features/auth/widgets/background_video.dart` | Video arka plan widget | Create |
| `qulov2/lib/features/auth/widgets/staggered_column.dart` | Staggered animasyon wrapper | Create |
| `qulov2/lib/features/auth/screens/login_screen.dart` | Video + animasyon entegrasyonu | Modify |
| `qulov2/lib/main.dart` | VideoManager.init() çağrısı | Modify |
| `.claude/skills/businessCaseSkills/video-player-guard.md` | Video player skill kuralları | Create |

---

### Task 1: Paket ekleme + asset tanımı

**Files:**
- Modify: `qulov2/pubspec.yaml:30-97`

- [ ] **Step 1: pubspec.yaml'a video_player ve visibility_detector ekle**

`qulov2/pubspec.yaml` dosyasındaki `dependencies:` bölümüne ekle (alphabetik sırayla):

```yaml
  url_launcher: ^6.3.1
  uuid: ^4.5.3
  video_player: ^2.9.3
  visibility_detector: ^0.4.0+2
  webview_flutter: ^4.13.1
```

- [ ] **Step 2: assets bölümüne videos/ klasörünü ekle**

`qulov2/pubspec.yaml` dosyasındaki `flutter: assets:` bölümüne ekle:

```yaml
  assets:
    - assets/icons/
    - assets/brand/
    - assets/illustrations/
    - assets/lottie/
    - assets/map/
    - assets/videos/
```

- [ ] **Step 3: flutter pub get çalıştır**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2 && flutter pub get`
Expected: "Got dependencies!" mesajı, hata yok.

- [ ] **Step 4: Commit**

```bash
git add qulov2/pubspec.yaml qulov2/pubspec.lock
git commit -m "chore: add video_player and visibility_detector packages"
```

---

### Task 2: VideoManager singleton oluştur

**Files:**
- Create: `qulov2/lib/core/services/video_manager.dart`

- [ ] **Step 1: VideoManager sınıfını yaz**

`qulov2/lib/core/services/video_manager.dart` dosyasını oluştur:

```dart
import 'dart:developer' as dev;

import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

/// Singleton video manager — Hardware Manager Pattern.
///
/// Arka plan video oynatımı için controller lifecycle yönetimi sağlar.
/// Dispose öncesi pause ZORUNLU. Max 1 aktif video kuralı.
class VideoManager with WidgetsBindingObserver {
  VideoManager._();
  static final VideoManager instance = VideoManager._();

  /// Asset path → controller cache.
  final Map<String, VideoPlayerController> _controllers = {};

  /// App pause öncesi oynayan controller'lar (resume için).
  final Set<String> _wasPlaying = {};

  bool _initialized = false;

  /// App başlangıcında çağrılır (main.dart).
  void init() {
    if (_initialized) return;
    _initialized = true;
    WidgetsBinding.instance.addObserver(this);
    dev.log('[VideoManager] Initialized', name: 'VideoManager');
  }

  /// Controller oluştur veya cache'den al.
  /// Otomatik: initialize + setLooping(true) + setVolume(0) + play.
  /// Max 1 aktif video — mevcut varsa önce release edilir.
  Future<VideoPlayerController> acquire(String assetPath) async {
    // Aynı asset zaten cache'de ise direkt dön
    if (_controllers.containsKey(assetPath)) {
      return _controllers[assetPath]!;
    }

    // Max 1 aktif video kuralı — mevcut controller varsa release et
    if (_controllers.isNotEmpty) {
      await releaseAll();
    }

    dev.log('[VideoManager] Acquiring: $assetPath', name: 'VideoManager');

    final controller = VideoPlayerController.asset(assetPath);
    _controllers[assetPath] = controller;

    await controller.initialize();
    await controller.setLooping(true);
    await controller.setVolume(0.0);
    await controller.play();

    dev.log('[VideoManager] Playing: $assetPath', name: 'VideoManager');
    return controller;
  }

  /// Pause → dispose → cache'den sil.
  Future<void> release(String assetPath) async {
    final controller = _controllers.remove(assetPath);
    if (controller == null) return;

    _wasPlaying.remove(assetPath);

    dev.log('[VideoManager] Releasing: $assetPath', name: 'VideoManager');

    // Dispose öncesi pause ZORUNLU
    if (controller.value.isPlaying) {
      await controller.pause();
    }
    await controller.dispose();
  }

  /// Tüm controller'ları release et.
  Future<void> releaseAll() async {
    final paths = List<String>.from(_controllers.keys);
    for (final path in paths) {
      await release(path);
    }
  }

  /// Manuel pause.
  Future<void> pause(String assetPath) async {
    final controller = _controllers[assetPath];
    if (controller == null || !controller.value.isPlaying) return;
    await controller.pause();
  }

  /// Manuel resume.
  Future<void> resume(String assetPath) async {
    final controller = _controllers[assetPath];
    if (controller == null || controller.value.isPlaying) return;
    await controller.play();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        _pauseAll();
      case AppLifecycleState.resumed:
        _resumeAll();
      default:
        break;
    }
  }

  void _pauseAll() {
    _wasPlaying.clear();
    for (final entry in _controllers.entries) {
      if (entry.value.value.isPlaying) {
        _wasPlaying.add(entry.key);
        entry.value.pause();
      }
    }
    if (_wasPlaying.isNotEmpty) {
      dev.log('[VideoManager] Paused ${_wasPlaying.length} video(s)', name: 'VideoManager');
    }
  }

  void _resumeAll() {
    for (final path in _wasPlaying) {
      _controllers[path]?.play();
    }
    if (_wasPlaying.isNotEmpty) {
      dev.log('[VideoManager] Resumed ${_wasPlaying.length} video(s)', name: 'VideoManager');
    }
    _wasPlaying.clear();
  }
}
```

- [ ] **Step 2: flutter analyze çalıştır**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2 && flutter analyze --no-pub lib/core/services/video_manager.dart`
Expected: "No issues found!" — sıfır hata.

- [ ] **Step 3: main.dart'a VideoManager.init() ekle**

`qulov2/lib/main.dart` dosyasında, import bölümüne ekle:

```dart
import 'package:qulo_v2/core/services/video_manager.dart';
```

`main()` fonksiyonunda `Firebase.initializeApp()` satırından sonra ekle:

```dart
  VideoManager.instance.init();
```

- [ ] **Step 4: flutter analyze çalıştır**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2 && flutter analyze --no-pub`
Expected: "No issues found!"

- [ ] **Step 5: Commit**

```bash
git add qulov2/lib/core/services/video_manager.dart qulov2/lib/main.dart
git commit -m "feat: add VideoManager singleton with lifecycle management"
```

---

### Task 3: BackgroundVideo widget oluştur

**Files:**
- Create: `qulov2/lib/features/auth/widgets/background_video.dart`

- [ ] **Step 1: BackgroundVideo widget'ını yaz**

`qulov2/lib/features/auth/widgets/background_video.dart` dosyasını oluştur:

```dart
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:qulo_v2/core/services/video_manager.dart';

/// Tam ekran arka plan video widget'ı.
///
/// VideoManager üzerinden acquire/release yapar.
/// VisibilityDetector ile görünürlük takibi — ekran dışında pause.
class BackgroundVideo extends StatefulWidget {
  final String assetPath;
  final double overlayOpacity;

  const BackgroundVideo({
    super.key,
    required this.assetPath,
    this.overlayOpacity = 0.3,
  });

  @override
  State<BackgroundVideo> createState() => _BackgroundVideoState();
}

class _BackgroundVideoState extends State<BackgroundVideo> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    final controller = await VideoManager.instance.acquire(widget.assetPath);
    if (!mounted) {
      // Widget dispose edildiyse release et
      VideoManager.instance.release(widget.assetPath);
      return;
    }
    setState(() {
      _controller = controller;
      _isInitialized = controller.value.isInitialized;
    });
  }

  @override
  void dispose() {
    VideoManager.instance.release(widget.assetPath);
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!_isInitialized) return;
    if (info.visibleFraction == 0) {
      VideoManager.instance.pause(widget.assetPath);
    } else {
      VideoManager.instance.resume(widget.assetPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('bg_video_${widget.assetPath}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Video veya placeholder
          if (_isInitialized && _controller != null)
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller!.value.size.width,
                height: _controller!.value.size.height,
                child: VideoPlayer(_controller!),
              ),
            )
          else
            const ColoredBox(color: Colors.black),

          // Koyu overlay — form okunurluğu için
          ColoredBox(
            color: Colors.black.withValues(alpha: widget.overlayOpacity),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 2: flutter analyze çalıştır**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2 && flutter analyze --no-pub lib/features/auth/widgets/background_video.dart`
Expected: "No issues found!"

- [ ] **Step 3: Commit**

```bash
git add qulov2/lib/features/auth/widgets/background_video.dart
git commit -m "feat: add BackgroundVideo widget with visibility tracking"
```

---

### Task 4: StaggeredColumn animasyon widget oluştur

**Files:**
- Create: `qulov2/lib/features/auth/widgets/staggered_column.dart`

- [ ] **Step 1: StaggeredColumn widget'ını yaz**

`qulov2/lib/features/auth/widgets/staggered_column.dart` dosyasını oluştur:

```dart
import 'package:flutter/material.dart';

/// Çocuk widget'ları staggered fade-in + slide-up animasyonuyla gösterir.
///
/// Her çocuk sırayla 100ms arayla belirir.
/// İlk eleman scale animasyonu alır (logo için), diğerleri slide-up.
class StaggeredColumn extends StatefulWidget {
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final Duration totalDuration;
  final Duration staggerDelay;
  final double slideOffset;
  final VoidCallback? onReady;

  const StaggeredColumn({
    super.key,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.totalDuration = const Duration(milliseconds: 1200),
    this.staggerDelay = const Duration(milliseconds: 100),
    this.slideOffset = 20.0,
    this.onReady,
  });

  @override
  State<StaggeredColumn> createState() => StaggeredColumnState();
}

class StaggeredColumnState extends State<StaggeredColumn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _fadeAnimations;
  late final List<Animation<Offset>> _slideAnimations;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.totalDuration,
    );
    _buildAnimations();
  }

  void _buildAnimations() {
    final count = widget.children.length;
    final totalMs = widget.totalDuration.inMilliseconds;
    final staggerMs = widget.staggerDelay.inMilliseconds;
    // Her eleman için animasyon süresi (toplam - tüm stagger'lar)
    final itemDurationMs = totalMs - (count - 1) * staggerMs;

    _fadeAnimations = List.generate(count, (i) {
      final startMs = i * staggerMs;
      final endMs = startMs + itemDurationMs;
      return CurvedAnimation(
        parent: _controller,
        curve: Interval(
          startMs / totalMs,
          (endMs / totalMs).clamp(0.0, 1.0),
          curve: Curves.easeOutCubic,
        ),
      );
    });

    _slideAnimations = List.generate(count, (i) {
      return Tween<Offset>(
        begin: Offset(0, widget.slideOffset),
        end: Offset.zero,
      ).animate(_fadeAnimations[i]);
    });

    // İlk eleman (logo) için scale animasyonu
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      _fadeAnimations.isNotEmpty ? _fadeAnimations[0] : _controller,
    );
  }

  /// Dışarıdan animasyonu başlatmak için.
  void forward() {
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.crossAxisAlignment,
      children: List.generate(widget.children.length, (i) {
        if (i == 0) {
          // Logo — fade + scale
          return FadeTransition(
            opacity: _fadeAnimations[i],
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: widget.children[i],
            ),
          );
        }
        // Diğerleri — fade + slide-up
        return FadeTransition(
          opacity: _fadeAnimations[i],
          child: AnimatedBuilder(
            animation: _slideAnimations[i],
            builder: (context, child) {
              return Transform.translate(
                offset: _slideAnimations[i].value,
                child: child,
              );
            },
            child: widget.children[i],
          ),
        );
      }),
    );
  }
}
```

- [ ] **Step 2: flutter analyze çalıştır**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2 && flutter analyze --no-pub lib/features/auth/widgets/staggered_column.dart`
Expected: "No issues found!"

- [ ] **Step 3: Commit**

```bash
git add qulov2/lib/features/auth/widgets/staggered_column.dart
git commit -m "feat: add StaggeredColumn animation widget"
```

---

### Task 5: Login screen entegrasyonu

**Files:**
- Modify: `qulov2/lib/features/auth/screens/login_screen.dart`

- [ ] **Step 1: Login screen'i video + animasyon ile güncelle**

`qulov2/lib/features/auth/screens/login_screen.dart` dosyasının tamamını şu şekilde güncelle:

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qulo_v2/core/constants/app_assets.dart';
import 'package:qulo_v2/core/constants/app_sizes.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/mixins/form_mixin.dart';
import 'package:qulo_v2/core/mixins/loading_mixin.dart';
import 'package:qulo_v2/core/navigation/navigation.dart';
import 'package:qulo_v2/core/network/result.dart';
import 'package:qulo_v2/core/theme/app_colors.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/core/widgets/app_button.dart';
import 'package:qulo_v2/core/widgets/app_scaffold.dart';
import 'package:qulo_v2/core/widgets/app_text_field.dart';
import 'package:qulo_v2/features/auth/widgets/background_video.dart';
import 'package:qulo_v2/features/auth/widgets/staggered_column.dart';
import 'package:qulo_v2/providers/auth_provider.dart';
import 'package:qulo_v2/routing/route_names.dart';
import 'package:qulo_v2/features/auth/widgets/social_login_buttons.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> with FormMixin, LoadingMixin {
  static const _videoAsset = 'assets/videos/mock.mp4';

  final _emailCtrl = TextEditingController(
    text: kDebugMode
        ? const String.fromEnvironment('DEBUG_EMAIL', defaultValue: '')
        : null,
  );
  final _passwordCtrl = TextEditingController(
    text: kDebugMode
        ? const String.fromEnvironment('DEBUG_PASSWORD', defaultValue: '')
        : null,
  );
  bool _obscure = true;
  String? _loginError;

  final _staggeredKey = GlobalKey<StaggeredColumnState>();
  bool _videoReady = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _onVideoInitialized() {
    if (_videoReady) return;
    _videoReady = true;
    // Video hazır olunca animasyonu başlat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _staggeredKey.currentState?.forward();
    });
  }

  Future<void> _login() => withLoading(() async {
    setState(() => _loginError = null);
    if (!validateForm()) return;
    final result = await ref
        .read(authProvider.notifier)
        .login(email: _emailCtrl.text.trim(), password: _passwordCtrl.text);
    if (!mounted) return;
    result.when(
      success: (_) {},
      failure: (f) {
        final errorCode = switch (f) {
          ServerFailure(:final code) => code,
          NetworkFailure() => 'NETWORK_ERROR',
          TimeoutFailure() => 'TIMEOUT',
          _ => 'UNKNOWN',
        };
        setState(() => _loginError = context.l10n.errorMessage(errorCode));
      },
    );
  });

  Future<void> _socialLogin(String provider) => withLoading(() async {
    setState(() => _loginError = null);
    final result = await ref.read(authProvider.notifier).socialLogin(provider);
    if (!mounted) return;
    result.when(
      success: (_) {},
      failure: (f) {
        if (f.message?.contains('cancelled') != true) {
          final errorCode = switch (f) {
            ServerFailure(:final code) => code,
            NetworkFailure() => 'NETWORK_ERROR',
            TimeoutFailure() => 'TIMEOUT',
            _ => null,
          };
          if (errorCode != null) {
            setState(() => _loginError = context.l10n.errorMessage(errorCode));
          }
        }
      },
    );
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Arka plan video + overlay
          BackgroundVideo(
            assetPath: _videoAsset,
            overlayOpacity: 0.3,
            onInitialized: _onVideoInitialized,
          ),

          // Mevcut gradient daireler (CustomPaint)
          const _GradientOverlay(),

          // Form içeriği
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.pagePadding),
                  child: Form(
                    key: formKey,
                    child: StaggeredColumn(
                      key: _staggeredKey,
                      children: [
                        const SizedBox(height: AppSpacing.xxxl),
                        Center(
                          child: SvgPicture.asset(
                            AppAssets.logoSvg,
                            width: AppSizes.logoMd,
                            height: AppSizes.logoMd,
                            colorFilter: ColorFilter.mode(context.appColors.primary, BlendMode.srcIn),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          context.tr('app_name'),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.displaySmall?.copyWith(
                            color: context.appColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          context.tr('welcome_back'),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxxl),
                        AppTextField(
                          controller: _emailCtrl,
                          label: context.tr('email'),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: emailValidator,
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        AppTextField(
                          controller: _passwordCtrl,
                          label: context.tr('password'),
                          obscureText: _obscure,
                          textInputAction: TextInputAction.done,
                          validator: passwordValidator,
                          onFieldSubmitted: (_) => _login(),
                          errorText: _loginError,
                          prefixIcon: const Icon(Icons.lock_outlined),
                          suffixIcon: IconButton(
                            icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                            onPressed: () => setState(() => _obscure = !_obscure),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => ref.read(navigationServiceProvider).push(RouteNames.forgotPassword),
                            child: Text(context.tr('forgot_password')),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        AppButton(label: context.tr('login'), isLoading: isLoading, onPressed: isLoading ? null : _login),
                        const SizedBox(height: AppSpacing.lg),
                        SocialLoginButtons(
                          isLoading: isLoading,
                          onGooglePressed: () => _socialLogin('google'),
                          onApplePressed: () => _socialLogin('apple'),
                        ),
                        const SizedBox(height: AppSpacing.xxl),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(context.tr('no_account'), style: theme.textTheme.bodyMedium),
                            TextButton(
                              onPressed: () => ref.read(navigationServiceProvider).push(RouteNames.register),
                              child: Text(context.tr('register')),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// AppScaffold'daki gradient daireler — video üstünde görünür.
class _GradientOverlay extends StatelessWidget {
  const _GradientOverlay();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GradientPainter(
        primaryColor: context.appColors.primary,
        secondaryColor: context.appColors.secondary,
      ),
      child: const SizedBox.expand(),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;

  _GradientPainter({required this.primaryColor, required this.secondaryColor});

  @override
  void paint(Canvas canvas, Size size) {
    // Sağ üst — mor gradient daire
    final topRight = Offset(size.width * 0.85, size.height * 0.1);
    final topRightPaint = Paint()
      ..shader = RadialGradient(
        colors: [primaryColor.withValues(alpha: 0.06), primaryColor.withValues(alpha: 0.0)],
      ).createShader(Rect.fromCircle(center: topRight, radius: size.width * 0.5));
    canvas.drawCircle(topRight, size.width * 0.5, topRightPaint);

    // Sol alt — yeşil gradient daire
    final bottomLeft = Offset(size.width * 0.15, size.height * 0.9);
    final bottomLeftPaint = Paint()
      ..shader = RadialGradient(
        colors: [secondaryColor.withValues(alpha: 0.04), secondaryColor.withValues(alpha: 0.0)],
      ).createShader(Rect.fromCircle(center: bottomLeft, radius: size.width * 0.5));
    canvas.drawCircle(bottomLeft, size.width * 0.5, bottomLeftPaint);
  }

  @override
  bool shouldRepaint(covariant _GradientPainter oldDelegate) => false;
}
```

**Önemli:** Bu dosya artık `AppScaffold` kullanmıyor — kendi `Scaffold` + `Stack` yapısını kullanıyor çünkü video tam ekran olmalı. Mevcut `AppScaffold`'ın gradient daireleri `_GradientOverlay` olarak kopyalandı.

- [ ] **Step 2: BackgroundVideo'ya onInitialized callback ekle**

`qulov2/lib/features/auth/widgets/background_video.dart` dosyasına `onInitialized` callback'i ekle.

`BackgroundVideo` sınıfının constructor'ına ekle:

```dart
  final VoidCallback? onInitialized;

  const BackgroundVideo({
    super.key,
    required this.assetPath,
    this.overlayOpacity = 0.3,
    this.onInitialized,
  });
```

`_BackgroundVideoState._initVideo()` metodunda `setState` bloğunun sonuna ekle:

```dart
    setState(() {
      _controller = controller;
      _isInitialized = controller.value.isInitialized;
    });
    if (_isInitialized) {
      widget.onInitialized?.call();
    }
```

- [ ] **Step 3: flutter analyze çalıştır**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2 && flutter analyze --no-pub`
Expected: "No issues found!"

- [ ] **Step 4: Commit**

```bash
git add qulov2/lib/features/auth/screens/login_screen.dart qulov2/lib/features/auth/widgets/background_video.dart
git commit -m "feat: integrate background video and staggered animations into login screen"
```

---

### Task 6: businessCaseSkill yaz

**Files:**
- Create: `.claude/skills/businessCaseSkills/video-player-guard.md`

- [ ] **Step 1: video-player-guard skill dosyasını oluştur**

`.claude/skills/businessCaseSkills/video-player-guard.md` dosyasını oluştur:

```markdown
---
name: video-player-guard
description: Video player geliştirmelerinde VideoManager kullanımını zorunlu kılar, bellek güvenliği kurallarını uygular
type: business-case
triggers:
  - video
  - video_player
  - VideoManager
  - background video
  - arka plan video
  - BackgroundVideo
---

# Video Player Guard

## Kurallar

### 1. Singleton Zorunluluğu
- `VideoPlayerController` ASLA doğrudan oluşturulmaz — her zaman `VideoManager.instance.acquire()` kullanılır
- Feature'lardan `import 'package:video_player/video_player.dart'` YASAK (sadece widget layer hariç)
- Video widget'ları `BackgroundVideo` widget'ını kullanmalı veya `VideoManager` üzerinden controller almalı

### 2. Lifecycle Kuralları
- **Dispose öncesi pause ZORUNLU** — `release()` bunu garanti eder, manuel yapılmaz
- Widget `dispose()` → `VideoManager.instance.release(assetPath)` çağırmalı
- `initState()` → `acquire()`, `dispose()` → `release()` çifti her zaman eşleşmeli

### 3. Bellek Güvenliği
- Max 1 aktif video kuralı — `acquire()` otomatik uygular
- App lifecycle (pause/resume) VideoManager tarafından otomatik yönetilir
- `VisibilityDetector` ile ekran görünürlük takibi önerilir

### 4. Asset Kuralları
- Video dosyaları `assets/videos/` altında olmalı
- 50MB üzeri video dosyası → sıkıştırma önerisi sun
- `pubspec.yaml`'da `- assets/videos/` satırı olmalı

### 5. Varsayılanlar (Arka Plan Video)
- `setLooping(true)` — her zaman
- `setVolume(0.0)` — her zaman (arka plan videoları sessiz)
- `BoxFit.cover` — tam ekran kaplama

## Kontrol Listesi
Yeni video feature'ı eklerken:
- [ ] VideoManager.acquire/release kullanılıyor mu?
- [ ] Widget dispose'da release çağrılıyor mu?
- [ ] Asset pubspec.yaml'da tanımlı mı?
- [ ] Video boyutu 50MB altında mı?
- [ ] VisibilityDetector ile görünürlük takibi var mı?
```

- [ ] **Step 2: Commit**

```bash
git add .claude/skills/businessCaseSkills/video-player-guard.md
git commit -m "feat: add video-player-guard businessCaseSkill"
```

---

### Task 7: Doğrulama ve review

- [ ] **Step 1: Tüm dosyaları doğrula**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2 && flutter analyze --no-pub`
Expected: "No issues found!"

- [ ] **Step 2: /simplify skill'ini çalıştır**

Tüm değişen dosyaları review et: reuse, kalite, verimlilik kontrolü.

- [ ] **Step 3: /flutter-review skill'ini çalıştır**

Screen size limit, widget extraction, SOLID, hardcoded values, banned patterns kontrolü.

- [ ] **Step 4: Final commit (review sonrası düzeltmeler varsa)**

```bash
git add -A
git commit -m "refactor: apply review fixes for video manager feature"
```
