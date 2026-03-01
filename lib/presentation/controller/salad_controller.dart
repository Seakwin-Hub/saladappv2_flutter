import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:saladappv2_flutter/domain/models/salad_list_model.dart';
import 'package:saladappv2_flutter/domain/repositories/salad_repository_interface.dart';

class SaladController extends GetxController implements GetxService {
  final SaladRepositoryInterface saladRepositoryInterface;
  StreamSubscription<List<ConnectivityResult>>? _streamSubscription;
  SaladController({required this.saladRepositoryInterface});

  List<SaladModel>? _saladItem;
  List<SaladModel>? get saladItem => _saladItem;

  SaladModel? _salad;
  SaladModel? get salad => _salad;

  bool? _hasConnection;
  bool? get hasConnection => _hasConnection;

  SaladListModel? _saladList;
  SaladListModel? get saladList => _saladList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isExceptionError = false;
  bool get isExceptionError => _isExceptionError;

  Future<bool?> checkConnetion() async {
    _streamSubscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) {
      _hasConnection = result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.vpn);
      update();
    });

    return _hasConnection;
  }

  void handleLoading(bool loading) {
    _isLoading = !loading;
    update();
  }

  void getSaladList() async {
    _isLoading = true;
    try {
      _saladList = await saladRepositoryInterface.getList();
      if (_saladList != null) {
        _saladItem = [];
        for (var saladItem in _saladList!.saladList!) {
          _saladItem!.add(saladItem);
        }
        _isExceptionError = false;
        _isLoading = false;
        update();
      }
    } catch (e) {
      _isExceptionError = true;
      _isLoading = false;
      update();
    }
  }

  Future<void> getSaladById(SaladModel salad) async {
    _salad ??= SaladModel();
    if (_salad!.saladName != null) {
      _salad = salad;
    } else {
      _salad = null;
      _salad = await saladRepositoryInterface.getData(salad.saladId.toString());
    }
  }

  @override
  void onClose() {
    _streamSubscription?.cancel();
    super.onClose();
  }
}
