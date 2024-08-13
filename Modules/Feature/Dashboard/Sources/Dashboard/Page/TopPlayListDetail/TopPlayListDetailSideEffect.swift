import Architecture
import Combine
import ComposableArchitecture
import Domain
import Foundation

// MARK: - TopPlayListDetailSideEffect

struct TopPlayListDetailSideEffect {
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

extension TopPlayListDetailSideEffect {
  var getItem: (MusicEntity.Chart.TopPlayList.Item) -> Effect<TopPlayListDetailReducer.Action> {
    { item in
      .publisher {
        useCase.musicTopPlayListDetailUseCase
          .track(item.serialized())
          .receive(on: main)
          .mapToResult()
          .map(TopPlayListDetailReducer.Action.fetchItem)
      }
    }
  }
}

extension MusicEntity.Chart.TopPlayList.Item {
  fileprivate func serialized() -> MusicEntity.TopPlayListDetail.Track.Request {
    .init(id: id)
  }
}
