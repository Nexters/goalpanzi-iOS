import Foundation
import ProjectDescription

public enum ModulePath {
    case feature(Feature)
    case domain(Domain)
    case core(Core)
    case shared(Shared)
    case data(Data)
}

// MARK: AppModule

public extension ModulePath {
    enum App: String, CaseIterable {
        case iOS
        public static let name: String = "App"
    }
}


// MARK: FeatureModule
public extension ModulePath {
    enum Feature: String, CaseIterable {
        case Login
        public static let name: String = "Feature"
    }
}

// MARK: DomainModule

public extension ModulePath {
    enum Domain: String, CaseIterable {
        case Auth

        public static let name: String = "Domain"
    }
}

// MARK: CoreModule

public extension ModulePath {
    enum Core: String, CaseIterable {
        case Network
        
        public static let name: String = "Core"
    }
}

// MARK: SharedModule

public extension ModulePath {
    enum Shared: String, CaseIterable {
        case Util
        case DesignSystem
        case ThirdPartyLib
        
        public static let name: String = "Shared"
    }
}

// MARK: DataModule

public extension ModulePath {
    enum Data: String, CaseIterable {
        case Remote
        
        public static let name: String = "Data"
    }
}
