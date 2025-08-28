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
