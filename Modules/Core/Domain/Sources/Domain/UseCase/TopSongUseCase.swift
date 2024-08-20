import Combine

public protocol TopSongUseCase {
  var song: (MusicEntity.TopSong.Request) -> AnyPublisher<MusicEntity.TopSong.Response, CompositeErrorRepository> { get }
}
