import Architecture
import Combine
import ComposableArchitecture
import Domain
import Foundation

// MARK: - TopAlbumDetailSideEffect

struct TopAlbumDetailSideEffect {
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

extension TopAlbumDetailSideEffect {
  var getItem: (MusicEntity.Chart.TopAlbum.Item) -> Effect<TopAlbumDetailReducer.Action> {
    { item in
      .publisher {
        useCase.musicAlbumDetailUseCase
          .track(item.serialized())
          .receive(on: main)
          .mapToResult()
          .map(TopAlbumDetailReducer.Action.fetchItem)
      }
    }
  }
}

extension MusicEntity.Chart.TopAlbum.Item {
  fileprivate func serialized() -> MusicEntity.AlbumDetail.Track.Request {
    .init(id: id)
  }
}
