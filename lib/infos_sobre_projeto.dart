//se der o erro abaixo 

// Execution failed for task ':app:mergeDebugAssets'.
// > Could not resolve all files for configuration ':app:debugRuntimeClasspath'.
//    > Could not find com.otaliastudios:transcoder:0.9.1.
//      Searched in the following locations:
//        - https://dl.google.com/dl/android/maven2/com/otaliastudios/transcoder/0.9.1/transcoder-0.9.1.pom
//        - https://repo.maven.apache.org/maven2/com/otaliastudios/transcoder/0.9.1/transcoder-0.9.1.pom
//        - https://storage.googleapis.com/download.flutter.io/com/otaliastudios/transcoder/0.9.1/transcoder-0.9.1.pom
//      Required by:
//          project :app > project :video_compress

// dentro de     android>build.gradle 

// allprojects {
//     repositories {
//         google()
//         mavenCentral()
//         jcenter()   // inserir jcenter()  devido a erro do video_compress
//     }
// }