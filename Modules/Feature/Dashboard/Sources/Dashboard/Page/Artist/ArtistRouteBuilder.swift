import Architecture
import Domain
import LinkNavigator

struct ArtistRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.artist.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let item: MusicEntity.Search.TopResult.Item = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        ArtistPage(
          store: .init(
            initialState: ArtistReducer.State(item: item),
            reducer: {
              ArtistReducer(
                sideEffect: .init(
                  useCase: env,
                  navigator: navigator))
            }))
      }
    }
  }
}
