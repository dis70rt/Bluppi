# ⚙️ Production Engineering

<!-- 
  Write about the cool production-grade techniques you implemented.
  
  Suggested sections:

  ## Leak-Free State Management
  - Provider invalidation chain on logout (11+ providers)
  - AudioHandler.stop() before state teardown
  - Stream subscription cleanup with ref.onDispose()
  - Timer cancellation patterns

  ## Real-Time Synchronization
  - NTP clock sync implementation for cross-device playback
  - gRPC server-streaming for room events
  - Optimistic UI for live chat (no flicker)
  - Heartbeat-based presence system

  ## Background Audio
  - audio_service integration for notification controls
  - Media session handling (play/pause from lock screen)
  - Queue persistence across app lifecycle

  ## Performance Optimizations
  - Skeleton loading for pixel-perfect transitions
  - RepaintBoundary on heavy widgets (floating player)
  - Cursor-based pagination (no offset drift)
  - Debounced search with stale-request protection
  - CachedNetworkImage for album art

  ## Error Resilience
  - Graceful pagination failure (preserves existing results)
  - ref.mounted guards for async operations
  - GrpcError handling with user-friendly messages
  - Auto-retry patterns

  ## Security
  - Firebase Auth token passed via gRPC interceptor
  - Secure storage for sensitive credentials
  - No hardcoded secrets (.env based config)

  ## Infrastructure
  - Protobuf code generation pipeline (protobuf.sh)
  - Environment-based config (GRPC_SERVER_ADDRESS, etc.)
  - ADB port forwarding for local development
-->

> ✏️ **This document is a work in progress.** Fill in the sections above with your production engineering highlights.
