import Architecture
import Combine
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - DailyTopDetailSideEffect

struct DailyTopDetailSideEffect {
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

extension DailyTopDetailSideEffect {
  var getItem: (MusicEntity.Chart.DailyTop.Item) -> Effect<DailyTopDetailReducer.Action> {
    { item in
      .publisher {
        useCase.dailyTopDetailUseCase
          .track(item.serialized())
          .receive(on: main)
          .mapToResult()
          .map(DailyTopDetailReducer.Action.fetchItem)
      }
    }
  }
}

extension MusicEntity.Chart.DailyTop.Item {
  fileprivate func serialized() -> MusicEntity.DailyTopDetail.Track.Request {
    .init(id: id)
  }
}
