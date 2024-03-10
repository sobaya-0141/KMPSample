import SwiftUI
import ComposableArchitecture

@main
struct iOSApp: App {
	var body: some Scene {
		WindowGroup {
            BeerView(
                store: Store(initialState: BeerFeature.State()) {
                    BeerFeature()
                }
            )
		}
	}
}
