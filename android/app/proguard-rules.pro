# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Data Models
-keep class com.example.weather_app.data.models.** { *; }
-keep class com.example.weather_app.domain.entities.** { *; }

# JSON Serialization (if using specific libraries, but general keep on models helps)
-keepclassmembers class * {
  @com.google.gson.annotations.SerializedName <fields>;
}

# Google Play Core
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# Flutter Embedding (for deferred components)
-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }
-dontwarn io.flutter.embedding.engine.deferredcomponents.**
