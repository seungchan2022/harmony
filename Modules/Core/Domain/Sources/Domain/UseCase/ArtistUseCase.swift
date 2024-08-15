import Combine

public protocol ArtistUseCase {
  var topSong: (MusicEntity.Artist.TopSong.Request) -> AnyPublisher<
    MusicEntity.Artist.TopSong.Response,
    CompositeErrorRepository
  > { get }
}
