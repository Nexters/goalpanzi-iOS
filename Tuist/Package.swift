// swift-tools-version: 5.10
import PackageDescription

#if TUIST
    import ProjectDescription
    import ProjectDescriptionHelpers

    let packageSettings = PackageSettings(
        productTypes: [
            "ComposableArchitecture": .framework,
            "Kingfisher": .framework,
            "Alamofire": .framework,
            "Lottie": .framework,
            "HorizonCalendar": .framework,
            "FirebaseMessaging": .staticFramework,
            "FirebaseAnalytics": .staticFramework,
            "FirebaseCrashlytics": .staticFramework
        ],
        baseSettings: .settings(configurations: [
            .debug(name: "dev"),
            .release(name: "prod")
        ])
    )
#endif

let package = Package(
    name: "PackageName",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.11.2"),
        .package(url: "https://github.com/onevcat/Kingfisher", from: "7.12.0"),
        .package(url: "https://github.com/Alamofire/Alamofire", from: "5.9.1"),
        .package(url: "https://github.com/airbnb/lottie-ios", from: "4.5.0"),
        .package(url: "https://github.com/airbnb/HorizonCalendar", from: "2.0.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "11.5.0")
    ]
)
