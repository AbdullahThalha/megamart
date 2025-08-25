plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // ১. Google Services প্লাগইন যোগ করা হলো
}

android {
    namespace = "com.example.megamart"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }



    defaultConfig {
        applicationId = "com.example.megamart"
        minSdk = 23  // Explicitly set to 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // Debug key দিয়ে সাইনিং (development এর জন্য)
            signingConfig = signingConfigs.getByName("debug")

            // R8/ProGuard configuration
            isMinifyEnabled = true // মিনিফিকেশন চালু হবে
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"), // Default rules
                "proguard-rules.pro" // তোমার custom rules
            )
        }
    }

}

flutter {
    source = "../.."
}
