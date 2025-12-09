import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_weather_app/just_weather.dart';
import 'package:just_weather_app/ui/states/global_config.dart';
import 'package:just_weather_app/ui/states/jw_weather_state.dart';

class JwSearchContent extends ConsumerStatefulWidget {
  final ValueChanged<({String city})> onItemTap;

  const JwSearchContent({required this.onItemTap, super.key});

  @override
  ConsumerState<JwSearchContent> createState() => _JwSearchContentState();
}

class _JwSearchContentState extends ConsumerState<JwSearchContent>
    implements JwSearchHomeScreenInterface {
  late JwSearchDataPresenter _presenter;
  late JwWeatherConfig _config;
  bool _isLoading = false;
  bool _isEmptyData = false;
  bool _isNotQuery = false;
  bool _hasError = false;

  List<JwSearchResponse>? _results = [];
  List<JwSearchResponse>? _history = [];

  @override
  void initState() {
    super.initState();
    _config = ref.read(servicesConfigProvider);
    _presenter = JwSearchDataPresenter(this, _config);
    _loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    List<JwSearchResponse>? dataForList;

    if (_results != null) {
      _results!.isNotEmpty ? dataForList = _results : dataForList = [];
    }

    if (_history != null && (_results == null || _results!.isEmpty)) {
      _history!.isNotEmpty ? dataForList = _history : dataForList = [];
    }

    var boxDecoration = BoxDecoration(
      color: isDark
          ? JwColors.JW_SEQUENTIAL_BLACK_700
          : JwColors.JW_PRIMARY_WHITE,
      borderRadius: BorderRadius.circular(10),
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              decoration: boxDecoration,
              child: JwWeatherSearchBar(onSearch: _searchCity),
            ),

            const SizedBox(height: 5),

            Container(
              constraints: BoxConstraints(maxHeight: size.height * 0.45),
              decoration: boxDecoration,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _ValidateErrors(
                      hasError: _hasError,
                      isEmptyData: _isEmptyData,
                      isNotQuery: _isNotQuery,
                    ),

                    if (!_isLoading && !_hasError && dataForList != null)
                      _SearchItemsList(
                        dataForList: dataForList,
                        widget: widget,
                        history: _history,
                        presenter: _presenter,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _searchCity(String query) async {
    _presenter.getSearchResult(query);
  }

  Future<void> _loadHistory() async {
    final history = await SearchHistoryService().getHistory();
    setState(() => _history = history);
  }

  @override
  void loading(bool isLoading) {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Future<void> getSearchData(JwSearchDataListModel searchData) async {
    setState(() {
      _isNotQuery = false;
      _isLoading = false;
      _results = searchData.searchDataList;

      _isEmptyData = searchData.searchDataList.isEmpty || _history == null
          ? true
          : false;
    });
  }

  @override
  void emptyData(bool isEmptyData) {
    setState(() {
      _results = [];
      _isLoading = false;
      _isEmptyData = false;
      if (_history == null) {
        _isNotQuery = isEmptyData;
      }
    });
  }

  @override
  void showError(bool hasError) {
    setState(() {
      _isNotQuery = false;
      _isEmptyData = false;
      _isLoading = false;
      _hasError = hasError;
    });
  }

  @override
  void updateWeatherState(JwWeatherResponse weatherResponse) {
    ref.read(jwWeatherStateProvider.notifier).setCity(weatherResponse);
  }

  @override
  void updateHistory() async {
    final history = await SearchHistoryService().getHistory();
    setState(() => _history = history);
  }
}

class _ValidateErrors extends StatelessWidget {
  final bool hasError;
  final bool isEmptyData;
  final bool isNotQuery;

  const _ValidateErrors({
    super.key,
    required this.hasError,
    required this.isEmptyData,
    required this.isNotQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (hasError)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const CircularProgressIndicator(),
          ),

        if (isEmptyData)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text("No hay resultados"),
            ),
          ),
        if (isNotQuery)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text("Ingrese algo para buscar"),
            ),
          ),
        if (hasError)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text("Ups ocurrio un error"),
            ),
          ),
      ],
    );
  }
}

class _SearchItemsList extends StatelessWidget {
  const _SearchItemsList({
    super.key,
    required this.dataForList,
    required this.widget,
    required this.presenter,
    this.history,
  });

  final List<JwSearchResponse> dataForList;
  final List<JwSearchResponse>? history;
  final JwSearchContent widget;
  final JwSearchDataPresenter presenter;

  @override
  Widget build(BuildContext context) {
    final bool validateHistory = history != null && history!.isNotEmpty;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: dataForList.length,
        separatorBuilder: (_, __) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(height: 0, color: JwColors.JW_SEQUENTIAL_BLACK_100),
        ),
        itemBuilder: (context, index) {
          final city = dataForList[index];

          return FadeIn(
            child: ListTile(
              leading: Icon(Icons.location_pin),
              trailing: isFromHistory(city)
                  ? IconButton(
                      onPressed: () => deleteItem(city),
                      icon: Icon(Icons.delete_outline),
                    )
                  : null,
              visualDensity: VisualDensity(vertical: 0.2),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              title: Text(city.name),
              subtitle: Text(city.region ?? ''),
              onTap: () async {
                await SearchHistoryService().saveSearch(
                  city.name,
                  city.region ?? '',
                );
                widget.onItemTap.call((city: city.name));
              },
            ),
          );
        },
      ),
    );
  }

  bool isFromHistory(JwSearchResponse item) {
    if (history == null) return false;

    return history!.any((h) => h.name == item.name && h.region == item.region);
  }

  Future<void> deleteItem(JwSearchResponse city) async {
    await SearchHistoryService().deleteItem(city.name, city.region ?? '');
    presenter.updateHistory();
  }
}
