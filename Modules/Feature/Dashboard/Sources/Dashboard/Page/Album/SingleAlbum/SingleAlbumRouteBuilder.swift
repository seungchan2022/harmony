import Architecture
import Domain
import LinkNavigator

struct SingleAlbumRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.singleAlbum.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let requestModel: MusicEntity.Album.SingleAlbum.Request = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        SingleAlbumPage(
          store: .init(
            initialState: SingleAlbumReducer.State(requestModel: requestModel),
            reducer: {
              SingleAlbumReducer(
                sideEffect: .init(
                  useCase: env,
                  navigator: navigator))
            }))
      }
    }
  }
}
