import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qulo_v2/core/constants/q_icons.dart';
import 'package:qulo_v2/core/navigation/navigation.dart';
import 'package:qulo_v2/core/theme/app_colors.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/core/widgets/app_button.dart';
import 'package:qulo_v2/core/widgets/app_scaffold.dart';
import 'package:qulo_v2/core/widgets/app_text_field.dart';
import 'package:qulo_v2/core/widgets/q_icon.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/services/image_picker_manager.dart';
import 'package:qulo_v2/providers/api_provider.dart';
import 'package:qulo_v2/providers/user_provider.dart';
import 'package:qulo_v2/providers/location_provider.dart';
import 'package:qulo_v2/features/profile/widgets/photo_grid.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  // ─── Controllers ───
  final _bioController = TextEditingController();
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _jobController = TextEditingController();
  final _schoolController = TextEditingController();
  final _petsController = TextEditingController();
  final _musicController = TextEditingController();
  final _personalityController = TextEditingController();

  // ─── State ───
  String? _selectedZodiac;
  String? _selectedSmoking;
  String? _selectedAlcohol;
  String? _selectedGenderPref;
  RangeValues _ageRange = const RangeValues(18, 50);
  double _distanceKm = 50;
  bool _isSaving = false;
  List<String?> _photos = List.filled(6, null);

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final userAsync = ref.read(userProvider);
    final user = userAsync.valueOrNull;
    if (user == null) return;

    _bioController.text = user.bio ?? '';
    _nameController.text = user.name ?? '';
    _cityController.text = user.city ?? '';
    _heightController.text = user.details?.height?.toString() ?? '';
    _weightController.text = user.details?.weight?.toString() ?? '';
    _jobController.text = user.details?.job ?? '';
    _schoolController.text = user.details?.school ?? '';
    _petsController.text = user.details?.pets ?? '';
    _musicController.text = user.details?.musicType ?? '';
    _personalityController.text = user.details?.personality ?? '';

    _selectedZodiac = user.details?.zodiac;
    _selectedSmoking = user.details?.smoking;
    _selectedAlcohol = user.details?.alcohol;
    _selectedGenderPref = user.genderPref;
    _ageRange = RangeValues(
      (user.agePrefMin ?? 18).toDouble(),
      (user.agePrefMax ?? 50).toDouble(),
    );
    _distanceKm = (user.matchRadiusKm ?? 50).toDouble();

    // Photos
    final userPhotos = user.photos ?? [];
    _photos = List.generate(6, (i) => i < userPhotos.length ? userPhotos[i] : null);
  }

  @override
  void dispose() {
    _bioController.dispose();
    _nameController.dispose();
    _cityController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _jobController.dispose();
    _schoolController.dispose();
    _petsController.dispose();
    _musicController.dispose();
    _personalityController.dispose();
    super.dispose();
  }

  // ─── Photo Actions ───

  void _onPhotoSlotTap(int index) {
    final hasPhoto = _photos[index] != null;

    if (hasPhoto) {
      _showExistingPhotoSheet(index);
    } else {
      _showPickPhotoSheet(index);
    }
  }

  void _showExistingPhotoSheet(int index) {
    final nav = ref.read(navigationServiceProvider);

    nav.showAppBottomSheet<String>(
      ListBottomSheet<String>(
        name: 'photo_options',
        title: context.tr('photo_options'),
        options: [
          SheetOption(
            icon: Icons.star,
            label: context.tr('make_primary'),
            value: 'primary',
          ),
          SheetOption(
            icon: Icons.delete,
            label: context.tr('delete_photo'),
            value: 'delete',
          ),
        ],
      ),
    ).then((result) {
      if (result == null) return;
      if (result == 'primary') {
        _makePrimary(index);
      } else if (result == 'delete') {
        _confirmDeletePhoto(index);
      }
    });
  }

  void _showPickPhotoSheet(int index) {
    final nav = ref.read(navigationServiceProvider);

    nav.showAppBottomSheet<String>(
      ListBottomSheet<String>(
        name: 'pick_photo_source',
        title: context.tr('add_photo'),
        options: [
          SheetOption(
            icon: Icons.photo_library,
            label: context.tr('gallery'),
            value: 'gallery',
          ),
          SheetOption(
            icon: Icons.camera_alt,
            label: context.tr('camera'),
            value: 'camera',
          ),
        ],
      ),
    ).then((result) {
      if (result == null) return;
      if (result == 'gallery') {
        _pickFromGallery();
      } else if (result == 'camera') {
        _pickFromCamera();
      }
    });
  }

  Future<void> _pickFromGallery() => _pickAndUpload(
        ref.read(imagePickerManagerProvider).pickFromGallery(),
      );

  Future<void> _pickFromCamera() => _pickAndUpload(
        ref.read(imagePickerManagerProvider).pickFromCamera(),
      );

  Future<void> _pickAndUpload(Future<PickedImage?> pickFuture) async {
    final picked = await pickFuture;
    if (picked == null) return;

    final result = await ref.read(userProvider.notifier).uploadPhoto(picked.bytes, picked.mimeType);

    if (mounted) {
      if (result.isSuccess) {
        _refreshPhotos();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.tr('save_error'))),
        );
      }
    }
  }

  void _makePrimary(int index) {
    final currentPhotos = _photos.whereType<String>().toList();
    if (index >= currentPhotos.length) return;

    final photo = currentPhotos.removeAt(index);
    currentPhotos.insert(0, photo);

    ref.read(userProvider.notifier).reorderPhotos(currentPhotos).then((_) {
      _refreshPhotos();
    });
  }

  void _confirmDeletePhoto(int index) {
    final nav = ref.read(navigationServiceProvider);

    nav.showAppDialog<bool>(
      ConfirmDialog(
        name: 'delete_photo_confirm',
        title: context.tr('delete_photo'),
        message: context.tr('delete_photo_confirm'),
        confirmText: context.tr('delete'),
        isDestructive: true,
      ),
    ).then((confirmed) {
      if (confirmed == true) {
        ref.read(userProvider.notifier).deletePhoto(index).then((_) {
          _refreshPhotos();
        });
      }
    });
  }

  void _refreshPhotos() {
    final user = ref.read(userProvider).valueOrNull;
    if (user == null) return;
    final userPhotos = user.photos ?? [];
    setState(() {
      _photos = List.generate(6, (i) => i < userPhotos.length ? userPhotos[i] : null);
    });
  }

  // ─── Location Update ───

  Future<void> _updateLocation() async {
    await ref.read(locationProvider.notifier).getCurrentLocation();
    final loc = ref.read(locationProvider);
    if (loc.lat != null && loc.lng != null) {
      await ref.read(userProvider.notifier).updateLocation(lat: loc.lat!, lng: loc.lng!);
      await ref.read(userProvider.notifier).fetchMe();
      final user = ref.read(userProvider).valueOrNull;
      if (user != null && user.city != null) {
        setState(() {
          _cityController.text = user.city!;
        });
      }
    }
  }

  // ─── Save ───

  Future<void> _save() async {
    setState(() => _isSaving = true);

    try {
      // Profile data
      final profileData = <String, dynamic>{
        'bio': _bioController.text.trim(),
        'city': _cityController.text.trim(),
        'gender_pref': _selectedGenderPref,
        'age_pref_min': _ageRange.start.round(),
        'age_pref_max': _ageRange.end.round(),
        'match_radius_km': _distanceKm.round(),
      };

      final profileResult = await ref.read(userProvider.notifier).updateProfile(profileData);

      // Details data
      final detailsData = <String, dynamic>{
        'height': int.tryParse(_heightController.text),
        'weight': int.tryParse(_weightController.text),
        'zodiac': _selectedZodiac,
        'job': _jobController.text.trim(),
        'school': _schoolController.text.trim(),
        'smoking': _selectedSmoking,
        'alcohol': _selectedAlcohol,
        'pets': _petsController.text.trim(),
        'music_type': _musicController.text.trim(),
        'personality': _personalityController.text.trim(),
      };

      // Remove null values
      detailsData.removeWhere((_, v) => v == null);

      final detailsResult = await ref.read(userProvider.notifier).updateDetails(detailsData);

      if (mounted) {
        final hasError = profileResult.isFailure || detailsResult.isFailure;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              hasError ? context.tr('save_error') : context.tr('save_success'),
            ),
          ),
        );

        if (!hasError) {
          ref.read(navigationServiceProvider).pop();
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  // ─── Dropdown Helpers ───

  List<DropdownMenuItem<String>> _zodiacItems() {
    const signs = [
      'aries', 'taurus', 'gemini', 'cancer', 'leo', 'virgo',
      'libra', 'scorpio', 'sagittarius', 'capricorn', 'aquarius', 'pisces',
    ];
    return signs
        .map((s) => DropdownMenuItem(
              value: s,
              child: Text(context.tr('zodiac_$s')),
            ))
        .toList();
  }

  List<DropdownMenuItem<String>> _frequencyItems() {
    return [
      DropdownMenuItem(value: 'YES', child: Text(context.tr('freq_yes'))),
      DropdownMenuItem(value: 'NO', child: Text(context.tr('freq_no'))),
      DropdownMenuItem(value: 'SOMETIMES', child: Text(context.tr('freq_sometimes'))),
    ];
  }

  // ─── Build ───

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: context.tr('edit_profile'),
      showBackButton: true,
      padding: EdgeInsets.zero,
      bottomNavigationBar: _buildStickyButton(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Photos Section ───
            _sectionTitle(context.tr('photos')),
            const SizedBox(height: AppSpacing.sm),
            PhotoGridFull(
              photos: _photos,
              editMode: true,
              onSlotTap: _onPhotoSlotTap,
            ),
            const SizedBox(height: AppSpacing.sectionGap),

            // ─── About Section ───
            _sectionTitle(context.tr('about')),
            const SizedBox(height: AppSpacing.sm),
            _buildBioField(),
            const SizedBox(height: AppSpacing.sectionGap),

            // ─── Basic Info Section ───
            _sectionTitle(context.tr('basic_info')),
            const SizedBox(height: AppSpacing.sm),
            AppTextField(
              controller: _nameController,
              label: context.tr('name'),
              enabled: false,
            ),
            const SizedBox(height: AppSpacing.itemGap),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: _cityController,
                    label: context.tr('city'),
                    hint: context.tr('city_hint'),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                _locationButton(),
              ],
            ),
            const SizedBox(height: AppSpacing.sectionGap),

            // ─── Details Section ───
            _sectionTitle(context.tr('details')),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: _heightController,
                    label: context.tr('height'),
                    hint: 'cm',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                const SizedBox(width: AppSpacing.itemGap),
                Expanded(
                  child: AppTextField(
                    controller: _weightController,
                    label: context.tr('weight'),
                    hint: 'kg',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.itemGap),
            _buildDropdown(
              label: context.tr('zodiac'),
              value: _selectedZodiac,
              items: _zodiacItems(),
              onChanged: (v) => setState(() => _selectedZodiac = v),
            ),
            const SizedBox(height: AppSpacing.itemGap),
            AppTextField(
              controller: _jobController,
              label: context.tr('job'),
              hint: context.tr('job_hint'),
            ),
            const SizedBox(height: AppSpacing.itemGap),
            AppTextField(
              controller: _schoolController,
              label: context.tr('school'),
              hint: context.tr('school_hint'),
            ),
            const SizedBox(height: AppSpacing.itemGap),
            _buildDropdown(
              label: context.tr('smoking'),
              value: _selectedSmoking,
              items: _frequencyItems(),
              onChanged: (v) => setState(() => _selectedSmoking = v),
            ),
            const SizedBox(height: AppSpacing.itemGap),
            _buildDropdown(
              label: context.tr('alcohol'),
              value: _selectedAlcohol,
              items: _frequencyItems(),
              onChanged: (v) => setState(() => _selectedAlcohol = v),
            ),
            const SizedBox(height: AppSpacing.itemGap),
            AppTextField(
              controller: _petsController,
              label: context.tr('pets'),
              hint: context.tr('pets_hint'),
            ),
            const SizedBox(height: AppSpacing.itemGap),
            AppTextField(
              controller: _musicController,
              label: context.tr('music'),
              hint: context.tr('music_hint'),
            ),
            const SizedBox(height: AppSpacing.itemGap),
            AppTextField(
              controller: _personalityController,
              label: context.tr('personality'),
              hint: context.tr('personality_hint'),
            ),
            const SizedBox(height: AppSpacing.sectionGap),

            // ─── Preferences Section ───
            _sectionTitle(context.tr('preferences')),
            const SizedBox(height: AppSpacing.sm),
            _buildGenderPref(),
            const SizedBox(height: AppSpacing.lg),
            _buildAgeRange(),
            const SizedBox(height: AppSpacing.lg),
            _buildDistanceSlider(),
            const SizedBox(height: AppSpacing.sectionGap),
          ],
        ),
      ),
    );
  }

  // ─── Widgets ───

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
    );
  }

  Widget _buildBioField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppTextField(
          controller: _bioController,
          label: context.tr('bio'),
          hint: context.tr('bio_hint'),
          maxLines: 4,
        ),
        const SizedBox(height: AppSpacing.xs),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _bioController,
          builder: (_, value, __) {
            final count = value.text.length;
            return Text(
              '$count / 300',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: count > 300 ? AppColors.error : AppColors.textHint,
                  ),
            );
          },
        ),
      ],
    );
  }

  Widget _locationButton() {
    final locState = ref.watch(locationProvider);

    return SizedBox(
      width: 48,
      height: 48,
      child: IconButton(
        onPressed: locState.isLoading ? null : _updateLocation,
        style: IconButton.styleFrom(
          backgroundColor: AppColors.primarySurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
        ),
        icon: locState.isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
              )
            : QIcon(QIcons.icMapPin, color: AppColors.primary, size: 20),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(labelText: label),
      items: items,
      onChanged: onChanged,
      dropdownColor: AppColors.surfaceElevated,
    );
  }

  Widget _buildGenderPref() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr('gender_preference'),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SegmentedButton<String>(
          segments: [
            ButtonSegment(value: 'MALE', label: Text(context.tr('male'))),
            ButtonSegment(value: 'FEMALE', label: Text(context.tr('female'))),
            ButtonSegment(value: 'ALL', label: Text(context.tr('all'))),
          ],
          selected: {_selectedGenderPref ?? 'ALL'},
          onSelectionChanged: (set) {
            setState(() => _selectedGenderPref = set.first);
          },
          style: SegmentedButton.styleFrom(
            selectedBackgroundColor: AppColors.primarySurface,
            selectedForegroundColor: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildAgeRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${context.tr('age_range')}: ${_ageRange.start.round()} - ${_ageRange.end.round()}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        RangeSlider(
          values: _ageRange,
          min: 18,
          max: 65,
          divisions: 47,
          labels: RangeLabels(
            _ageRange.start.round().toString(),
            _ageRange.end.round().toString(),
          ),
          activeColor: AppColors.primary,
          inactiveColor: AppColors.surfaceElevated,
          onChanged: (values) => setState(() => _ageRange = values),
        ),
      ],
    );
  }

  Widget _buildDistanceSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${context.tr('distance')}: ${_distanceKm.round()} km',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        Slider(
          value: _distanceKm,
          min: 5,
          max: 200,
          divisions: 39,
          label: '${_distanceKm.round()} km',
          activeColor: AppColors.primary,
          inactiveColor: AppColors.surfaceElevated,
          onChanged: (value) => setState(() => _distanceKm = value),
        ),
      ],
    );
  }

  Widget _buildStickyButton() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: const Border(
          top: BorderSide(color: AppColors.divider, width: 0.5),
        ),
      ),
      child: SafeArea(
        top: false,
        child: AppButton(
          label: context.tr('save'),
          isLoading: _isSaving,
          fullWidth: true,
          onPressed: _isSaving ? null : _save,
        ),
      ),
    );
  }
}
