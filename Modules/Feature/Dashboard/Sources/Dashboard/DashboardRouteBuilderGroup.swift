import Architecture
import LinkNavigator

// MARK: - DashboardRouteBuilderGroup

public struct DashboardRouteBuilderGroup<RootNavigator: RootNavigatorType> {
  public init() { }
}

extension DashboardRouteBuilderGroup {
  public static var release: [RouteBuilderOf<RootNavigator>] {
    [
      HomeRouteBuilder.generate(),
      MostPlayedSongRouteBuilder.generate(),
      CityTopRouteBuilder.generate(),
      DailyTopRouteBuilder.generate(),
      TopPlayListRouteBuilder.generate(),
      TopAlbumRouteBuilder.generate(),
      TopMusicVideoRouteBuilder.generate(),
    ]
  }
}
