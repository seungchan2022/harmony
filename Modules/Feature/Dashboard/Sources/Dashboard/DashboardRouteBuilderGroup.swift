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
      CityTopDetailRouteBuilder.generate(),
      DailyTopRouteBuilder.generate(),
      DailyTopDetailRouteBuilder.generate(),
      TopPlayListRouteBuilder.generate(),
      TopPlayListDetailRouteBuilder.generate(),
      TopAlbumRouteBuilder.generate(),
      TopAlbumDetailRouteBuilder.generate(),
      TopMusicVideoRouteBuilder.generate(),
      SearchRouteBuilder.generate(),
      ArtistRouteBuilder.generate(),
    ]
  }
}
