
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
      VStack(spacing: 32) {
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
              ForEach(store.mostPlayedSongItemList, id: \.id) { item in
                MostPlayedSongComponent(
                  viewState: .init(item: item),
                  store: store)
                  .frame(width: 350)
              }
            }
            .scrollTargetLayout()
            .padding(.trailing, 40)
          }
          .scrollIndicators(.hidden)
          .scrollTargetBehavior(.viewAligned)
        }

        VStack {
          Button(action: { }) {
            HStack {
              Text("도시별 차트")
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
            LazyHStack {
              ForEach(store.cityTopItemList, id: \.id) { item in
                CityTopComponent(viewState: .init(item: item))
              }
            }
          }
          .scrollIndicators(.hidden)
        }
      }
      .padding(.top, 32)
    }
    .navigationTitle("차트")
    .onAppear {
      store.send(.getMostPlayedSongItem)
      store.send(.getCityTopItem)
    }
  }
}
