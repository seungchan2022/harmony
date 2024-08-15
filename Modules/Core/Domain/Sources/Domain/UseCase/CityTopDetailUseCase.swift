import Combine

public protocol CityTopDetailUseCase {
  var track: (MusicEntity.CityTopDetail.Track.Request)
    -> AnyPublisher<MusicEntity.CityTopDetail.Track.Response, CompositeErrorRepository> { get }
}
