import Combine

public protocol TopPlayListDetailUseCase {
  var track: (MusicEntity.TopPlayListDetail.Track.Request) -> AnyPublisher<
    MusicEntity.TopPlayListDetail.Track.Response,
    CompositeErrorRepository
  > { get }
}
