import Foundation
import ComposableArchitecture
import core

struct BeerFeature: Reducer {
    var sampleRepository = SampleRepository()
    
    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.Effect<Action> {
        switch action {
        case .suspendTapped:
            return .run { send in
                await send(
                    .suspendReceived(try await sampleRepository.suspendSample())
                )
            }
        case .flowTapped:
            return .run { send in
                for await text in sampleRepository.flowSample() {
                    await send(.flowReceived(text))
                }
            }
        case .suspendReceived(var response):
            state.suspendResult = response
            return .none
        case .flowReceived(var response):
            state.flowResult = response
            return .none
        }
    }
    
    @ObservableState
    struct State: Equatable {
        var suspendResult: String?
        var flowResult: String?
    }
    
    enum Action: Equatable {
        case suspendTapped
        case flowTapped
        case suspendReceived(String)
        case flowReceived(String)
    }
}
