import Combine

public protocol MusicDailyTopDetailUseCase {
  var track: (MusicEntity.DailyTopDetail.Track.Request) -> AnyPublisher<
    MusicEntity.DailyTopDetail.Track.Response,
    CompositeErrorRepository
  > { get }
}
