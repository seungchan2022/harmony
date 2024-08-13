import Combine

public protocol MusicTopPlayListDetailUseCase {
  var track: (MusicEntity.TopPlayListDetail.Track.Request) -> AnyPublisher<
    MusicEntity.TopPlayListDetail.Track.Response,
    CompositeErrorRepository
  > { get }
}
