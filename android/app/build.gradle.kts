import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("io.sentry.android.gradle") version "5.12.1"
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin") 
}

val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
if(keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.cephalon.navis"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.cephalon.navis"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
       if (System.getenv("ANDROID_KEYSTORE_PATH") != null) {
           create("release") {
               storeFile = file(System.getenv("ANDROID_KEYSTORE_PATH"))
               keyAlias = System.getenv("ANDROID_KEYSTORE_ALIAS")
               keyPassword = System.getenv("ANDROID_KEYSTORE_PRIVATE_KEY_PASSWORD")
               storePassword = System.getenv("ANDROID_KEYSTORE_PASSWORD")
           }
       } else {
           create("release") {
               keyAlias = keystoreProperties["keyAlias"] as String
               keyPassword = keystoreProperties["keyPassword"] as String
               storeFile = if(keystoreProperties["storefile"] != null) file(keystoreProperties["storeFile"] as String) else null
               storePassword = keystoreProperties["storePassword"] as String
           }
       }
    }

    flavorDimensions += "default"
    productFlavors { 
        create("prod") {
            dimension = "default"
            applicationIdSuffix = ""
        }      
        create("dev") {
            dimension = "default"
            versionNameSuffix = "-dev"
            applicationIdSuffix = ".dev"
        }
    }

    buildTypes {
        debug {
            versionNameSuffix = "-debug"
            signingConfig = signingConfigs["debug"]
        }

        release {
            signingConfig = signingConfigs["release"]
            isMinifyEnabled = true
            isShrinkResources = true

            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
}


flutter {
    source = "../.."
}

dependencies {
    implementation("com.android.support:multidex:1.0.3")
}

sentry {
    autoInstallation {
      enabled = false
    }
}