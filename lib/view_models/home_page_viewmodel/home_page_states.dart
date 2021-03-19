abstract class HomePageState {}

class HomePageInitial implements HomePageState {}

class HomePageLoading implements HomePageState {}

class HomePageError implements HomePageState {
  final String error;
  const HomePageError({this.error});
}

class HomePageLoaded implements HomePageState {
  final List<dynamic> list;
  const HomePageLoaded(this.list);
}
