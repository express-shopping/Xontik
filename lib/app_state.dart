import 'package:flutter/material.dart';

class XontikProvider extends ChangeNotifier {
  int _totalLikes = 1500000; 
  bool _isFollowing = false;

  int get totalLikes => _totalLikes;
  bool get isFollowing => _isFollowing;

  // هذه هي الدالة التي ستقوم بتنسيق الرقم تلقائياً
  String get formattedLikes {
    if (_totalLikes >= 1000000) {
      return '${(_totalLikes / 1000000).toStringAsFixed(1).replaceAll('.0', '')}M';
    } else if (_totalLikes >= 1000) {
      return '${(_totalLikes / 1000).toStringAsFixed(1).replaceAll('.0', '')}K';
    } else {
      return _totalLikes.toString();
    }
  }

  void addLike() {
    _totalLikes++;
    notifyListeners();
  }

  void toggleFollow() {
    _isFollowing = !_isFollowing;
    notifyListeners();
  }
}

