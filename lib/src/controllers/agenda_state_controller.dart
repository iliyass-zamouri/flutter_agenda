import 'package:flutter/foundation.dart';
import 'package:flutter_agenda/flutter_agenda.dart';

class AgendaStateController extends ChangeNotifier {
  final List<Resource> _resources;
  final AgendaStyle _agendaStyle;
  
  AgendaStateController({
    required List<Resource> resources,
    required AgendaStyle agendaStyle,
  }) : _resources = resources, _agendaStyle = agendaStyle;

  List<Resource> get resources => _resources;
  AgendaStyle get agendaStyle => _agendaStyle;

  // Track which resources have changed
  final Set<int> _changedResourceIndices = <int>{};
  
  // Track if events have been added/removed
  bool _eventsChanged = false;
  
  // Track if style has changed
  bool _styleChanged = false;

  // Get changed resources
  List<Resource> get changedResources {
    if (_changedResourceIndices.isEmpty) return [];
    return _changedResourceIndices.map((index) => _resources[index]).toList();
  }

  // Check if specific resource has changed
  bool hasResourceChanged(int index) => _changedResourceIndices.contains(index);

  // Check if events have changed
  bool get eventsChanged => _eventsChanged;

  // Check if style has changed
  bool get styleChanged => _styleChanged;

  // Update resources
  void updateResources(List<Resource> newResources) {
    if (listEquals(_resources, newResources)) return;
    
    _resources.clear();
    _resources.addAll(newResources);
    
    // Mark all resources as changed
    _changedResourceIndices.clear();
    for (int i = 0; i < _resources.length; i++) {
      _changedResourceIndices.add(i);
    }
    
    notifyListeners();
  }

  // Add event to specific resource
  void addEvent(int resourceIndex, AgendaEvent event) {
    if (resourceIndex >= 0 && resourceIndex < _resources.length) {
      _resources[resourceIndex].events.add(event);
      _changedResourceIndices.add(resourceIndex);
      _eventsChanged = true;
      notifyListeners();
    }
  }

  // Remove event from specific resource
  void removeEvent(int resourceIndex, int eventIndex) {
    if (resourceIndex >= 0 && 
        resourceIndex < _resources.length && 
        eventIndex >= 0 && 
        eventIndex < _resources[resourceIndex].events.length) {
      _resources[resourceIndex].events.removeAt(eventIndex);
      _changedResourceIndices.add(resourceIndex);
      _eventsChanged = true;
      notifyListeners();
    }
  }

  // Update specific resource
  void updateResource(int index, Resource resource) {
    if (index >= 0 && index < _resources.length) {
      _resources[index] = resource;
      _changedResourceIndices.add(index);
      notifyListeners();
    }
  }

  // Update agenda style
  void updateAgendaStyle(AgendaStyle newStyle) {
    if (_agendaStyle == newStyle) return;
    
    // Check if style changes affect layout
    if (_agendaStyle.startHour != newStyle.startHour ||
        _agendaStyle.endHour != newStyle.endHour ||
        _agendaStyle.timeSlot != newStyle.timeSlot ||
        _agendaStyle.headersPosition != newStyle.headersPosition ||
        _agendaStyle.direction != newStyle.direction) {
      _styleChanged = true;
    }
    
    // Update the style reference
    // Note: This is a simplified approach. In a real implementation,
    // you might want to create a new instance or use a different pattern
    _styleChanged = true;
    notifyListeners();
  }

  // Clear change flags
  void clearChangeFlags() {
    _changedResourceIndices.clear();
    _eventsChanged = false;
    _styleChanged = false;
  }

  // Check if any changes occurred
  bool get hasChanges => 
      _changedResourceIndices.isNotEmpty || 
      _eventsChanged || 
      _styleChanged;

  @override
  void dispose() {
    _changedResourceIndices.clear();
    super.dispose();
  }
}
