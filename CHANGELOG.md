## [6.0.0] - 2025-03-13

* **🚀 Major Performance Overhaul**: ListView.builder for pillars and timeline enables lazy loading and reduces memory
* **⚡ Granular Rebuilds**: Selector + RepaintBoundary isolate resource pillars for efficient updates
* **📐 Height Caching**: OptimizedPillarView caches height and invalidates only when style changes
* **🔄 Proper Disposal**: Scroll controllers are now disposed when resources are removed
* **📏 Multi-Day Event Height**: Fixed EventView height for events spanning day boundaries (includes separator heights)
* **👆 Improved Tap Handling**: Switched to onTapUp with stored position for reliable tap detection (avoids scroll conflicts)
* **🗓️ Day Separator Tap Fix**: Corrected tap-to-time calculation in multi-day mode
* **🔧 Null-Safe onTap**: Optional `onTap` callback support with proper null handling
* **📊 Model Equality**: Added `==` and `hashCode` to AgendaEvent, EventTime, Header, Resource for correct state management
* **🎨 Header Logo**: Circle header logo now displays pillar color
* **🔑 Enhanced Keys**: EventView keys include resource index for proper rebuild tracking
* **📦 SDK Update**: Minimum SDK constraint raised to 2.14.0 (Object.hash compatibility)

## [5.0.5] - 2024-01-15
* **🎉 MAJOR FIX**: Completely resolved timeslot changes when scrolled - events and painting now update perfectly
* **🔑 Widget Keys Solution**: Added unique keys to all timeline and event widgets including timeslot height
* **🔄 Force Rebuilds**: Timeline ListView and hour items now recreate properly on timeslot changes
* **🎨 Background Sync**: CustomPaint widgets with keys ensure perfect background alignment
* **⚡ State Management**: Fixed AgendaStateController to properly update style references
* **📐 Perfect Positioning**: Events now correctly recalculate positions regardless of scroll position
* **🎯 Complete Solution**: All components (timeline, events, background) now synchronize perfectly

## [5.0.4] - 2024-01-15
* **🔥 CRITICAL FIX**: Fixed timeslot changes when scrolled - events and painting now update correctly
* **🛠️ State Management**: Fixed AgendaStateController to actually update style reference on changes
* **🔄 Rebuild Logic**: Fixed OptimizedPillarView to properly rebuild when timeslot type changes
* **⚡ Layout Detection**: Enhanced layout-affecting change detection for timeslot, multi-day, and separator changes
* **🎯 Resource Invalidation**: Timeslot changes now properly mark all resources as changed for full rebuild
* **📐 Positioning Fix**: Events now correctly recalculate positions when timeslot changes while scrolled
* **🎨 Paint Sync**: Background painter now properly rebuilds and aligns with new timeslot heights

## [5.0.3] - 2024-01-15
* **🎨 Clean Day Separators**: Fixed background painter to never paint over day name areas for ALL timeslot types
* **🔧 Strict Boundary Checking**: Enhanced painting logic with precise day area boundaries
* **⏰ All TimeSlot Support**: Fixed for full (60px), half (80px), and quarter (160px) timeslots
* **🎯 Perfect Alignment**: Day separator areas now remain completely clean and white
* **🖌️ Paint Precision**: Both time borders and decoration lines respect day boundaries strictly
* **✨ Professional Look**: Clean day headers without any overlapping lines or decorations

## [5.0.2] - 2024-01-15
* **🎯 Fixed Event Positioning**: Corrected multi-day event positioning with proper day separator calculations
* **⏰ Enhanced Minute Precision**: Improved tap detection to support 15-minute intervals (not just 30-minute)
* **🔧 Timeline Alignment**: Fixed alignment issues between events, timeslots, and pillars
* **📐 Precise Calculations**: Events now position correctly at specific times (e.g., 10:15, 14:45)
* **🚀 Multi-Day Accuracy**: Multi-day events now align perfectly across day boundaries
* **⚡ Performance**: Optimized positioning calculations for better rendering accuracy

## [5.0.1] - 2024-01-15
* **📚 Enhanced Documentation**: Comprehensive README update showcasing multi-day events
* **🎯 Usage Examples**: Added detailed examples for single-day and multi-day scenarios
* **🔧 Configuration Guide**: Complete configuration examples for 24/7 operations
* **🚀 Use Cases**: Real-world examples (Healthcare, Manufacturing, Events, Support)
* **🔄 Migration Guide**: Clear instructions for upgrading from v4.x to v5.0
* **⚡ Performance Tips**: State management optimization guidance
* **🌟 Feature Highlights**: Improved feature showcase and professional presentation

## [5.0.0] - 2024-01-15
* **🎉 MAJOR FEATURE**: Full Multi-Day Timeline Support - Perfect for 24/7 operations!
* **BREAKING CHANGE**: Enhanced event models for multi-day support
* **Multi-Day Events**: Complete implementation allowing events to span multiple days (e.g., Monday 22:00 → Tuesday 03:00)
* **Multi-Day Timeline**: Visual timeline spanning multiple days with proper day separators and date headers
* **Enhanced Event Models**: New `DateTimeEventTime` and `MultiDayAgendaEvent` classes for cross-day scheduling
* **Perfect Background Rendering**: Multi-day aware background painter with proper alignment and clean day areas
* **Smart Scroll Synchronization**: Fixed pillar height calculations and scroll synchronization across multi-day timelines
* **Configurable Day Separators**: Customizable day headers, colors, and spacing for professional appearance
* **Comprehensive Documentation**: Added detailed guides for multi-day events implementation
* **Backward Compatibility**: All existing single-day functionality works exactly as before

## [4.0.0] - 2024-01-15
* **BREAKING CHANGE**: Major refactoring for performance improvements
* **Major Performance Improvement**: Implemented efficient state management to prevent unnecessary rebuilds
* **New State Controller**: Added `AgendaStateController` for resource-level change tracking
* **Optimized Pillar Views**: Created `OptimizedPillarView` that only rebuilds when necessary
* **Provider Integration**: Added provider dependency for efficient state management
* **Headers Position Control**: Added `HeadersPosition` enum (top/bottom) for flexible header placement
* **Scroll Physics Fix**: Replaced bouncing scroll physics with `ClampingScrollPhysics` for better UX
* **Scroll Detection**: Added smart scroll detection to prevent accidental onTap events during scrolling
* **English Translation**: Translated example app from Arabic to English
* **Flutter 2.27.0+ Compatibility**: Updated dependencies and fixed null safety issues

## [3.1.0] - 2022-04-20
* Support for ltr.

## [3.0.3] - 2022-04-15
* fixing rendering issues.

## [3.0.2] - 2022-04-09
* Passing static analysis.
## [3.0.1] - 2022-04-08
* Better docs. & args naming.


## [3.0.0] - 2022-04-08
* Integrating bidirectional scrolling

## [2.0.0] - 2022-02-18

* Documentation and fixes.

## [1.0.9] - 2022-02-14

* Changing to longPressDown (fix tap issue).

## [1.0.8] - 2022-02-13

* Head subtitle + Avatar.

## [1.0.7] - 2022-02-12

* Design improvment.
## [1.0.6] - 2022-02-10

* Add border to the event.

## [1.0.5] - 2022-02-09

* Add the 15 min view to the timeline.
## [1.0.4] - 2022-02-04

* OnClick inside the agenda.

## [1.0.3] - 2022-02-03

* Adding 30min timing.


## [1.0.2] - 2022-02-03

* Fixing Borders Issues.

## [1.0.1] - 2022-02-03

* Update Readme.

## [1.0.0] - 2022-02-02

* Initial release.
