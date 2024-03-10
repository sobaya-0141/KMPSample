import SwiftUI
import ComposableArchitecture
import core

struct BeerView: View {
    let store: StoreOf<BeerFeature>
	let greet = Greeting().greet()

	var body: some View {
		Text(greet)
	}
}

struct BeerView_Previews: PreviewProvider {
	static var previews: some View {
        BeerView(
            store: Store(initialState: BeerFeature.State()) {
                BeerFeature()
            }
        )
	}
}
