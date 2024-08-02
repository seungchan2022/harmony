
import ComposableArchitecture
import DesignSystem
import MusicKit
import SwiftUI

// MARK: - HomePage

struct HomePage {
  @Bindable var store: StoreOf<HomeReducer>

  @Environment(\.colorScheme) private var colorScheme
}

extension HomePage {
  private var gridColumnList: [GridItem] {
    Array(repeating: .init(.flexible()), count: 4)
  }
}

// MARK: View

extension HomePage: View {
  var body: some View {
    ScrollView {
      VStack {
        Button(action: { }) {
          HStack {
            Text("인기곡")
              .font(.title)
              .fontWeight(.semibold)
              .foregroundStyle(
                colorScheme == .dark
                  ? DesignSystemColor.system(.white).color
                  : DesignSystemColor.system(.black).color)

            Image(systemName: "chevron.right")
              .fontWeight(.bold)
              .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)

            Spacer()
          }
        }
        .padding(.leading, 16)

        ScrollView(.horizontal) {
          LazyHGrid(rows: gridColumnList, spacing: 8) {
            ForEach(store.itemList, id: \.id) { item in
              MostPlayedSongComponent(
                viewState: .init(item: item),
                store: store)
                .frame(width: 350)
            }
          }
          .padding(.trailing, 36)
          .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.viewAligned)
//        .safeAreaPadding(.horizontal, 40)
      }
      .padding(.top, 32)
    }
    .navigationTitle("차트")
    .onAppear {
      store.send(.getItem)
    }
  }
}
