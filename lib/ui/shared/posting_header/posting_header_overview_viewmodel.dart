import 'dart:async';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/ui/shared/posting_header/posting_header_viewmodel.dart';

class PostingHeaderOverviewViewmodel extends PostingHeaderViewmodel {
  final Posting posting;
  StreamSubscription<bool> _starredByUserListener;

  PostingHeaderOverviewViewmodel(this.posting) {
    _starredByUserListener = posting.starredByCurrentUserStream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _starredByUserListener.cancel();
    super.dispose();
  }

  bool get showImageGallery => false;

  bool get isDetail => false;
}
