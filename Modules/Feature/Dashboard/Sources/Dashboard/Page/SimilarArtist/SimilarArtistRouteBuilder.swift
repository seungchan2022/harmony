import Architecture
import Domain
import LinkNavigator

struct SimilarArtistRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.similarArtist.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let requestModel: MusicEntity.Artist.SimilarArtist.Request = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        SimilarArtistPage(
          store: .init(
            initialState: SimilarArtistReducer.State(requestModel: requestModel),
            reducer: {
              SimilarArtistReducer(
                sideEffect: .init(
                  useCase: env,
                  navigator: navigator))
            }))
      }
    }
  }
}
