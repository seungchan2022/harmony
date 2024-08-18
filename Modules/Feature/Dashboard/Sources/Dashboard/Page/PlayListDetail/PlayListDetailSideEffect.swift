import Architecture
import Combine
import ComposableArchitecture
import Domain
import Foundation

// MARK: - PlayListDetailSideEffect

struct PlayListDetailSideEffect {
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

extension PlayListDetailSideEffect {
  var getItem: (MusicEntity.Chart.TopPlayList.Item) -> Effect<PlayListDetailReducer.Action> {
    { item in
      .publisher {
        useCase.playListDetailUseCase
          .track(item.serialized())
          .receive(on: main)
          .mapToResult()
          .map(PlayListDetailReducer.Action.fetchItem)
      }
    }
  }
}

extension MusicEntity.Chart.TopPlayList.Item {
  fileprivate func serialized() -> MusicEntity.PlayListDetail.Track.Request {
    .init(id: id)
  }
}
