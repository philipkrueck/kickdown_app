import 'dart:async';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/ui/shared/posting_header/posting_header_viewmodel.dart';

class PostingHeaderOverviewViewmodel extends PostingHeaderViewmodel {
  final Posting posting;
  StreamSubscription<int> _imageAdddedListener;
  StreamSubscription<bool> _starredByUserListener;

  PostingHeaderOverviewViewmodel(this.posting) {
    _imageAdddedListener = posting.imageAddedAtIndexStream.listen((index) {
      if (index != 0) return;
      notifyListeners();
    });

    _starredByUserListener = posting.starredByCurrentUserStream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _imageAdddedListener.cancel();
    _starredByUserListener.cancel();
    super.dispose();
  }

  bool get showImageGallery => false;

  bool get isDetail => false;
}
