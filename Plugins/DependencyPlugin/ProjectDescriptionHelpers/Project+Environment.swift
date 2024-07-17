import Foundation
import ProjectDescription

public extension Project {
    enum Environment {
        public static let appName = "MissionMate"
        public static let deploymentTarget = DeploymentTargets.iOS("17.0")
        public static let bundlePrefix = "com.goalpanzi.missionmate"
    }
}
