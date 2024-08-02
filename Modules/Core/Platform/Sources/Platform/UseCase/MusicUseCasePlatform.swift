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
  public var chart: (MusicEntity.Chart.Request) -> AnyPublisher<MusicEntity.Chart.Response, CompositeErrorRepository> {
    { req in
      Future<MusicEntity.Chart.Response, CompositeErrorRepository> { promise in
        Task {
          do {
            // kinds의 디폴트 값은 .mostPlayed
            var request = MusicCatalogChartsRequest(
              genre: .none,
              kinds: [.mostPlayed],
              types: [Song.self])

            // 보여줄 아이템 갯수
            request.limit = req.limit
            // 몇 번재 아이템 부터 보여줄것인가
//            request.offset = .zero

            // MusicCatalogChartsResponse
            let response = try await request.response()

            let itemList = response
              .songCharts
              .flatMap { $0.items }
              .map {
                MusicEntity.Chart.Item(
                  id: $0.id.rawValue,
                  title: $0.title,
                  artistName: $0.artistName,
                  artwork: .init(
                    url: $0.artwork?.url(width: 60, height: 60)))
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
