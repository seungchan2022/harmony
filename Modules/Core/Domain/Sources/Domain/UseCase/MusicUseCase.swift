import Combine

public protocol MusicUseCase {
  var chart: (MusicEntity.Chart.Request) -> AnyPublisher<MusicEntity.Chart.Response, CompositeErrorRepository> { get }
}
