import 'package:json_annotation/json_annotation.dart';

part 'search_suggestions_request_params.g.dart';

@JsonSerializable()
class SearchSuggestionsRequestParams {
  final String referenceCurrencyUuid;
  final String query;

  SearchSuggestionsRequestParams({
    required this.referenceCurrencyUuid,
    required this.query,
  });

  factory SearchSuggestionsRequestParams.fromJson(Map<String, dynamic> json) =>
      _$SearchSuggestionsRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SearchSuggestionsRequestParamsToJson(this);
}
