import SwiftUI
import ComposableArchitecture
import core

struct BeerView: View {
    let store: StoreOf<BeerFeature>
	let greet = Greeting().greet()

	var body: some View {
        VStack {
            Text(store.suspendResult ?? "")
            Button("suspend") {
                store.send(BeerFeature.Action.suspendTapped)
            }
            Text(store.flowResult ?? "")
            Button("flow") {
                store.send(BeerFeature.Action.flowTapped)
            }
            Text(store.nestResult?.inSample.test ?? "")
            Button("nest") {
                store.send(BeerFeature.Action.nestTapped)
            }
            Text(store.combineResult?.sample.inSample.test ?? "")
            Button("combine") {
                store.send(BeerFeature.Action.combineTapped)
            }
        }
		Text(greet)
	}
}

struct BeerView_Previews: PreviewProvider {
	static var previews: some View {
        BeerView(
            store: Store(
                initialState: BeerFeature.State()) {
                BeerFeature()
            }
        )
	}
}
