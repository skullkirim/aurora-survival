import 'package:torch_light/torch_light.dart';

/// Enciende o apaga el flash. Devuelve false si el teléfono no lo permite.
Future<bool> setTorch(bool on) async {
  try {
    on ? await TorchLight.enableTorch() : await TorchLight.disableTorch();
    return true;
  } catch (_) {
    return false;
  }
}
