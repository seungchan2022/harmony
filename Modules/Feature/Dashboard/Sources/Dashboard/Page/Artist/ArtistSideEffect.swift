import Architecture
import Combine
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - ArtistSideEffect

struct ArtistSideEffect {
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

extension ArtistSideEffect {
  var getTopSongItem: (MusicEntity.Search.TopResult.Item) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .topSong(item.serialized())
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchTopSongItem)
      }
    }
  }

  var getEssentialAlbumItem: (MusicEntity.Search.TopResult.Item) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .essentialAlbum(item.serialized())
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchEssentialAlbumItem)
      }
    }
  }
}

extension MusicEntity.Search.TopResult.Item {
  fileprivate func serialized() -> MusicEntity.Artist.TopSong.Request {
    .init(id: id)
  }

  fileprivate func serialized() -> MusicEntity.Artist.EssentialAlbum.Request {
    .init(id: id)
  }
}
