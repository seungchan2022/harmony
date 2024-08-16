import Architecture
import Combine
import ComposableArchitecture
import Domain
import Foundation

// MARK: - AlbumDetailSideEffect

struct AlbumDetailSideEffect {
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

extension AlbumDetailSideEffect {
  var getItem: (MusicEntity.Chart.TopAlbum.Item) -> Effect<AlbumDetailReducer.Action> {
    { item in
      .publisher {
        useCase.albumDetailUseCase
          .track(item.serialized())
          .receive(on: main)
          .mapToResult()
          .map(AlbumDetailReducer.Action.fetchItem)
      }
    }
  }
}

extension MusicEntity.Chart.TopAlbum.Item {
  fileprivate func serialized() -> MusicEntity.AlbumDetail.Track.Request {
    .init(id: id)
  }
}
