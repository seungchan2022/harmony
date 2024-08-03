import Combine

public protocol MusicUseCase {
  var mostPlayedSong: (MusicEntity.Chart.MostPlayedSong.Request) -> AnyPublisher<
    MusicEntity.Chart.MostPlayedSong.Response,
    CompositeErrorRepository
  > { get }
  var cityTop: (MusicEntity.Chart.CityTop.Request)
    -> AnyPublisher<MusicEntity.Chart.CityTop.Response, CompositeErrorRepository> { get }
  var dailyTop: (MusicEntity.Chart.DailyTop.Request) -> AnyPublisher<
    MusicEntity.Chart.DailyTop.Response,
    CompositeErrorRepository
  > { get }
}
