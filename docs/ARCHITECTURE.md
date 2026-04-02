# 🏗 Architecture & Flow

<!-- 
  Write your Flutter architecture deep-dive here.
  
  Suggested sections:

  ## Layer Overview
  - Presentation (ui/) — Screens, widgets, no business logic
  - Application (application/) — Riverpod providers, notifiers, state
  - Domain (domain/) — Models, repository interfaces
  - Data (data/) — gRPC clients, Firebase, local storage

  ## State Management Patterns
  - AsyncNotifier vs Notifier — when to use which
  - .autoDispose lifecycle and memory management
  - .family providers for scoped state (liveChatProvider(roomId))
  - Provider invalidation on logout

  ## Navigation & Auth Flow
  - GoRouter setup with refreshListenable
  - Auth state → redirect logic (login → create profile → home)
  - Shell route for bottom navigation

  ## Data Flow Diagrams
  - User taps play → QueueNotifier → PlaybackNotifier → AudioHandler → just_audio
  - User sends chat → optimistic update → gRPC → server broadcast → stream listener → state update
  - Room join → SubscribeToRoomEvents stream → RoomEventsNotifier → dispatches to chat/member providers

  ## gRPC Integration
  - Channel setup with auth interceptor
  - Server-streaming for room events
  - Unary calls for CRUD operations
  - Proto file organization and code generation

  ## Audio Architecture
  - AudioHandler (audio_service) for background playback
  - Playback state stream → PlayerProvider
  - Queue management with QueueNotifier
  - NTP clock sync for multi-device synchronization
-->

> ✏️ **This document is a work in progress.** Fill in the sections above with your architecture details.
