import Combine

public protocol DailyTopDetailUseCase {
  var track: (MusicEntity.DailyTopDetail.Track.Request) -> AnyPublisher<
    MusicEntity.DailyTopDetail.Track.Response,
    CompositeErrorRepository
  > { get }
}
