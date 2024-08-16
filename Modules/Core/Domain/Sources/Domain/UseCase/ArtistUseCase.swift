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

  var musicVideo: (MusicEntity.Artist.MusicVideo.Request) -> AnyPublisher<
    MusicEntity.Artist.MusicVideo.Response,
    CompositeErrorRepository
  > { get }

  var playList: (MusicEntity.Artist.PlayList.Request) -> AnyPublisher<
    MusicEntity.Artist.PlayList.Response,
    CompositeErrorRepository
  > { get }
}
