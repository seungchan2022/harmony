import Combine
import Domain
import MusicKit

// MARK: - MusicSearchUseCasePlatform

public struct MusicSearchUseCasePlatform {
  public init() { }
}

// MARK: MusicSearchUseCase

extension MusicSearchUseCasePlatform: MusicSearchUseCase {
  public var song: (MusicEntity.Search.Song.Request) -> AnyPublisher<MusicEntity.Search.Song.Response, CompositeErrorRepository> {
    { req in
      Future<MusicEntity.Search.Song.Response, CompositeErrorRepository> { promise in
        Task {
          do {
            var request = MusicCatalogSearchRequest(
              term: req.query,
              types: [Song.self])

            request.limit = 5
            request.offset = .zero

            let response = try await request.response()

            let itemList = response
              .songs
              .map { MusicEntity.Search.Song.Item(
                id: $0.id.rawValue,
                title: $0.title,
                artistName: $0.artistName,
                artwork: .init(
                  url: $0.artwork?.url(width: 60, height: 60))) }

            let result = MusicEntity.Search.Song.Response(itemList: itemList)
            return promise(.success(result))

          } catch {
            return promise(.failure(.other(error)))
          }
        }
      }
      .eraseToAnyPublisher()
    }
  }

  public var artist: (MusicEntity.Search.Artist.Request) -> AnyPublisher<
    MusicEntity.Search.Artist.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.Search.Artist.Response, CompositeErrorRepository> { promise in
        Task {
          do {
            var request = MusicCatalogSearchRequest(
              term: req.query,
              types: [Artist.self])

            request.limit = 5
            request.offset = .zero

            let response = try await request.response()

            let itemList = response
              .artists
              .map {
                MusicEntity.Search.Artist.Item(
                  id: $0.id.rawValue,
                  name: $0.name,
                  artwork: .init(url: $0.artwork?.url(width: 60, height: 60)))
              }

            let result = MusicEntity.Search.Artist.Response(itemList: itemList)
            return promise(.success(result))

          } catch {
            return promise(.failure(.other(error)))
          }
        }
      }
      .eraseToAnyPublisher()
    }
  }

  public var album: (MusicEntity.Search.Album.Request) -> AnyPublisher<
    MusicEntity.Search.Album.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.Search.Album.Response, CompositeErrorRepository> { promise in
        Task {
          do {
            var request = MusicCatalogSearchRequest(
              term: req.query,
              types: [Album.self])

            request.limit = 3
            request.offset = .zero

            let response = try await request.response()

            let itemList = response
              .albums
              .map {
                MusicEntity.Search.Album.Item(
                  id: $0.id.rawValue,
                  title: $0.title,
                  artistName: $0.artistName,
                  artwork: .init(url: $0.artwork?.url(width: 60, height: 60)))
              }

            let result = MusicEntity.Search.Album.Response(itemList: itemList)

            return promise(.success(result))

          } catch {
            return promise(.failure(.other(error)))
          }
        }
      }
      .eraseToAnyPublisher()
    }
  }

  public var topResult: (MusicEntity.Search.TopResult.Request) -> AnyPublisher<
    MusicEntity.Search.TopResult.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.Search.TopResult.Response, CompositeErrorRepository> { promise in
        Task {
          do {
            var request = MusicCatalogSearchRequest(
              term: req.query,
              types: [Album.self, Artist.self, Song.self])

            request.limit = 10
            request.offset = .zero
            request.includeTopResults = true

            let response = try await request.response()

            let itemList = response.topResults.compactMap { result in
              switch result {
              case .album(let album):
                return MusicEntity.Search.TopResult.Item(
                  id: album.id.rawValue,
                  title: album.title,
                  artistName: album.artistName,
                  name: .none,
                  artwork: .init(url: album.artwork?.url(width: 60, height: 60)),
                  itemType: .album)

              case .artist(let artist):
                return MusicEntity.Search.TopResult.Item(
                  id: artist.id.rawValue,
                  title: .none,
                  artistName: .none,
                  name: artist.name,
                  artwork: .init(url: artist.artwork?.url(width: 60, height: 60)),
                  itemType: .artist)

              case .song(let song):
                return MusicEntity.Search.TopResult.Item(
                  id: song.id.rawValue,
                  title: song.title,
                  artistName: song.artistName,
                  name: .none,
                  artwork: .init(url: song.artwork?.url(width: 60, height: 60)),
                  itemType: .song)

              default:
                return .none
              }
            }

            promise(.success(MusicEntity.Search.TopResult.Response(itemList: itemList)))
          } catch {
            promise(.failure(.other(error)))
          }
        }
      }
      .eraseToAnyPublisher()
    }
  }

  public var keyword: (MusicEntity.Search.Keyword.Request) -> AnyPublisher<
    MusicEntity.Search.Keyword.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.Search.Keyword.Response, CompositeErrorRepository> { promise in
        Task {
          do {
            var request = MusicCatalogSearchSuggestionsRequest(
              term: req.query)

            request.limit = 3

            let response = try await request.response()

            let itemList = response
              .suggestions
              .map {
                MusicEntity.Search.Keyword.Item(
                  id: $0.id,
                  displayTerm: $0.displayTerm,
                  searchTerm: $0.searchTerm)
              }

            let result = MusicEntity.Search.Keyword.Response(itemList: itemList)

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
