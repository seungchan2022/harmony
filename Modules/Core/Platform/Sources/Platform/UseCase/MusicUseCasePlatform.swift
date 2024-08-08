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
  public var mostPlayedSong: (MusicEntity.Chart.MostPlayedSong.Request) -> AnyPublisher<
    MusicEntity.Chart.MostPlayedSong.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.Chart.MostPlayedSong.Response, CompositeErrorRepository> { promise in
        Task {
          let status = await MusicAuthorization.request()

          switch status {
          case .notDetermined:
            print("noeDetermined")

          case .denied:
            print("denied")

          case .restricted:
            print("restricted")

          case .authorized:
            do {
              /// kinds의 디폴트 값은 .mostPlayed
              var request = MusicCatalogChartsRequest(
                genre: .none,
                kinds: [.mostPlayed],
                types: [Song.self])

              /// 보여줄 아이템 갯수
              request.limit = req.limit
              // 몇 번재 아이템 부터 보여줄것인가
              request.offset = .zero

              /// MusicCatalogChartsResponse
              let response = try await request.response()

              let itemList = response
                .songCharts
                .flatMap { $0.items }
                .map {
                  MusicEntity.Chart.MostPlayedSong.Item(
                    id: $0.id.rawValue,
                    title: $0.title,
                    artistName: $0.artistName,
                    artwork: .init(
                      url: $0.artwork?.url(width: 60, height: 60)))
                }

              let chartResponse = MusicEntity.Chart.MostPlayedSong.Response(itemList: itemList)

              return promise(.success(chartResponse))

            } catch {
              return promise(.failure(.other(error)))
            }

          @unknown default:
            print("error")
          }
        }
      }
      .eraseToAnyPublisher()
    }
  }

  public var cityTop: (MusicEntity.Chart.CityTop.Request) -> AnyPublisher<
    MusicEntity.Chart.CityTop.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.Chart.CityTop.Response, CompositeErrorRepository> { promise in
        Task {
          let status = await MusicAuthorization.request()

          switch status {
          case .notDetermined:

            print("noeDetermined")

          case .denied:
            print("denied")

          case .restricted:
            print("restricted")

          case .authorized:
            do {
              var request = MusicCatalogChartsRequest(
                genre: .none,
                kinds: [.cityTop],
                types: [Playlist.self])

              request.limit = req.limit
              request.offset = .zero
//              print(request)

              let response = try await request.response()
//              print(response.debugDescription)

              let itemList = response
                .playlistCharts
                /// request에 위와 같이 파라미터를 전달하면, "City Charts"와 "Top Playlists" 둘다 불려서 아이템 리스트에 두 결과가 모두 들어가게됌 (내가 원하는 결과는 20개 인데 합쳐지므로 40개가 아이템 리스트에 담김)
                /// 따라서 필터링으로 "City Charts"에 대한 아이템만 담도록
                .filter { $0.title == "City Charts" }
                .flatMap { $0.items }
                .map {
                  MusicEntity.Chart.CityTop.Item(
                    id: $0.id.rawValue,
                    name: $0.name,
                    curatorName: $0.curatorName ?? "",
                    artwork: .init(
                      url: $0.artwork?.url(width: 180, height: 180)))
                }

              let chartResponse = MusicEntity.Chart.CityTop.Response(itemList: itemList)

              return promise(.success(chartResponse))

            } catch {
              return promise(.failure(.other(error)))
            }

          @unknown default:
            print("error")
          }
        }
      }
      .eraseToAnyPublisher()
    }
  }

  public var dailyTop: (MusicEntity.Chart.DailyTop.Request) -> AnyPublisher<
    MusicEntity.Chart.DailyTop.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.Chart.DailyTop.Response, CompositeErrorRepository> { promise in
        Task {
          let status = await MusicAuthorization.request()

          switch status {
          case .notDetermined:
            print("noeDetermined")

          case .denied:
            print("denied")

          case .restricted:
            print("restricted")

          case .authorized:
            do {
              var request = MusicCatalogChartsRequest(
                genre: .none,
                kinds: [.dailyGlobalTop],
                types: [Playlist.self])

              request.limit = req.limit
              request.offset = .zero

              let response = try await request.response()

              let itemList = response
                .playlistCharts
                .filter { $0.title == "Daily Top 100" }
                .flatMap { $0.items }
                .map {
                  MusicEntity.Chart.DailyTop.Item(
                    id: $0.id.rawValue,
                    name: $0.name,
                    curatorName: $0.curatorName ?? "",
                    artwork: .init(
                      url: $0.artwork?.url(width: 180, height: 180)))
                }

              let chartResponse = MusicEntity.Chart.DailyTop.Response(itemList: itemList)

              return promise(.success(chartResponse))

            } catch {
              return promise(.failure(.other(error)))
            }

          @unknown default:
            print("error")
          }
        }
      }
      .eraseToAnyPublisher()
    }
  }

  public var topPlayList: (MusicEntity.Chart.TopPlayList.Request) -> AnyPublisher<
    MusicEntity.Chart.TopPlayList.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.Chart.TopPlayList.Response, CompositeErrorRepository> { promise in
        Task {
          let status = await MusicAuthorization.request()

          switch status {
          case .notDetermined:
            print("noeDetermined")

          case .denied:
            print("denied")

          case .restricted:
            print("restricted")

          case .authorized:
            do {
              var request = MusicCatalogChartsRequest(
                genre: .none,
                kinds: [.mostPlayed],
                types: [Playlist.self])

              request.limit = req.limit
              request.offset = .zero

              let response = try await request.response()

              let itemList = response
                .playlistCharts
                .filter { $0.title == "Top Playlists" }
                .flatMap { $0.items }
                .map {
                  MusicEntity.Chart.TopPlayList.Item(
                    id: $0.id.rawValue,
                    name: $0.name,
                    curatorName: $0.curatorName ?? "",
                    artwork: .init(
                      url: $0.artwork?.url(width: 180, height: 180)))
                }

              let chartResponse = MusicEntity.Chart.TopPlayList.Response(itemList: itemList)

              return promise(.success(chartResponse))

            } catch {
              return promise(.failure(.other(error)))
            }

          @unknown default:
            print("error")
          }
        }
      }
      .eraseToAnyPublisher()
    }
  }

  public var topAlbum: (MusicEntity.Chart.TopAlbum.Request) -> AnyPublisher<
    MusicEntity.Chart.TopAlbum.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.Chart.TopAlbum.Response, CompositeErrorRepository> { promise in
        Task {
          let status = await MusicAuthorization.request()

          switch status {
          case .notDetermined:
            print("noeDetermined")

          case .denied:
            print("denied")

          case .restricted:
            print("restricted")

          case .authorized:
            do {
              var request = MusicCatalogChartsRequest(
                genre: .none,
                kinds: [.mostPlayed],
                types: [Album.self])

              request.limit = req.limit
              request.offset = .zero

              let response = try await request.response()

              let itemList = response
                .albumCharts
                .flatMap { $0.items }
                .map {
                  MusicEntity.Chart.TopAlbum.Item(
                    id: $0.id.rawValue,
                    title: $0.title,
                    artistName: $0.artistName,
                    artwork: .init(url: $0.artwork?.url(width: 180, height: 180)))
                }

              let chartResponse = MusicEntity.Chart.TopAlbum.Response(itemList: itemList)

              return promise(.success(chartResponse))

            } catch {
              return promise(.failure(.other(error)))
            }

          @unknown default:
            print("error")
          }
        }
      }
      .eraseToAnyPublisher()
    }
  }

  public var topMusicVideo: (MusicEntity.Chart.TopMusicVideo.Request) -> AnyPublisher<
    MusicEntity.Chart.TopMusicVideo.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.Chart.TopMusicVideo.Response, CompositeErrorRepository> { promise in
        Task {
          let status = await MusicAuthorization.request()

          switch status {
          case .notDetermined:
            print("noeDetermined")

          case .denied:
            print("denied")

          case .restricted:
            print("restricted")

          case .authorized:
            do {
              var request = MusicCatalogChartsRequest(
                genre: .none,
                kinds: [.mostPlayed],
                types: [MusicVideo.self])

              request.limit = req.limit
              request.offset = .zero

              let response = try await request.response()

              let itemList = response
                .musicVideoCharts
                .flatMap { $0.items }
                .map {
                  MusicEntity.Chart.TopMusicVideo.Item(
                    id: $0.id.rawValue,
                    title: $0.title,
                    artistName: $0.artistName,
                    artwork: .init(url: $0.artwork?.url(width: 180, height: 180)))
                }

              let chartResponse = MusicEntity.Chart.TopMusicVideo.Response(itemList: itemList)

              return promise(.success(chartResponse))

            } catch {
              return promise(.failure(.other(error)))
            }

          @unknown default:
            print("error")
          }
        }
      }
      .eraseToAnyPublisher()
    }
  }
}
