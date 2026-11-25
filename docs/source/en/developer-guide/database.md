# Database design

MyMusic stores library information, albums, artists, playlists and recent playback records in SQLite through Qt SQL. The database initializer opens a named `QSQLITE` connection and initializes the service tables.

## Data access layers

| Layer | Responsibility |
| --- | --- |
| `entity` | Python objects representing stored records. |
| `dao` | Data access and SQL operations; `DaoBase` factors out common behavior. |
| `service` | Business logic built on the DAO layer. |
| `controller` | Interfaces used by the rest of the application to access services. |

## Tables and entity fields

The following tables describe the original documented schema and Python field types; the DAO implementation is authoritative for the current SQL schema.

### `tbl_song_info` — `SongInfo`

| Field | Type | Meaning |
| --- | --- | --- |
| `file` | str | Local path or online track URL |
| `title` | str | Track title |
| `singer` | str | Artist |
| `album` | str | Album |
| `year` | int | Year |
| `genre` | str | Genre |
| `duration` | int | Duration in seconds |
| `track` | int | Track number |
| `trackTotal` | int | Number of tracks on the album |
| `disc` | int | Disc number |
| `discTotal` | int | Total discs |
| `createTime` | int | File creation time |
| `modifiedTime` | int | File modification time |

The `file` field may hold a local file path (for example, `D:/Music/Example.mp3`), a direct online URL, or a provider-specific placeholder resolved to a playable URL at playback time.

### `tbl_album_info` — `AlbumInfo`

| Field | Type | Meaning |
| --- | --- | --- |
| `id` | str | Album identifier |
| `singer` | str | Artist |
| `album` | str | Album name |
| `year` | int | Year |
| `genre` | str | Genre |
| `modifiedTime` | int | Modification time |

### `tbl_singer_info` — `SingerInfo`

| Field | Type | Meaning |
| --- | --- | --- |
| `id` | str | Artist identifier |
| `singer` | str | Artist name |
| `genre` | str | Genre |

### `tbl_playlist` — `Playlist`

| Field | Type | Meaning |
| --- | --- | --- |
| `name` | str | Playlist name |
| `singer` | str | Artist of the first track |
| `album` | str | Album of the first track |
| `count` | int | Track count |
| `modifiedTime` | int | Modification time |

Artist, album and count are derived from playlist contents. The original design notes identify these fields as candidates for query-time computation rather than duplicated stored values.

### `tbl_song_playlist` — `SongPlaylist`

This association table connects tracks to custom playlists.

| Field | Type | Meaning |
| --- | --- | --- |
| `id` | str | Association identifier |
| `file` | str | Track path or URL |
| `name` | str | Playlist name |

### `tbl_recent_play` — `RecentPlay`

| Field | Type | Meaning |
| --- | --- | --- |
| `file` | str | Track path or URL |
| `lastPlayedTime` | int | Most recent playback time |
| `frequency` | int | Number of plays |
