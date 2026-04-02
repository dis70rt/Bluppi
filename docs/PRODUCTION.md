# Production Engineering

## Leak-Free State Management
Strict memory management is enforced to prevent state leakage between sessions:
* **Complete Teardown:** Entire Riverpod provider chains are invalidated on logout.
* **Graceful Audio Shutdown:** The `audio_service` handler is explicitly stopped before any state teardown begins.
* **Aggressive Cleanup:** Stream subscriptions are actively closed via lifecycle hooks, and timers are cancelled the moment their parent scopes are disposed.

## Real-Time Synchronization
Distributed playback and live features require precise coordination:
* **Optimistic UI (Live Chat):** Messages are rendered instantly in the chat feed to mask network latency, resolving silently in the background once server confirmation is received.
* **NTP Clock Sync:** Synchronizes local device clocks with a central time server to ensure tracks play at the exact same millisecond across all clients in a room.
* **gRPC Server-Streaming:** Maintains persistent, low-latency connections for instantaneous room event broadcasts.
* **Heartbeat Presence:** Utilizes a lightweight ping mechanism to accurately track the online/offline status of users in a room.

## Background Audio
The media session remains stable regardless of app lifecycle state:
* **OS Integration:** Hooks directly into Android/iOS media controls (notification shade, lock screen) via `audio_service`.
* **Persistent Queue State:** The playback queue is preserved across app state changes, ensuring the background media session does not drop when minimizing the app.

## Performance Optimizations
Techniques used to maintain a consistent 60+ FPS and reduce network load:
* **Repaint Boundaries:** Applied to heavy, continuously updating UI components (like the floating mini-player's progress bar) to prevent costly, cascading widget rebuilds.
* **Cursor-Based Pagination:** Replaces traditional offset pagination for network requests, preventing duplicate or skipped items when the underlying dataset changes during infinite scrolling.
* **Network Efficiency:** Search queries are strictly debounced, and all network images are persistently cached to minimize bandwidth.
* **Seamless Transitions:** Skeleton loaders are dimensionally matched to the final rendered UI to prevent layout shift during loading states.