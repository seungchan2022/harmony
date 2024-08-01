import ComposableArchitecture
import DesignSystem
import MusicKit
import SwiftUI

// MARK: - HomePage

struct HomePage {
  @Bindable var store: StoreOf<HomeReducer>
}

// MARK: View

extension HomePage: View {
  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(store.itemList, id: \.id) { item in
          HStack {
            RemoteImage(url: item.artwork.url?.absoluteString ?? "") {
              Rectangle()
                .fill(.gray.opacity(0.3))
                .frame(width: 50, height: 50)
            }
            .frame(width: 50, height: 50)

            VStack {
              Text(item.id)
              Text(item.title)
              Text(item.artistName)
            }
          }
        }
      }
      .frame(maxWidth: .infinity)
    }
    .navigationTitle("DD")
    .onAppear {
      store.send(.getItem)
    }
  }
}
