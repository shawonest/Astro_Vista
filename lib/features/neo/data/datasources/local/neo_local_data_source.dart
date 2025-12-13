import 'package:hive_flutter/hive_flutter.dart';

import '../../models/neo_model.dart';

abstract class NeoLocalDataSource {
  List<NeoModel> getNeoList();
  Future<void> cacheNeoList(List<NeoModel> list);
}

class NeoLocalDataSourceImpl implements NeoLocalDataSource {
  final Box<NeoModel> neoBox;

  NeoLocalDataSourceImpl({required this.neoBox});

  @override
  Future<void> cacheNeoList(List<NeoModel> list) async {
    await neoBox.clear(); // Clear old data
    await neoBox.addAll(list);
  }

  @override
  List<NeoModel> getNeoList() {
    return neoBox.values.toList();
  }
}