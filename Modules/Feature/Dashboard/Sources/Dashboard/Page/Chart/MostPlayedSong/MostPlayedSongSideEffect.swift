import Architecture
import Combine
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - MostPlayedSongSideEffect

struct MostPlayedSongSideEffect {
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

extension MostPlayedSongSideEffect {
  var getItem: (MusicEntity.Chart.MostPlayedSong.Request) -> Effect<MostPlayedSongReducer.Action> {
    { req in
      .publisher {
        useCase.musicUseCase
          .mostPlayedSong(req)
          .receive(on: main)
          .mapToResult()
          .map(MostPlayedSongReducer.Action.fetchItem)
      }
    }
  }
}
