import Architecture
import Combine
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - SimilarArtistSideEffect

struct SimilarArtistSideEffect {
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

extension SimilarArtistSideEffect {
  var getItem: (MusicEntity.Artist.SimilarArtist.Request) -> Effect<SimilarArtistReducer.Action> {
    { req in
      .publisher {
        useCase.artistUseCase
          .similarArtist(req)
          .receive(on: main)
          .mapToResult()
          .map(SimilarArtistReducer.Action.fetchItem)
      }
    }
  }

  var routeToArtist: (MusicEntity.Artist.SimilarArtist.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.artist.rawValue,
          items: item),
        isAnimated: true)
    }
  }
}
