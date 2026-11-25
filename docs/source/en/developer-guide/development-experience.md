# Qt development notes

These observations come from the project's historical development notes. Some are platform-, style- or Qt-version-dependent; verify them in the current environment before adopting them as general rules.

## Images, painting and metadata

- Renaming an image to `.jpg` does not convert its contents. Use an appropriate encoder if Qt cannot decode the original format.
- When writing an M4A metadata tag that is absent, initialize the tag container before adding a value if required by the metadata library.
- Use `drawPixmap()` to paint a pixmap rather than drawing a rectangle. Restore a visible pen before painting text if the painter was configured with `Qt.NoPen`.

## Layout and sizing

- A grid layout may retain its row and column structure after items are removed; adjust unused rows or columns, or rebuild the layout when necessary.
- Nest a replaceable layout inside a parent layout. Remove it with `removeItem()` and manage its widgets and ownership explicitly before inserting a replacement.
- Use `deleteLater()` for deferred Qt object deletion.
- Ensure custom scrollbars have a usable minimum height.
- `setSizeConstraint(QLayout.SetFixedSize)` on the outer layout can make the parent follow its layout size.
- `setContentsMargins(left, top, right, bottom)` takes margins in that order.
- When a widget is inserted into a group box's layout, Qt can reparent it to the group box.
- For dynamic `QListWidgetItem` dimensions, update the item's size hint from an appropriate resize handler.
- Use `adjustSize()` to resize a widget to its content and `setViewportMargins()` to configure list viewport insets.

## Window effects and style sheets

For a custom widget that should paint its style-sheet background:

```python
self.setAttribute(Qt.WA_StyledBackground, True)
self.setStyleSheet("background-color: rgb(255, 255, 255);")
```

- A translucent child can reveal the acrylic or blur effect of its parent window; the exact behavior depends on the compositor.
- `Qt.CustomizeWindowHint` can help customize window decorations; native resizing support depends on platform flags and the window implementation.
- Use `raise_()` to bring a child widget to the front of its siblings.
- A widget configured as a separate top-level window (for example with `Qt.Window` or `Qt.Popup`) may support window-specific effects.
- `setProperty()` updates Qt properties and supports dynamic properties for style-sheet selectors; style refresh may be needed.
- `background: transparent` controls a styled background but is not equivalent to `Qt.WA_TranslucentBackground` for top-level compositing.
- A popup with incorrect styling may need an explicit application style, such as `setStyle(QApplication.style())`.
- Some font weights (historically 500) can select unexpected font variants depending on the installed fonts.
- If the scrollbar track draws unwanted patterns, inspect its add-page and sub-page styling:

```css
QScrollBar::add-page:vertical,
QScrollBar::sub-page:vertical {
    background: none;
}
```

## Events, coordinates and responsiveness

- `event.pos()` provides coordinates relative to the widget receiving the event.
- `self.window()` returns the top-level widget. For a top-level window, `pos().x()` and `x()` refer to its position including the frame, whereas `geometry().x()` describes client geometry.
- Normalize directory paths before using them as keys; the original notes warn about trailing slashes in path comparisons.
- Keep GUI slots short. Break long tasks into asynchronous work or cancellable steps rather than blocking the event loop.
- Power-saving modes may affect rendering and responsiveness.
- Python closures resolve loop variables when called. Capture each value as a default argument when creating button callbacks in a loop:

```python
for index, button in enumerate(buttons):
    button.clicked.connect(lambda checked, i=index: handle_click(i))
```

These are implementation tips rather than guarantees about all Qt environments.
