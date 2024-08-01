import Combine

public protocol MusicUseCase {
  var chart: () -> AnyPublisher<MusicEntity.Chart.Response, CompositeErrorRepository> { get }
}
