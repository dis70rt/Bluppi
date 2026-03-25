import 'package:bluppi/domain/models/activity_model.dart';

class ActivityNode {
  ActivityModel activity;
  ActivityNode? prev;
  ActivityNode? next;

  ActivityNode(this.activity);
}

class ActivityLinkedList {
  final Map<String, ActivityNode> _nodeMap = {};
  ActivityNode? _head;
  ActivityNode? _tail;

  void reset(List<ActivityModel> activities) {
    _nodeMap.clear();
    _head = null;
    _tail = null;
    
    for (final activity in activities) {
      _append(activity);
    }
  }

  bool updateStatus(String userId, String newStatus) {
    final node = _nodeMap[userId];
    if (node == null || node.activity.status == newStatus) return false;

    node.activity = node.activity.copyWith(status: newStatus);

    if (newStatus.toLowerCase() == 'online') {
      _moveToFront(node);
    }

    return true;
  }

  void _append(ActivityModel activity) {
    final node = ActivityNode(activity);
    _nodeMap[activity.friendId] = node;

    if (_head == null) {
      _head = _tail = node;
    } else {
      _tail!.next = node;
      node.prev = _tail;
      _tail = node;
    }
  }

  void _moveToFront(ActivityNode node) {
    if (_head == node) return;

    node.prev?.next = node.next;
    if (node.next != null) {
      node.next!.prev = node.prev;
    } else {
      _tail = node.prev;
    }

    node.next = _head;
    node.prev = null;
    if (_head != null) {
      _head!.prev = node;
    }
    _head = node;
    _tail ??= node;
  }

  List<ActivityModel> toList() {
    final list = <ActivityModel>[];
    var current = _head;
    while (current != null) {
      list.add(current.activity);
      current = current.next;
    }
    return list;
  }

  List<String> get getUserIds => _nodeMap.keys.toList();
}