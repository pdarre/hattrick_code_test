import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view_models/home_page_viewmodel/home_page_vm.dart';
import '../interfaces/coctail_repository_interface.dart';
import '../repositories/remote_data/coktail_repository.dart';

final coktailRepositoryInterface =
    Provider<CoktailRepositoryInterface>((ref) => CoktailRepository());

final homePageProvider = StateNotifierProvider(
    (ref) => HomePageVm(ref.watch(coktailRepositoryInterface)));
