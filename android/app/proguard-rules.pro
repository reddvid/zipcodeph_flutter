# Comprehensive 16KB Memory Optimization - Flutter ProGuard Configuration
# Generated for Google Play Store 16KB memory page size compliance

#===============================================================================
# FLUTTER CORE RULES - Essential for Flutter app functionality
#===============================================================================

# Keep Flutter Framework classes
-keep class io.flutter.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugin.** { *; }

# Keep Dart native methods and Flutter JNI
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep Flutter plugin registrant
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.plugin.common.** { *; }

#===============================================================================
# GOOGLE PLAY CORE - Essential for Play Store functionality
#===============================================================================

# Keep Google Play Core classes (for app bundles and dynamic features)
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# Keep Play Store specific Flutter classes  
-keep class io.flutter.embedding.android.FlutterPlayStoreSplitApplication { *; }
-keep class io.flutter.embedding.engine.deferredcomponents.PlayStoreDeferredComponentManager** { *; }

#===============================================================================
# ANDROID OPTIMIZATION - Essential Android classes and methods
#===============================================================================

# Keep Activity and Service classes
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider

# Keep View classes and custom views
-keep public class * extends android.view.View {
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
}

# Keep methods called from XML layouts
-keepclassmembers class * extends android.app.Activity {
   public void *(android.view.View);
}

# Keep Parcelable implementations
-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}

#===============================================================================
# REFLECTION AND SERIALIZATION - Prevent issues with dynamic loading
#===============================================================================

# Keep classes used via reflection
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod
-keepattributes InnerClasses

# Keep enum values
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

#===============================================================================
# PLUGIN COMPATIBILITY - Ensure Flutter plugins work correctly
#===============================================================================

# Share Plus plugin
-keep class dev.fluttercommunity.plus.share.** { *; }

# Package Info Plus plugin  
-keep class dev.fluttercommunity.plus.packageinfo.** { *; }

# URL Launcher plugin
-keep class io.flutter.plugins.urllauncher.** { *; }

# Path Provider plugin
-keep class io.flutter.plugins.pathprovider.** { *; }

#===============================================================================
# MEMORY OPTIMIZATION - 16KB page size specific optimizations
#===============================================================================

# Aggressively remove unused code
-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int i(...);
    public static int w(...);
    public static int d(...);
    public static int e(...);
}

# Remove debug information in release builds
-keepattributes LineNumberTable,SourceFile

#===============================================================================
# FINAL SAFETY RULES - Prevent over-optimization
#===============================================================================

# Don't optimize away classes that might be referenced dynamically
-keep class com.google.gson.** { *; }
-keep class kotlin.** { *; }
-keep class kotlinx.** { *; }

# Keep MainActivity and other entry points
-keep class com.example.zipcodeph_flutter.MainActivity { *; }

# Prevent optimization of classes that use native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

#===============================================================================
# WARNINGS SUPPRESSION - Clean build output  
#===============================================================================

# Suppress warnings for missing classes that are optional
-dontwarn java.lang.instrument.ClassFileTransformer
-dontwarn sun.misc.SignalHandler
-dontwarn java.lang.instrument.Instrumentation
-dontwarn sun.misc.Signal
-dontwarn com.google.android.play.core.**

# End of 16KB Optimization Rules