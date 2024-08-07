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
        useCase.musicSearchUseCase
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
        useCase.musicSearchUseCase
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
        useCase.musicSearchUseCase
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

  var topResult: (MusicEntity.Search.TopResult.Request) -> Effect<SearchReducer.Action> {
    { req in
      .publisher {
        useCase.musicSearchUseCase
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
}
