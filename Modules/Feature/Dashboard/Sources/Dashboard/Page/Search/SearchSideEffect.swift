import Architecture
import Combine
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - SearchSideEffect

struct SearchSideEffect {
  let useCase: DashboardEnvironmentUsable
  let main: AnySchedulerOf<DispatchQueue>
  let navigator: RootNavigatorType

  init(
    useCase: DashboardEnvironmentUsable,
    main: AnySchedulerOf<DispatchQueue> = .main,
    navigator: RootNavigatorType)
  {
    self.useCase = useCase
    self.main = main
    self.navigator = navigator
  }
}

extension SearchSideEffect {
  var song: (MusicEntity.Search.Song.Request) -> Effect<SearchReducer.Action> {
    { req in
      .publisher {
        useCase.searchUseCase
          .song(req)
          .receive(on: main)
          .map {
            MusicEntity.Search.Song.Composite(
              request: req,
              response: $0)
          }
          .mapToResult()
          .map(SearchReducer.Action.fetchSearchSongItem)
      }
    }
  }

  var artist: (MusicEntity.Search.Artist.Request) -> Effect<SearchReducer.Action> {
    { req in
      .publisher {
        useCase.searchUseCase
          .artist(req)
          .receive(on: main)
          .map {
            MusicEntity.Search.Artist.Composite(
              request: req,
              response: $0)
          }
          .mapToResult()
          .map(SearchReducer.Action.fetchSearchArtistItem)
      }
    }
  }

  var album: (MusicEntity.Search.Album.Request) -> Effect<SearchReducer.Action> {
    { req in
      .publisher {
        useCase.searchUseCase
          .album(req)
          .receive(on: main)
          .map {
            MusicEntity.Search.Album.Composite(
              request: req,
              response: $0)
          }
          .mapToResult()
          .map(SearchReducer.Action.fetchSearchAlbumItem)
      }
    }
  }

  var playList: (MusicEntity.Search.PlayList.Request) -> Effect<SearchReducer.Action> {
    { req in
      .publisher {
        useCase.searchUseCase
          .playList(req)
          .receive(on: main)
          .map {
            MusicEntity.Search.PlayList.Composite(
              request: req,
              response: $0)
          }
          .mapToResult()
          .map(SearchReducer.Action.fetchSearchPlayItem)
      }
    }
  }

  var topResult: (MusicEntity.Search.TopResult.Request) -> Effect<SearchReducer.Action> {
    { req in
      .publisher {
        useCase.searchUseCase
          .topResult(req)
          .receive(on: main)
          .map {
            MusicEntity.Search.TopResult.Composite(
              request: req,
              response: $0)
          }
          .mapToResult()
          .map(SearchReducer.Action.fetchSearchTopResultItem)
      }
    }
  }

  var keyword: (MusicEntity.Search.Keyword.Request) -> Effect<SearchReducer.Action> {
    { req in
      .publisher {
        useCase.searchUseCase
          .keyword(req)
          .receive(on: main)
          .map {
            MusicEntity.Search.Keyword.Composite(
              request: req,
              response: $0)
          }
          .mapToResult()
          .map(SearchReducer.Action.fetchSearchKeywordItem)
      }
    }
  }

  var routeToArtist: (MusicEntity.Search.TopResult.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.artist.rawValue,
          items: item),
        isAnimated: true)
    }
  }

  var routeToAlbumDetail: (MusicEntity.Search.TopResult.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.albumDetail.rawValue,
          items: item),
        isAnimated: true)
    }
  }
}
