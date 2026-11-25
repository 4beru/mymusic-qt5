# Playback modes

Qt 5 exposes five playback modes through `QMediaPlaylist`. MyMusic uses all except `CurrentItemOnce`.

| Qt enum member | Value | Behavior |
| --- | --- | --- |
| `CurrentItemOnce` | 0 | Play the current item once (not exposed by MyMusic). |
| `CurrentItemInLoop` | 1 | Repeat the current track. |
| `Sequential` | 2 | Play in order and stop at the end. |
| `Loop` | 3 | Play in order and wrap to the beginning. |
| `Random` | 4 | Play in random order. |

## Combining shuffle and repeat

The playback bar has separate shuffle and repeat controls. Their combined states select the following Qt modes:

| Shuffle | Repeat control | Effective mode |
| --- | --- | --- |
| Off | Sequential | `Sequential` |
| Off | Repeat all | `Loop` |
| Off | Repeat one | `CurrentItemInLoop` |
| On | Sequential | `Random` |
| On | Repeat all | `Random` |
| On | Repeat one | `CurrentItemInLoop` |

Repeat-one takes priority over shuffle. When repeat-one is active, manually pressing Next still selects the following track in playlist order, regardless of the shuffle control.
