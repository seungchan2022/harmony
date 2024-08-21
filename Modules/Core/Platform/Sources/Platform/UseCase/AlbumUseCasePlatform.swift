import Combine
import Domain
import MusicKit

// MARK: - AlbumUseCasePlatform

public struct AlbumUseCasePlatform {
  public init() { }
}

// MARK: AlbumUseCase

extension AlbumUseCasePlatform: AlbumUseCase {
  public var fullAlbum: (MusicEntity.Album.FullAlbum.Request) -> AnyPublisher<
    MusicEntity.Album.FullAlbum.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.Album.FullAlbum.Response, CompositeErrorRepository> { promise in

        Task {
          do {
            let request = MusicCatalogResourceRequest<Artist>(matching: \.id, equalTo: MusicItemID(rawValue: req.id))

            let response = try await request.response()

            guard let artist = response.items.first else { return }

            let artistWithFullAlbum = try await artist.with([.fullAlbums])

            var fullAlbumList = artistWithFullAlbum.fullAlbums ?? []

            var allFullAlbumList = Array(fullAlbumList)

            while fullAlbumList.hasNextBatch {
              if let nextBatch = try? await fullAlbumList.nextBatch(limit: 10) {
                allFullAlbumList = allFullAlbumList + nextBatch
                fullAlbumList = nextBatch
              } else {
                break
              }
            }

            let itemList = allFullAlbumList
              .map {
                MusicEntity.Album.FullAlbum.Item(
                  id: $0.id.rawValue,
                  title: $0.title,
                  artistName: $0.artistName,
                  releaseDate: $0.releaseDate ?? .now,
                  artwork: .init(url: $0.artwork?.url(width: 180, height: 180)))
              }

            let result = MusicEntity.Album.FullAlbum.Response(
              id: artist.id.rawValue,
              itemList: itemList)

            return promise(.success(result))

          } catch {
            return promise(.failure(.other(error)))
          }
        }
      }
      .eraseToAnyPublisher()
    }
  }

  public var singleAlbum: (MusicEntity.Album.SingleAlbum.Request) -> AnyPublisher<
    MusicEntity.Album.SingleAlbum.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.Album.SingleAlbum.Response, CompositeErrorRepository> { promise in

        Task {
          do {
            let request = MusicCatalogResourceRequest<Artist>(matching: \.id, equalTo: MusicItemID(rawValue: req.id))

            let response = try await request.response()

            guard let artist = response.items.first else { return }

            let artistWithSingleAlbum = try await artist.with([.singles])

            var singAlbumList = artistWithSingleAlbum.singles ?? []

            var allSingleAlbumList = Array(singAlbumList)

            while singAlbumList.hasNextBatch {
              if let nextBatch = try? await singAlbumList.nextBatch(limit: 10) {
                allSingleAlbumList = allSingleAlbumList + nextBatch
                singAlbumList = nextBatch
              } else {
                break
              }
            }

            let itemList = allSingleAlbumList
              .map {
                MusicEntity.Album.SingleAlbum.Item(
                  id: $0.id.rawValue,
                  title: $0.title,
                  artistName: $0.artistName,
                  releaseDate: $0.releaseDate ?? .now,
                  artwork: .init(url: $0.artwork?.url(width: 180, height: 180)))
              }

            let result = MusicEntity.Album.SingleAlbum.Response(
              id: artist.id.rawValue,
              itemList: itemList)

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
