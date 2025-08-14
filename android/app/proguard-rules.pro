# Flutter core classes
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }

# Keep Dart's generated classes
-keep class io.flutter.** { *; }
-keep class org.dartlang.** { *; }

# Firebase
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Keep annotations
-keepattributes *Annotation*

# Keep serialized classes (avoid stripping for JSON/Gson/Firestore)
# -keepclassmembers class * {
#     @com.google.gson.annotations.SerializedName <fields>;
# }

# Don't warn about missing classes in these packages
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**
