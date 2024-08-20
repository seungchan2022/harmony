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
          Button(action: { store.send(.routeToMostPlayedSong) }) {
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
          Button(action: { store.send(.routeToCityTop) }) {
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
                CityTopComponent(
                  viewState: .init(item: item),
                  tapAction: { store.send(.routeToCityTopDeatil($0)) })
              }
            }
            .padding(.trailing, 16)
          }
          .scrollIndicators(.hidden)
        }

        VStack {
          Button(action: { store.send(.routeToDailyTop) }) {
            HStack {
              Text("오늘의 TOP 100")
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
              ForEach(store.dailyTopItemList, id: \.id) { item in
                DailyTopComponent(
                  viewState: .init(item: item),
                  tapAction: { store.send(.routeToDailyTopDetail($0)) })
              }
            }
            .padding(.trailing, 16)
          }
          .scrollIndicators(.hidden)
        }

        VStack {
          Button(action: { store.send(.routeToTopPlayList) }) {
            HStack {
              Text("인기 플레이리스트")
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
              ForEach(store.topPlayItemList, id: \.id) { item in
                TopPlayListComponent(
                  viewState: .init(item: item),
                  tapAction: { store.send(.routeToTopPlayListDetail($0)) },
                  store: store)
              }
            }
            .padding(.trailing, 16)
          }
          .scrollIndicators(.hidden)
        }

        VStack {
          Button(action: { store.send(.routeToTopAlbum) }) {
            HStack {
              Text("인기 앨범")
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
              ForEach(store.topAlbumItemList, id: \.id) { item in
                TopAlbumComponent(
                  viewState: .init(item: item),
                  tapAction: { store.send(.routeToTopAlbumDetail($0)) },
                  store: store)
              }
            }
            .padding(.trailing, 16)
          }
          .scrollIndicators(.hidden)
        }

        VStack {
          Button(action: { store.send(.routeToTopMusicVideo) }) {
            HStack {
              Text("인기 뮤직비디오")
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
              ForEach(store.topMusicVideoItemList, id: \.id) { item in
                TopMusicVideoComponent(
                  viewState: .init(item: item),
                  store: store)
              }
            }
            .padding(.trailing, 16)
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
      store.send(.getDailyTopItem)
      store.send(.getTopPlayItem)
      store.send(.getTopAlbumItem)
      store.send(.getTopMusicVideoItem)
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
