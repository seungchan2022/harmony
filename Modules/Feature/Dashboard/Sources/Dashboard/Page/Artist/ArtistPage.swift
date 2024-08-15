import ComposableArchitecture
import SwiftUI

// MARK: - ArtistPage

struct ArtistPage {
  @Bindable var store: StoreOf<ArtistReducer>
}

extension ArtistPage { }

// MARK: View

extension ArtistPage: View {
  var body: some View {
    Text("Artist Page")
  }
}
