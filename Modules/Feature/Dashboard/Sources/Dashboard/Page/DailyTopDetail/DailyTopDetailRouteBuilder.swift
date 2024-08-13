import Architecture
import Domain
import LinkNavigator

struct DailyTopDetailRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.dailyTopDetail.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let item: MusicEntity.Chart.DailyTop.Item = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        DailyTopDetailPage(
          store: .init(
            initialState: DailyTopDetailReducer.State(item: item),
            reducer: {
              DailyTopDetailReducer(
                sideEffect: .init(
                  useCase: env,
                  navigator: navigator))
            }))
      }
    }
  }
}
