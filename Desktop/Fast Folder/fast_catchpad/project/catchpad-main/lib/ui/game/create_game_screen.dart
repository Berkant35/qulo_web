import 'package:flutter/material.dart';

import '../../prov/game/selected_players_prov.dart';
import '../../utils/cp_colors.dart';
import '../../utils/utils.dart';
import '../widgets/cp_chip.dart';
import '../widgets/default_bg.dart';
import '../widgets/inline_color_selector.dart';

class CreateGameScreen extends StatelessWidget {
  const CreateGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _Title(),
      ),
      body: DefaultBg(
        child: Container(
          margin: const EdgeInsets.all(defPaddingSize),
          child: ListView(
            children: const [
              // _Title(),
              SizedBox(height: defPaddingSize),
              _MetadataFields(),
              SizedBox(height: defPaddingSize),
              _Mesaure(),
              _PadCount(),
              _Lang(),
              _Sticker(),
              _Colors(),
              // _Duration(),
// Oyun Açıklaması
            ].joinWidgetList(
              (index) => const SizedBox(height: defPaddingSize),
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Kendi oyununu tasarla',
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

class _MetadataFields extends StatelessWidget {
  const _MetadataFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Oyun Adı',
              style: Theme.of(context).textTheme.caption,
            ),
            TextFormField(),
          ].joinWidgetList(
            (index) => const SizedBox(height: halfDefPaddingSize),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Oyun Açıklaması',
              style: Theme.of(context).textTheme.caption,
            ),
            TextFormField(),
          ].joinWidgetList(
            (index) => const SizedBox(height: halfDefPaddingSize),
          ),
        ),
      ].joinWidgetList(
        (index) => const SizedBox(height: defPaddingSize),
      ),
    );
  }
}

class _Mesaure extends StatefulWidget {
  const _Mesaure({Key? key}) : super(key: key);

  @override
  State<_Mesaure> createState() => _MesaureState();
}

class _MesaureState extends State<_Mesaure> {
  static const _mesaures = [
    'Dokunma',
    'Kuvvet',
    'Denge',
    'Yakınlık',
  ];

  var _selectedMeasure = _mesaures[0];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ölçme Yöntemi',
          style: Theme.of(context).textTheme.subtitle2,
        ),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _mesaures
                .map(
                  (e) => CpChip(
                    key: Key(e + (e == _selectedMeasure).toString()),
                    text: e,
                    initialSelected: e == _selectedMeasure,
                    onSelected: (r) {
                      if (!r) {
                        return;
                      }

                      setState(() {
                        _selectedMeasure = e;
                      });
                    },
                  ),
                )
                .joinWidgetList(
                  (index) => const SizedBox(width: 5),
                ),
          ),
        ),
      ].joinWidgetList(
        (index) => const SizedBox(height: halfDefPaddingSize),
      ),
    );
  }
}

class _Lang extends StatefulWidget {
  const _Lang({Key? key}) : super(key: key);

  @override
  State<_Lang> createState() => _LangState();
}

class _LangState extends State<_Lang> {
  static const _mesaures = [
    'Türkçe',
    'İngilizce',
    'İspanyolca',
    'Arapça',
  ];

  var _selectedMeasure = _mesaures[0];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dil',
          style: Theme.of(context).textTheme.subtitle2,
        ),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _mesaures
                .map(
                  (e) => CpChip(
                    key: Key(e + (e == _selectedMeasure).toString()),
                    text: e,
                    initialSelected: e == _selectedMeasure,
                    onSelected: (r) {
                      if (!r) {
                        return;
                      }

                      setState(() {
                        _selectedMeasure = e;
                      });
                    },
                  ),
                )
                .joinWidgetList(
                  (index) => const SizedBox(width: 5),
                ),
          ),
        ),
      ].joinWidgetList(
        (index) => const SizedBox(height: halfDefPaddingSize),
      ),
    );
  }
}

class _Sticker extends StatefulWidget {
  const _Sticker({Key? key}) : super(key: key);

  @override
  State<_Sticker> createState() => _StickerState();
}

class _StickerState extends State<_Sticker> {
  static const _mesaures = [
    'Rakamlar',
    'Harfler',
    'Araçlar',
    'Hayvanlar',
    'Notalar',
    'Meyveler',
    'Şekiller',
    'Emojiler',
  ];

  var _selectedMeasure = _mesaures[0];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sticker',
          style: Theme.of(context).textTheme.subtitle2,
        ),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _mesaures
                .map(
                  (e) => CpChip(
                    key: Key(e + (e == _selectedMeasure).toString()),
                    text: e,
                    initialSelected: e == _selectedMeasure,
                    onSelected: (r) {
                      if (!r) {
                        return;
                      }

                      setState(() {
                        _selectedMeasure = e;
                      });
                    },
                  ),
                )
                .joinWidgetList(
                  (index) => const SizedBox(width: 5),
                ),
          ),
        ),
      ].joinWidgetList(
        (index) => const SizedBox(height: halfDefPaddingSize),
      ),
    );
  }
}

class _PadCount extends StatefulWidget {
  const _PadCount({Key? key}) : super(key: key);

  @override
  State<_PadCount> createState() => __PadCountState();
}

class __PadCountState extends State<_PadCount> {
  var _count = 0;
  static const min = 0, max = 12;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Pad Sayısı',
          style: Theme.of(context).textTheme.subtitle2,
        ),
        Row(
          children: [
            InkWell(
              child: Text(
                '-',
                style: Theme.of(context).textTheme.headline4,
              ),
              onTap: () {
                if (_count > min) {
                  _count--;
                  setState(() {});
                }
              },
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: halfDefPaddingSize,
                  horizontal: defPaddingSize,
                ),
                decoration: BoxDecoration(
                  color: CpColors.chipUnselectedColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                width: 100,
                child: Text(
                  '$_count',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            InkWell(
              child: Text(
                '+',
                style: Theme.of(context).textTheme.headline4,
              ),
              onTap: () {
                if (_count < max) {
                  _count++;
                  setState(() {});
                }
              },
            ),
          ].joinWidgetList(
            (index) => const SizedBox(width: defPaddingSize),
          ),
        ),
      ],
    );
  }
}

class _Colors extends StatefulWidget {
  const _Colors({Key? key}) : super(key: key);

  @override
  State<_Colors> createState() => __ColorsState();
}

class __ColorsState extends State<_Colors> {
  ColorSet selectedColors = {};
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Renkler',
          style: Theme.of(context).textTheme.subtitle2,
        ),
        Expanded(
          child: InlineColorSelector(
            selectedColors: selectedColors,
            disabledColors: const {},
            min: 1,
            isOrdered: false,
            onChange: (clrs) {
              selectedColors = clrs;
              setState(() {});
            },
          ),
        ),
      ].joinWidgetList(
        (index) => const SizedBox(width: defPaddingSize),
      ),
    );
  }
}

class _Duration extends StatefulWidget {
  const _Duration({Key? key}) : super(key: key);

  @override
  State<_Duration> createState() => __DurationState();
}

class __DurationState extends State<_Duration> {
  var dur = const Duration(seconds: 30);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Süre',
          style: Theme.of(context).textTheme.subtitle2,
        ),
        // Slider.adaptive(
        //   value: dur.inSeconds + .0,
        //   onChanged: (e) {},
        // ),
      ],
    );
  }
}
