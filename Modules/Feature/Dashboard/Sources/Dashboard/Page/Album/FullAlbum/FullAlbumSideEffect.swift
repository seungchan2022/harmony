import Architecture
import Combine
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - FullAlbumSideEffect

struct FullAlbumSideEffect {
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

extension FullAlbumSideEffect {
  var getItem: (MusicEntity.Album.FullAlbum.Request) -> Effect<FullAlbumReducer.Action> {
    { req in
      .publisher {
        useCase.albumUseCase
          .fullAlbum(req)
          .receive(on: main)
          .mapToResult()
          .map(FullAlbumReducer.Action.fetchItem)
      }
    }
  }
}
