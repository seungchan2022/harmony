import Architecture
import Domain
import LinkNavigator

struct ArtistRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.artist.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let topSongRequestModel: MusicEntity.Artist.TopSong.Request = items.decoded() else { return .none }
      guard let essentialAlbumRequestModel: MusicEntity.Artist.EssentialAlbum.Request = items.decoded() else { return .none }
      guard let fullAlbumRequestModel: MusicEntity.Artist.FullAlbum.Request = items.decoded() else { return .none }
      guard let musicVideoRequestModel: MusicEntity.Artist.MusicVideo.Request = items.decoded() else { return .none }
      guard let playListRequestModel: MusicEntity.Artist.PlayList.Request = items.decoded() else { return .none }
      guard let singRequestModel: MusicEntity.Artist.Single.Request = items.decoded() else { return .none }
      guard let similarArtistRequestModel: MusicEntity.Artist.SimilarArtist.Request = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        ArtistPage(
          store: .init(
            initialState: ArtistReducer.State(
              topSongRequestModel: topSongRequestModel,
              essentialAlbumRequestModel: essentialAlbumRequestModel,
              fullAlbumRequestModel: fullAlbumRequestModel,
              musicVideoRequestModel: musicVideoRequestModel,
              playListRequestModel: playListRequestModel,
              singRequestModel: singRequestModel,
              similarArtistRequestModel: similarArtistRequestModel),
            reducer: {
              ArtistReducer(
                sideEffect: .init(
                  useCase: env,
                  navigator: navigator))
            }))
      }
    }
  }
}
