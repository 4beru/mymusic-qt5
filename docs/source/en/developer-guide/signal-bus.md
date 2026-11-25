# Signal bus

Qt signals and slots provide event-driven communication between widgets. However, connecting unrelated components only through their parents can create unnecessary forwarding code.

## Why a shared bus?

Consider selecting an album card inside the music library. Without a shared bus, the card emits a navigation signal to its album-card view, which forwards it to the library screen, which forwards it to the main window.

A shared bus lets the card emit the navigation event directly while the main window subscribes to it. Intermediate widgets do not need to declare or relay that event.

This resembles the global event bus pattern in Vue 2: one component emits an event, another subscribes to it, and neither needs to know the other's location in the component tree. Qt provides the same separation with typed signals and slots.

## MyMusic implementation

The current implementation lives in `app/common/signal_bus.py`. `SignalBus` inherits from `Singleton` and `QObject`; the module exports the shared instance `signalBus`. It centralizes playback, navigation, playlist, metadata and application events.

The current album navigation signal accepts two strings (artist and album), rather than the single string used by the historical documentation example.

```python
from common.signal_bus import signalBus

# In the receiving window:
signalBus.switchToAlbumInterfaceSig.connect(self.switchToAlbumInterface)

# In the emitting widget:
signalBus.switchToAlbumInterfaceSig.emit("Example Artist", "Example Album")
```

The connected slot must accept the declared arguments. Register connections once when initializing the receiving component.

This pattern reduces coupling between widgets, but it does not replace explicit service interfaces. Keep event names and payloads clear and avoid using the global bus for unrelated internal state.
