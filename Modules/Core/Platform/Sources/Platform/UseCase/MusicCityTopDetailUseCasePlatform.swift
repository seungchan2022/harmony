import Combine
import Domain
import MusicKit

// MARK: - MusicCityTopDetailUseCasePlatform

public struct MusicCityTopDetailUseCasePlatform {
  public init() { }
}

// MARK: MusicCityTopDetailUseCase

extension MusicCityTopDetailUseCasePlatform: MusicCityTopDetailUseCase {
  public var track: (MusicEntity.CityTopDetail.Track.Request) -> AnyPublisher<
    MusicEntity.CityTopDetail.Track.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.CityTopDetail.Track.Response, CompositeErrorRepository> { promise in
        Task {
          do {
            /// 플레이리스트의 상세 정보를 요청
            var request = MusicCatalogResourceRequest<Playlist>(matching: \.id, equalTo: MusicItemID(rawValue: req.id))
            request.limit = 25

            let response = try await request.response()

            /// 해당 플레이리스트의 id를 사용하여 트랙 정보를 가져옵니다.
            /// items에 있는 아이템은 하나인데, 배열안에 있기 때문에 첫번째 요소를 가져옴
            guard let playlist = response.items.first else { return }

            /// 트랙 정보를 포함하여 플레이리스트를 업데이트
            let detailedPlaylist = try await playlist.with([.tracks])
            let tracks = detailedPlaylist.tracks ?? []

            let itemList = tracks
              .map {
                MusicEntity.CityTopDetail.Track.Item(
                  id: $0.id.rawValue,
                  title: $0.title,
                  artistName: $0.artistName,
                  artwork: .init(url: $0.artwork?.url(width: 60, height: 60)))
              }

            let result = MusicEntity.CityTopDetail.Track.Response(itemList: itemList)
            return promise(.success(result))

          } catch {
            return promise(.failure(.other(error)))
          }
        }
      }
      .eraseToAnyPublisher()
    }
  }
}
