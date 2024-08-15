import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - ArtistPage

struct ArtistPage {
  @Bindable var store: StoreOf<ArtistReducer>

  @Environment(\.colorScheme) private var colorScheme
}

extension ArtistPage {
  private var gridColumnList: [GridItem] {
    Array(repeating: .init(.flexible()), count: 4)
  }
}

// MARK: View

extension ArtistPage: View {
  var body: some View {
    ScrollView {
      VStack(spacing: 40) {
        VStack {
          Button(action: { }) {
            HStack {
              if let title = store.fetchTopSongItem.value?.title {
                Text(title)
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
          }
          .padding(.leading, 16)

          ScrollView(.horizontal) {
            LazyHGrid(rows: gridColumnList, spacing: 8) {
              ForEach(store.topSongItemList.prefix(8), id: \.id) { item in
                TopSongComponent(viewState: .init(item: item))
                  .frame(width: 350)
              }
            }
            .scrollTargetLayout()
            .padding(.trailing, 40)
          }
          .scrollIndicators(.hidden)
          .scrollTargetBehavior(.viewAligned)
        }
        if !store.essentialAlbumItemList.isEmpty {
          VStack {
            HStack {
              if let title = store.fetchEssentialAlbumItem.value?.title {
                Text(title)
                  .font(.title)
                  .fontWeight(.semibold)
                  .foregroundStyle(
                    colorScheme == .dark
                      ? DesignSystemColor.system(.white).color
                      : DesignSystemColor.system(.black).color)

                Spacer()
              }
            }
            .padding(.leading, 16)

            ScrollView(.horizontal) {
              LazyHStack(spacing: 16) {
                ForEach(store.essentialAlbumItemList, id: \.id) { item in
                  EssentialAlbumComponent(
                    viewState: .init(item: item),
                    tapAction: { })
                }
              }
              .scrollTargetLayout()
              .padding(.horizontal, 32)
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
          }
        }
      }
    }
    .onAppear {
      store.send(.getTopSongItem(store.item))
      store.send(.getEssentialAlbumItem(store.item))
    }
  }
}
