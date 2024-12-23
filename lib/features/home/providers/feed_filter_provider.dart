import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FeedAlgorithm {
  best,
  latest,
  following,
}

enum PostTypeFilter {
  all,
  discussion,
  official,
}

enum MuTypeFilter {
  all,
  politicsParty,
  newsPoll,
  election,
}

final feedAlgorithmProvider = StateProvider<FeedAlgorithm>(
  (ref) => FeedAlgorithm.best,
);

final postTypeFilterProvider = StateProvider<PostTypeFilter>(
  (ref) => PostTypeFilter.all,
);

final muTypeFilterProvider = StateProvider<MuTypeFilter>(
  (ref) => MuTypeFilter.all,
);
