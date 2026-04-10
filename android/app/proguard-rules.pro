# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# signAndroidDebugNeedsReleasePublicProguardRules Gradle options in the gradle.properties file.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

# Firebase
-keep class com.firebase.** { *; }
-keep class com.google.firebase.** { *; }
-keepnames class com.google.firebase.auth.** { *; }
-keepnames class com.google.firebase.firestore.** { *; }

# Retrofit
-keepattributes Signature
-keepattributes *Annotation*
-keep class retrofit.** { *; }
-keepclasseswithmembers class * {
    @retrofit.http.* <methods>;
}

# GSON
-keep class sun.misc.Unsafe { *; }
-keep class com.google.gson.stream.** { *; }
