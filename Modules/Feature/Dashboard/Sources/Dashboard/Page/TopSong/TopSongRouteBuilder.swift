import Architecture
import Domain
import LinkNavigator

struct TopSongRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.topSong.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let requestModel: MusicEntity.TopSong.Request = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        TopSongPage(
          store: .init(
            initialState: TopSongReducer.State(requestModel: requestModel),
            reducer: {
              TopSongReducer(
                sideEffect: .init(
                  useCase: env,
                  navigator: navigator))
            }))
      }
    }
  }
}
