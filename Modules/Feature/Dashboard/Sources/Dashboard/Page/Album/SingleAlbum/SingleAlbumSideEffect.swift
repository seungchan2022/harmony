import Architecture
import Combine
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - SingleAlbumSideEffect

struct SingleAlbumSideEffect {
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

extension SingleAlbumSideEffect { 
  var getItem: (MusicEntity.Album.SingleAlbum.Request) -> Effect<SingleAlbumReducer.Action> {
    { req in
      .publisher {
        useCase.albumUseCase
          .singleAlbum(req)
          .receive(on: main)
          .mapToResult()
          .map(SingleAlbumReducer.Action.fetchItem)
      }
    }
  }

  var routeToDetail: (MusicEntity.Album.SingleAlbum.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.albumDetail.rawValue,
          items: item),
        isAnimated: true)
    }
  }
}
