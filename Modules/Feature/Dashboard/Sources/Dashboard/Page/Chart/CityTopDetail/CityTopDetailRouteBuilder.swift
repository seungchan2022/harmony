import Architecture
import Domain
import LinkNavigator

struct CityTopDetailRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.cityTopDetail.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let item: MusicEntity.Chart.CityTop.Item = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        CityTopDetailPage(
          store: .init(
            initialState: CityTopDetailReducer.State(item: item),
            reducer: {
              CityTopDetailReducer(
                sideEffect: .init(
                  useCase: env,
                  navigator: navigator))
            }))
      }
    }
  }
}
