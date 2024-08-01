import _MusicKit_SwiftUI
import Combine
import Domain
import MusicKit

// MARK: - MusicUseCasePlatform

public struct MusicUseCasePlatform {
  public init() { }
}

// MARK: MusicUseCase

extension MusicUseCasePlatform: MusicUseCase {
  public var chart: () -> AnyPublisher<MusicEntity.Chart.Response, CompositeErrorRepository> {
    {
      Future<MusicEntity.Chart.Response, CompositeErrorRepository> { promise in
        Task {
          do {
            // kinds의 디폴트 값은 .mostPlayed
            var req = MusicCatalogChartsRequest(
              genre: .none,
              kinds: [.mostPlayed],
              types: [Song.self])

            req.limit = 10
            req.offset = .zero

            // MusicCatalogChartsResponse
            let response = try await req.response()

            let itemList = response
              .songCharts
              .flatMap { $0.items }
              .map {
                MusicEntity.Chart.Item(
                  id: $0.id.rawValue,
                  title: $0.title,
                  artistName: $0.artistName,
                  artwork: .init(
                    url: $0.artwork?.url(width: 50, height: 50)))
              }

            let chartResponse = MusicEntity.Chart.Response(itemList: itemList)

            return promise(.success(chartResponse))

          } catch {
            return promise(.failure(.other(error)))
          }
        }
      }
      .eraseToAnyPublisher()
    }
  }
}
