import ComposableArchitecture
import DesignSystem
import MusicKit
import SwiftUI

// MARK: - MostPlayedSongPage

struct MostPlayedSongPage {
  @Bindable var store: StoreOf<MostPlayedSongReducer>

  @Environment(\.colorScheme) private var colorScheme
}

extension MostPlayedSongPage {
  private var isLoading: Bool {
    store.fetchItem.isLoading
  }
}

// MARK: View

extension MostPlayedSongPage: View {
  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(store.itemList, id: \.id) { item in
          ItemComponent(viewState: .init(item: item), store: store)
        }
      }
    }
    .navigationTitle("인기곡")
    .setRequestFlightView(isLoading: isLoading)
    .onAppear {
      store.send(.getItem)
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
