import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:petugas_perpustakaan_kelas_c/app/data/model/response_pinjam.dart';
import 'package:petugas_perpustakaan_kelas_c/app/data/provider/storage_provider.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';

class PeminjamanController extends GetxController with StateMixin<List<DataPinjam>> {
  //TODO: Implement BookController

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getData() async {
    change(null, status: RxStatus.loading());
    try {
      final response =
      await ApiProvider.instance().get("${Endpoint.pinjam}/${StorageProvider.read(StorageKey.idUser)}");
      if (response.statusCode == 200) {
        final ResponsePinjam responseBooks = ResponsePinjam.fromJson(response.data);
        if (responseBooks.data!.isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          change(responseBooks.data, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("${response.data['message']}"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          change(
              null, status: RxStatus.error(" dio ${e.response?.data['message']}"));
        }
      } else {
        change(null, status: RxStatus.error("cek"+(e.message ?? "")));
      }
    } catch (e) {
      "catch "+e.toString();
      change(null, status: RxStatus.error("catch"+e.toString()));
    }
  }
}

