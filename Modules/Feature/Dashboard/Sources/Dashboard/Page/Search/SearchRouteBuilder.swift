import Architecture
import LinkNavigator

struct SearchRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.search.rawValue

    return .init(matchPath: matchPath) { navigator, _, diContanier -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContanier.resolve() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        SearchPage(
          store: .init(
            initialState: SearchReducer.State(),
            reducer: {
              SearchReducer(
                sideEffect: .init(
                  useCase: env,
                  navigator: navigator))
            }))
      }
    }
  }
}
