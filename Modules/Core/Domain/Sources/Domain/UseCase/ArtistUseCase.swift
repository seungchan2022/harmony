import Combine

public protocol ArtistUseCase {
  var topSong: (MusicEntity.Artist.TopSong.Request) -> AnyPublisher<
    MusicEntity.Artist.TopSong.Response,
    CompositeErrorRepository
  > { get }

  var essentialAlbum: (MusicEntity.Artist.EssentialAlbum.Request) -> AnyPublisher<
    MusicEntity.Artist.EssentialAlbum.Response,
    CompositeErrorRepository
  > { get }

  var fullAlbum: (MusicEntity.Artist.FullAlbum.Request) -> AnyPublisher<
    MusicEntity.Artist.FullAlbum.Response,
    CompositeErrorRepository
  > { get }
}
