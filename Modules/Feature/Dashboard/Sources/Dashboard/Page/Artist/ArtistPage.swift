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
    if store.topSongItemList.count >= 4 {
      return Array(repeating: .init(.fixed(80)), count: 4)
    } else {
      return Array(repeating: .init(.fixed(80)), count: store.topSongItemList.count)
    }
  }

  private var isLoading: Bool {
    store.fetchTopSongItem.isLoading
      || store.fetchEssentialAlbumItem.isLoading
      || store.fetchFullAlbumItem.isLoading
      || store.fetchMusicVideoItem.isLoading
      || store.fetchPlayListItem.isLoading
      || store.fetchSingleItem.isLoading
      || store.fetchSimilarArtistItem.isLoading
  }
}

// MARK: View

extension ArtistPage: View {
  var body: some View {
    ScrollView {
      VStack(spacing: 40) {
        if let item = store.fetchTopSongItem.value {
          InfoComponent(viewState: .init(item: item))

          VStack {
            Button(action: { store.send(.routeToTopSong(item)) }) {
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
                    tapAction: { store.send(.routeToEssentialAlbumDetail($0)) })
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
            if let item = store.fetchFullAlbumItem.value {
              Button(action: { store.send(.routeToFullAlbum(item)) }) {
                HStack {
                  if let title = store.fetchFullAlbumItem.value?.title {
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
                .padding(.leading, 16)
              }
            }

            ScrollView(.horizontal) {
              LazyHStack(spacing: 16) {
                ForEach(store.fulllAlbumItemList, id: \.id) { item in
                  FullAlbumComponent(
                    viewState: .init(item: item),
                    tapAction: { store.send(.routeToAlbumDetail($0)) })
                    .frame(width: 180)
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

        if !store.playListItemList.isEmpty {
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
                ForEach(store.playListItemList, id: \.id) { item in
                  PlayListComponent(
                    viewState: .init(item: item),
                    tapAction: { store.send(.routeToPlayListDetail($0)) })
                }
              }
              .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
          }
        }

        if !store.singleItemList.isEmpty {
          VStack {
            if let item = store.fetchSingleItem.value {
              Button(action: { store.send(.routeToSingleAlbum(item)) }) {
                HStack {
                  Text("싱글 및 EP")
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
                .padding(.leading, 16)
              }
            }
            ScrollView(.horizontal) {
              LazyHStack(spacing: 16) {
                ForEach(store.singleItemList, id: \.id) { item in
                  SingleComponent(
                    viewState: .init(item: item),
                    tapAction: { store.send(.routeToSingleAlbumDetail($0)) })
                    .frame(width: 180)
                }
              }
              .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
          }
        }

        if !store.similarArtistItemList.isEmpty {
          VStack {
            if let item = store.fetchSimilarArtistItem.value {
              Button(action: { store.send(.routeToSimilarArtist(item)) }) {
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
                .padding(.leading, 16)
              }
            }

            ScrollView(.horizontal) {
              LazyHStack(spacing: 16) {
                ForEach(store.similarArtistItemList, id: \.id) { item in
                  SimilarArtistComponent(
                    viewState: .init(item: item),
                    tapAction: { store.send(.routeToArtist($0)) })
                }
              }
              .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
          }
        }
      }
    }
    .setRequestFlightView(isLoading: isLoading)
    .ignoresSafeArea(.all, edges: .top)
    .onAppear {
      store.send(.getTopSongItem(store.topSongRequestModel))
      store.send(.getEssentialAlbumItem(store.essentialAlbumRequestModel))
      store.send(.getFullAlbumItem(store.fullAlbumRequestModel))
      store.send(.getMusicVideoItem(store.musicVideoRequestModel))
      store.send((.getPlayListItem(store.playListRequestModel)))
      store.send(.getSingleItem(store.singRequestModel))
      store.send(.getSimilarArtistItem(store.similarArtistRequestModel))
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
