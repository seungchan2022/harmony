import Combine

public protocol MusicCityTopDetailUseCase {
  var track: (MusicEntity.CityTopDetail.Track.Request)
    -> AnyPublisher<MusicEntity.CityTopDetail.Track.Response, CompositeErrorRepository> { get }
}
