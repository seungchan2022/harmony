import Architecture
import Combine
import ComposableArchitecture
import Domain
import Foundation

// MARK: - TopMusicVideoSideEffect

struct TopMusicVideoSideEffect {
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

extension TopMusicVideoSideEffect {
  var getItem: (MusicEntity.Chart.TopMusicVideo.Request) -> Effect<TopMusicVideoReducer.Action> {
    { req in
      .publisher {
        useCase.musicUseCase
          .topMusicVideo(req)
          .receive(on: main)
          .mapToResult()
          .map(TopMusicVideoReducer.Action.fetchItem)
      }
    }
  }
}
