
import Foundation
import ComposableArchitecture

@Reducer
public struct LoginFeature: Reducer {
    
    public init() {}
    
    @ObservableState
    public struct State {
        var test: Int
        
        public init(test: Int = 0) {
            self.test = test
        }
    }
    
    public enum Action {
        case test
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
