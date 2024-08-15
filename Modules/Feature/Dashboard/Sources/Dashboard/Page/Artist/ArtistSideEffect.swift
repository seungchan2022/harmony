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
  var getItem: (MusicEntity.Search.TopResult.Item) -> Effect<ArtistReducer.Action> {
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
}

extension MusicEntity.Search.TopResult.Item {
  fileprivate func serialized() -> MusicEntity.Artist.TopSong.Request {
    .init(id: id)
  }
}
