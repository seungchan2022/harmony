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

        if !store.fulllAlbumItemList.isEmpty {
          VStack {
            HStack {
              if let title = store.fetchFullAlbumItem.value?.title {
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
                ForEach(store.fulllAlbumItemList, id: \.id) { item in
                  FullAlbumComponent(viewState: .init(item: item))
                }
              }
              .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
          }
        }

        if !store.musicVideoItemList.isEmpty {
          VStack {
            HStack {
              Text("뮤직 비디오")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(
                  colorScheme == .dark
                    ? DesignSystemColor.system(.white).color
                    : DesignSystemColor.system(.black).color)

              Spacer()
            }
            .padding(.leading, 16)

            ScrollView(.horizontal) {
              LazyHStack(spacing: 16) {
                ForEach(store.musicVideoItemList, id: \.id) { item in
                  MusicVideoComponent(viewState: .init(item: item))
                }
              }
              .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
          }
        }

        if !store.playItemList.isEmpty {
          VStack {
            HStack {
              Text("아티스트 및 플레이리스트")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(
                  colorScheme == .dark
                    ? DesignSystemColor.system(.white).color
                    : DesignSystemColor.system(.black).color)

              Spacer()
            }
            .padding(.leading, 16)

            ScrollView(.horizontal) {
              LazyHStack(spacing: 16) {
                ForEach(store.playItemList, id: \.id) { item in
                  PlayListComponent(viewState: .init(item: item))
                }
              }
              .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
          }
        }

        if !store.singleItemList.isEmpty {
          VStack {
            HStack {
              Text("싱글 및 EP")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(
                  colorScheme == .dark
                    ? DesignSystemColor.system(.white).color
                    : DesignSystemColor.system(.black).color)

              Spacer()
            }
            .padding(.leading, 16)

            ScrollView(.horizontal) {
              LazyHStack(spacing: 16) {
                ForEach(store.singleItemList, id: \.id) { item in
                  SingleComponent(viewState: .init(item: item))
                }
              }
              .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
          }
        }

        if !store.similarArtistItemList.isEmpty {
          VStack {
            Button(action: { }) {
              HStack {
                Text("유사한 아티스트")
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
              LazyHStack(spacing: 16) {
                ForEach(store.similarArtistItemList, id: \.id) { item in
                  SimilarArtistComponent(viewState: .init(item: item))
                }
              }
              .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
          }
        }
      }
    }
    .onAppear {
      store.send(.getTopSongItem(store.item))
      store.send(.getEssentialAlbumItem(store.item))
      store.send(.getFullAlbumItem(store.item))
      store.send(.getMusicVideoItem(store.item))
      store.send((.getPlayItem(store.item)))
      store.send(.getSingleItem(store.item))
      store.send(.getSimilarArtistItem(store.item))
    }
  }
}
