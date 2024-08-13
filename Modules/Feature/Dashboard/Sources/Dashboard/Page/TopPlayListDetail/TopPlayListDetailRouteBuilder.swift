import Architecture
import Domain
import LinkNavigator

struct TopPlayListDetailRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.topPlayListDetail.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let item: MusicEntity.Chart.TopPlayList.Item = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        TopPlayListDetailPage(
          store: .init(
            initialState: TopPlayListDetailReducer.State(item: item),
            reducer: {
              TopPlayListDetailReducer(
                sideEffect: .init(
                  useCase: env,
                  navigator: navigator))
            }))
      }
    }
  }
}
