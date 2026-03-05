# 🎵 Bluppi (Mobile Client)

A real-time synchronized music and chat platform built with Flutter. Users can create parties, listen to music together, and communicate via live chat—all synchronized across devices through gRPC and Firestore.

> **🔗 Backend Repository**: [Backend Link Placeholder](#) — See the Go backend implementation for this project.

---

## 📋 Overview

Bluppi is a collaborative music experience where users can:
- **Create or join rooms** to listen to music together in real-time
- **Synchronized playback** across all participants—music stays in sync across devices
- **Live chat** with room members with optimized state management
- **User profiles** and follow mechanics
- **Search & discovery** for tracks and rooms
- **Firebase authentication** with Google Sign-In for seamless onboarding

This is the **mobile client** that connects to the backend via gRPC for real-time, bidirectional communication.

---

## 🛠 Tech Stack

| Layer | Technology |
|-------|-----------|
| **Framework** | Flutter 3.10.7+ |
| **State Management** | Riverpod 3.2.1 with `.autoDispose` |
| **Real-Time Communication** | gRPC & HTTP/2 |
| **Authentication** | Firebase Auth + Google Sign-In |
| **Audio Playback** | audio_service + just_audio |
| **Local Storage** | SQLite (sqflite) + Secure Storage |
| **UI & Navigation** | GoRouter + Material Design |
| **Networking** | gRPC (Dart), Protocol Buffers |

**Key Dependencies**:
```yaml
flutter_riverpod: ^3.2.1
grpc: ^5.1.0
protobuf: ^6.0.0
go_router: ^17.1.0
firebase_core: ^4.4.0
firebase_auth: ^6.1.4
audio_service: (audio playback in background)
cached_network_image: ^3.4.1
```

---

## 🏗 Client Architecture

### State Management with Riverpod

**Problem**: Managing state across 1,000+ room members with efficient memory usage.

**Solution**: 
- **`.autoDispose` providers** for transient room states (chat, member lists) that are garbage-collected when unused
- **TTL-based caching** for user profiles to prevent duplicate network requests
- **Provider family** for scoped states (e.g., `liveChatProvider(roomId)` for room-specific chat)

**Example**:
```dart
final liveChatProvider = NotifierProvider.family.autoDispose<LiveChatNotifier, List<LiveChatBubble>, String>(
  (ref, roomId) => LiveChatNotifier(roomId),
);
```
When a user leaves the room, this provider is automatically disposed, freeing memory.

---

### Real-Time Chat with Optimistic UI

**Challenge**: Chat messages must appear instant while waiting for server confirmation.

**Implementation**:
1. User types a message and taps send
2. UI immediately displays the message locally (optimistic update)
3. `sendMessage()` calls the backend gRPC endpoint
4. Backend broadcasts the event to all subscribers via `SubscribeToRoomEvents` stream
5. When the event returns through the stream, the UI updates with the confirmed message

This prevents flickering and provides a native-app feel.

---

### gRPC Stream Handling

The app uses **server-streaming RPC** via `SubscribeToRoomEvents` to listen for real-time updates:

```dart
Stream<RoomEventModel> subscribeToRoomEvents(String roomId, String userId);
```

**Handled Events**:
- `userJoined` — New member in the room
- `userLeft` — Member disconnected
- `liveChatMessage` — New chat message
- `roomEnded` — Room closed

All streams are properly disposed in `RoomEventsNotifier` using `ref.onDispose()` to prevent memory leaks.

---

### Memory Leak Prevention

✅ **Patterns Used**:
- Stream subscriptions cancelled in `ref.onDispose()`
- Timers cancelled on provider disposal
- Widget controllers disposed in `dispose()` methods
- No listener retention after widget unmount

---

## 📸 Screenshots

Coming soon! Place your app screenshots here:

- **splash & onboarding**
- **home screen & room list**
- **music party playback**
- **live chat in room**

> Placeholder directory: `/screenshots/`

---

## 📦 Prerequisites

Ensure you have installed:

- **Flutter SDK** (3.10.7 or later)
  ```bash
  flutter --version
  ```
- **Dart SDK** (included with Flutter)
- **Protocol Buffers Compiler** (`protoc`)
  ```bash
  protoc --version
  ```
- **gRPC Dart Plugin**
  ```bash
  dart pub global activate protoc_plugin
  ```
- **Android SDK** (for Android development) or **Xcode** (for iOS)

---

## 🚀 Local Setup

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/bluppi-frontend.git
cd bluppi-frontend
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Configure Backend Connection

Update `lib/config.dart` with your backend server address:

```dart
class AppConfig {
  static const String grpcServerAddress = 'YOUR_BACKEND_IP';
  static const int grpcServerPort = 50051;
}
```

Or pass at runtime:
```bash
flutter run --dart-define=GRPC_SERVER_ADDRESS=192.168.1.100 \
            --dart-define=GRPC_SERVER_PORT=50051
```

### 4. Set Up Port Forwarding (Android Only)

For connecting to a local backend on your development machine:

```bash
adb devices | awk 'NR>1 && $2=="device" {print $1}' | xargs -I {} sh -c 'adb -s {} reverse tcp:50051 tcp:50051 && adb -s {} reverse tcp:8001 tcp:8001'
```

### 5. Generate Code (Protocol Buffers & Riverpod)

```bash
# Generate gRPC stubs from .proto files
protoc --dart_out=grpc:lib/generated \
       -Ilib/protobufs \
       lib/protobufs/*.proto

# Generate Riverpod providers (if using @riverpod annotation)
dart run build_runner build --delete-conflicting-outputs
```

### 6. Run the App

```bash
flutter run
```

---

## 📁 Project Structure

```
lib/
├── main.dart                     # Entry point, Audio Service initialization
├── app.dart                      # Root MaterialApp with theme & router
├── config.dart                   # Environment config (gRPC address, port)
│
├── application/
│   └── providers/                # Riverpod providers (state management)
│       ├── auth/                 # Authentication & onboarding
│       ├── room/                 # Room management & live chat
│       ├── music/                # Music playback & queue
│       ├── party/                # Party sync & history
│       ├── user/                 # User profiles & follow
│       └── theme_provider.dart   # Dark/light theme
│
├── ui/
│   ├── screens/                  # Full page widgets
│   │   ├── LoginScreen/
│   │   ├── CreateProfileScreen/
│   │   ├── HomeScreen/
│   │   ├── RoomScreen/           # Main chat & music room
│   │   ├── ProfileScreen/
│   │   └── SearchScreen/
│   └── widgets/                  # Reusable UI components
│       └── chats/                # Chat UI (input, feed, bubbles)
│
├── core/
│   ├── constants/                # Colors, themes, app constants
│   └── utils/                    # Helpers, leak observer, formatters
│
├── domain/
│   ├── models/                   # Business logic models
│   │   ├── room_model.dart
│   │   ├── track_model.dart
│   │   ├── user_model.dart
│   │   ├── live_chat_bubble.dart
│   │   ├── room_events_model.dart
│   │   └── ...
│   └── repositories/             # Abstract repository interfaces
│
├── data/
│   ├── auth/                     # Authentication implementation
│   ├── grpc/                     # gRPC service clients & repositories
│   │   ├── channels/             # gRPC channel configuration
│   │   └── repositories/         # RoomService, MusicService, etc.
│   └── local/                    # Local DB (SQLite) & caching
│
├── navigation/
│   └── app_router.dart           # GoRouter configuration & named routes
│
├── audio/
│   └── player_handler.dart       # AudioService handler for background playback
│
├── generated/                    # Auto-generated code
│   ├── *.pbgrpc.dart            # gRPC stubs from .proto
│   ├── *.pb.dart                # Protobuf message classes
│   └── ...
│
└── protobufs/
    └── *.proto                   # Proto definitions (synced with backend)

android/ & ios/                    # Platform-specific code
```

---

## 🔧 Environment Variables

The app reads gRPC server configuration from `lib/config.dart` using Dart's `String.fromEnvironment()`:

```dart
class AppConfig {
  static const String grpcServerAddress = String.fromEnvironment(
    'GRPC_SERVER_ADDRESS',
    defaultValue: 'localhost',
  );
  
  static const int grpcServerPort = int.fromEnvironment(
    'GRPC_SERVER_PORT',
    defaultValue: 50051,
  );
}
```

**Pass at build time**:
```bash
flutter run --dart-define=GRPC_SERVER_ADDRESS=10.0.2.2 \
            --dart-define=GRPC_SERVER_PORT=50051
```

**For Firebase**: Credentials are automatically configured via `firebase.json` and `google-services.json`.

---

## 🎯 Key Features & Architecture Highlights

### 1. **Optimistic Chat Updates**
Messages appear instantly in the UI while confirmation comes from the server stream. No flickering or delay perception.

### 2. **Synchronized Music Playback**
Users join a "party" and music automatically syncs across all devices. The gRPC `PlaybackStreamProvider` broadcasts playback state (play/pause/seek) in real-time.

### 3. **Event-Driven Architecture**
All room changes (new members, chat, music sync) flow through Riverpod providers, triggered by the gRPC event stream. Single source of truth.

### 4. **Memory-Safe State Management**
- `.autoDispose` cancels unused providers automatically
- Stream subscriptions cleaned up with `ref.onDispose()`
- No retained listeners after widget unmount
- Tested for 1,000+ member rooms without leaks

### 5. **Segregated Layers** (Clean Architecture)
- **Presentation** (`ui/`) — UI only
- **Application** (`application/`) — State & business logic
- **Domain** (`domain/`) — Models & interfaces
- **Data** (`data/`) — API calls & local storage

---

## 🔄 Workflow: Sending a Chat Message

```
User types "Hey!" → [LiveChatInput]
                ↓
            _handleSend()
                ↓
    ref.read(liveChatProvider(roomId).notifier)
           .sendMessage("Hey!")
                ↓
    async repo.sendLiveChatMessage(roomId, userId, text)
                ↓
         gRPC server processes
                ↓
    Backend broadcasts RoomEvent to all subscribers
                ↓
    Client receives via SubscribeToRoomEvents stream
                ↓
    RoomEventsNotifier._listenToEvents() handles it
                ↓
    LiveChatNotifier.addUserMessage() updates state
                ↓
         UI re-renders with new chat
```

---

## ⚙️ Development Notes

### Generating Code

After updating `.proto` files:
```bash
protoc --dart_out=grpc:lib/generated -Ilib/protobufs lib/protobufs/*.proto
```

After changing Riverpod providers with `@riverpod` annotation:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Debugging gRPC Calls

Enable gRPC logs in `main.dart`:
```dart
import 'dart:developer' as developer;

developer.log('Event received', name: 'gRPC');
```

### Testing with Mock Backend

See the backend repository for running a local test server with sample data.

---

## 📝 Future Improvements

- [ ] Offline mode with local message queue
- [ ] Message reactions & threading
- [ ] Voice chat integration
- [ ] End-to-end encryption for messages
- [ ] Push notifications for room invites

---

## 🚧 Status

**Development** — Active development. APIs and structures may change.

---

## 📄 License

[Add your license here]

---

## 👨‍💻 Contributing

Contributions welcome! For major changes, please open an issue first to discuss.

---

## 📞 Questions?

Refer to the [Backend Repository](#) for server setup and gRPC service definitions, or open an issue on GitHub.
