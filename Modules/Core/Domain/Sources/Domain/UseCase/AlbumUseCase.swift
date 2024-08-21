import Combine

public protocol AlbumUseCase {
  var fullAlbum: (MusicEntity.Album.FullAlbum.Request) -> AnyPublisher<
    MusicEntity.Album.FullAlbum.Response,
    CompositeErrorRepository
  > { get }

  var singleAlbum: (MusicEntity.Album.SingleAlbum.Request) -> AnyPublisher<
    MusicEntity.Album.SingleAlbum.Response,
    CompositeErrorRepository
  > { get }
}
