import Foundation
import ComposableArchitecture
import core

struct BeerFeature: Reducer {
    let sampleRepository = SampleRepository()
    let iosRepository = SampleRepositoryForIos(repository: SampleRepository()) // Kotlinのデフォルト引数対応してないの辛い
    
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
        case .nestTapped:
            return .run { send in
                for await sample in sampleRepository.flowSample2() {
                    await send(.nestReceived(sample))
                }
            }
        case .combineTapped:
            return .run { send in
                for await combine in iosRepository.combineSample() {
                    await send(.combineReceived(combine))
                }
            }
        case .suspendReceived(var response):
            state.suspendResult = response
            return .none
        case .flowReceived(var response):
            state.flowResult = response
            return .none
        case .nestReceived(var response):
            state.nestResult = response
            return .none
        case .combineReceived(var response):
            state.combineResult = response
            return .none
        }
    }
    
    @ObservableState
    struct State: Equatable {
        var suspendResult: String?
        var flowResult: String?
        var nestResult: Sample?
        var combineResult: CombineSample?
    }
    
    enum Action: Equatable {
        case suspendTapped
        case flowTapped
        case nestTapped
        case combineTapped
        case suspendReceived(String)
        case flowReceived(String)
        case nestReceived(Sample)
        case combineReceived(CombineSample)
    }
}
