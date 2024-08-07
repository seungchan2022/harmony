import Combine

public protocol MusicSearchUseCase {
  var song: (MusicEntity.Search.Song.Request) -> AnyPublisher<MusicEntity.Search.Song.Response, CompositeErrorRepository> { get }

  var artist: (MusicEntity.Search.Artist.Request)
    -> AnyPublisher<MusicEntity.Search.Artist.Response, CompositeErrorRepository> { get }

  var album: (MusicEntity.Search.Album.Request)
    -> AnyPublisher<MusicEntity.Search.Album.Response, CompositeErrorRepository> { get }

  var topResult: (MusicEntity.Search.TopResult.Request) -> AnyPublisher<
    MusicEntity.Search.TopResult.Response,
    CompositeErrorRepository
  > { get }

  var keyword: (MusicEntity.Search.Keyword.Request) -> AnyPublisher<
    MusicEntity.Search.Keyword.Response,
    CompositeErrorRepository
  > { get }
}
