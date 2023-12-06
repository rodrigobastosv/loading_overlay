# 3.0.4

- Updating dependencies

# 3.0.3

- Adding option to not show the overlay
  
# 3.0.2

- Update docs

# 3.0.1

- Passing property useBackButtonInterceptor

# 3.0.0

- Added progress functionality
- **BreakingChange**: Refactor `overlayWidget` to `overlayWidgetBuilder`. Now requires a function to
  display current
  progress
- **BreakingChange**: Remove `overlayOpacity`. From now on use the `overlayColor` property with
  the `.withOpacity`
- Change `defaultOverlayColor` to `Colors.grey.withOpacity(0.4);` (Include opacity).
- **BreakingChange**: Remove `@Deprecated`'s methods in `OverlayControllerWidgetExtension`
- **BreakingChange**: Remove `overlayWidgetType`'s property in `OverlayControllerWidgetExtension`
- Update example
- Update README.md
- Update CHANGELOG.md

# 2.3.2

- Replaced Container Widget for SizedBox

# 2.3.1

- Fixing Opacity bug for iOS

# 2.3.0

- Fixing back button interceptor for Web

# 2.2.0

- Adding GlobalLoaderContext to be used on the MaterialApp builder

# 2.1.0

- Making Global Loader Overlay as powerful as Normal Overlay

# 2.0.10

- Fixing overlay not showing when back on the page

# 2.0.9

- Adding animation when the overlay is shown and hide

# 2.0.7

- Updating dependencies

# 2.0.6

- Making default overlay platform adaptative

# 2.0.5+1

- Formatting files

# 2.0.5

- Adding possibility to overlay only one part of the
  screen (https://github.com/rodrigobastosv/loading_overlay/issues/27)

# 2.0.4+3

- Adding flutter_lints

# 2.0.4+2

- Formatting files

# 2.0.4+1

- Adjusting README

# 2.0.4

- Add fix on prevent back button action while using named routes

# 2.0.3

- Adding possibility to prevent back button action

# 2.0.2+1

- Formatting file according to dartfmt

# 2.0.2

- Fixing overlayWidget underneath the screen overlay

# 2.0.1+1

- Adding GlobalLoaderOverlay use as example on the example project

# 2.0.1

- Fix to avoid looking deactivated widgets

# 2.0.0

- Migrating package to null safety

# 1.2.1

- `context.showLoaderOverlay` and `context.hideLoaderOverlay` marked as depricated. You should
  use `context.loaderOverlay.show` and `context.loaderOverlay.hide`
- widget that you pass to `context.loaderOverlay.show` will be shown instead of `widgetOverlay`
- Added `context.loaderOverlay.visible`
- Added `context.loaderOverlay.overlayWidgetType`
- `useDefaultLoading` set to `true` by default

# 1.2.0

- Adding possibility to pass a widget to show underneath the loading indicator

# 1.1.0+1

- Adding documentation

# 1.1.0

- Adding GlobalLoaderOverlay to use named routes

# 1.0.0+1

- Adding better description of the package

# 1.0.0

- Initial release fully functional


