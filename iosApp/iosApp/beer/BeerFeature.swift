import Foundation
import ComposableArchitecture

struct BeerFeature: Reducer {
    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.Effect<Action> {
        switch action {
        case .beerButtonTapped(let id):
            return .none
        case .beerListResponse(let beers):
            return .none
        }
    }
    
    struct State: Equatable {
        
    }
    enum Action: Equatable {
        case beerButtonTapped(Int)
        case beerListResponse(String)
    }
}
