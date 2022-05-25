import 'package:midev_system_fl/hse/models/all_hazard_model.dart';
import 'package:midev_system_fl/hse/provider/allhazard_provider.dart';

class AllHazardRepository {
  final _provider = AllHazardProvider();
  Future<AllHazard?> fetchAllHazard(
      int disetujui, int page, String dari, String sampai) async {
    return _provider.getAllHazard(disetujui, page, dari, sampai);
  }
}
