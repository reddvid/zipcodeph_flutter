# Flutter specific ProGuard rules for 16KB memory optimization

# Keep Flutter engine classes
-keep class io.flutter.** { *; }
-keep class androidx.** { *; }

# Keep native method names
-keepclasseswithmembernames class * {
    native <methods>;
}

# Optimize for 16KB page size
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*
-optimizationpasses 5
-allowaccessmodification

# Remove logging in release builds
-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int i(...);
    public static int w(...);
    public static int d(...);
    public static int e(...);
}

# Keep crash reporting
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception

# Keep database classes
-keep class * extends androidx.room.** { *; }
-keep class * implements java.io.Serializable { *; }

# Memory optimization for 16KB page size
-dontpreverify
-repackageclasses ''
-allowaccessmodification
-printmapping mapping.txt