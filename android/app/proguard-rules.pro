# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Flutter deferred components / Play Core (referenced by Flutter embedding).
# Keep to avoid R8 warnings/removal when split-install classes are absent.
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }

# Google Mobile Ads (AdMob) — SDK uses reflection for mediation adapters, etc.
-keep class com.google.android.gms.ads.** { *; }
-keep class com.google.ads.** { *; }
-dontwarn com.google.android.gms.ads.**

# AndroidX App Startup + WorkManager (used by AdMob for background work).
# Their initializers/DB are resolved reflectively, so R8 must not remove them.
-keep class androidx.startup.** { *; }
-keep class androidx.work.** { *; }
-keep class * extends androidx.startup.Initializer { *; }
-keep class * extends androidx.work.Worker { *; }
-keep class * extends androidx.work.ListenableWorker { *; }

# Room (backs WorkDatabase) — keep generated impls and annotated entities/DAOs.
-keep class androidx.room.** { *; }
-keep class * extends androidx.room.RoomDatabase { *; }
-keep @androidx.room.Entity class * { *; }
-dontwarn androidx.room.**

# Keep annotations, generics, and inner-class attributes used via reflection.
-keepattributes *Annotation*, Signature, InnerClasses, EnclosingMethod
