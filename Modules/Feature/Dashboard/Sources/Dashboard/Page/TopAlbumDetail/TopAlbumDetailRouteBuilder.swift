import Architecture
import Domain
import LinkNavigator

struct TopAlbumDetailRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.topAlbumDetail.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let item: MusicEntity.Chart.TopAlbum.Item = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        TopAlbumDetailPage(
          store: .init(
            initialState: TopAlbumDetailReducer.State(item: item),
            reducer: {
              TopAlbumDetailReducer(
                sideEffect: .init(
                  useCase: env,
                  navigator: navigator))
            }))
      }
    }
  }
}
