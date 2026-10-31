import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Ilustración vectorial ligera (assets/ill/NOMBRE.svg). Pesa pocos KB y no
/// gasta batería: se dibuja una vez y queda en caché.
class Ill extends StatelessWidget {
  final String name;
  final double? height;
  final BorderRadius radius;
  const Ill(this.name, {super.key, this.height, this.radius = const BorderRadius.all(Radius.circular(14))});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius,
      child: AspectRatio(
        aspectRatio: 1.6,
        child: SvgPicture.asset(
          'assets/ill/$name.svg',
          fit: BoxFit.cover,
          height: height,
          placeholderBuilder: (_) => Container(color: const Color(0xFF141414)),
        ),
      ),
    );
  }
}

/// Ilustración con pie de foto (para lecciones y pasos).
class IllCaption extends StatelessWidget {
  final String name;
  final String caption;
  final double scale;
  const IllCaption(this.name, this.caption, {super.key, this.scale = 1});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Ill(name),
        if (caption.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(caption,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15 * scale, color: Theme.of(context).colorScheme.primary)),
          ),
      ]),
    );
  }
}
