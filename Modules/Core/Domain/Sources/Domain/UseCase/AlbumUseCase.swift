import Combine

public protocol AlbumUseCase {
  var album: (MusicEntity.Album.Request) -> AnyPublisher<MusicEntity.Album.Response, CompositeErrorRepository> { get }

}
