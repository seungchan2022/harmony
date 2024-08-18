import Architecture
import Domain
import LinkNavigator

struct PlayListDetailRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.playListDetail.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let item: MusicEntity.Chart.TopPlayList.Item = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        PlayListDetailPage(
          store: .init(
            initialState: PlayListDetailReducer.State(item: item),
            reducer: {
              PlayListDetailReducer(
                sideEffect: .init(
                  useCase: env,
                  navigator: navigator))
            }))
      }
    }
  }
}
