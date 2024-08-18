import Combine

public protocol PlayListDetailUseCase {
  var track: (MusicEntity.PlayListDetail.Track.Request) -> AnyPublisher<
    MusicEntity.PlayListDetail.Track.Response,
    CompositeErrorRepository
  > { get }
}
