import Architecture
import Domain
import LinkNavigator

struct FullAlbumRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.fullAlbum.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let requestModel: MusicEntity.Album.FullAlbum.Request = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        FullAlbumPage(
          store: .init(
            initialState: FullAlbumReducer.State(requestModel: requestModel),
            reducer: {
              FullAlbumReducer(
                sideEffect: .init(
                  useCase: env,
                  navigator: navigator))
            }))
      }
    }
  }
}
