import Architecture
import Domain
import LinkNavigator

struct AlbumRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.album.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let requestModel: MusicEntity.Album.Request = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        AlbumPage(
          store: .init(
            initialState: AlbumReducer.State(requestModel: requestModel),
            reducer: {
              AlbumReducer(
                sideEffect: .init(
                  useCase: env,
                  navigator: navigator))
            }))
      }
    }
  }
}
