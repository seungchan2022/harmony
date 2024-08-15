import SwiftUI
import ComposableArchitecture

struct ArtistPage {
  @Bindable var store: StoreOf<ArtistReducer>
}

extension ArtistPage {

}

extension ArtistPage: View {
  var body: some View {
    Text("Artist Page")
  }
}
