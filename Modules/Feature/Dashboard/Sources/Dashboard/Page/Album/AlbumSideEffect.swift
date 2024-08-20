import Architecture
import Combine
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - AlbumSideEffect

struct AlbumSideEffect {
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

extension AlbumSideEffect {
  var getItem: (MusicEntity.Album.Request) -> Effect<AlbumReducer.Action> {
    { req in
      .publisher {
        useCase.albumUseCase
          .album(req)
          .receive(on: main)
          .mapToResult()
          .map(AlbumReducer.Action.fetchItem)
      }
    }
  }
}
