import Architecture
import Combine
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - ArtistSideEffect

struct ArtistSideEffect {
  let useCase: DashboardEnvironmentUsable
  let main: AnySchedulerOf<DispatchQueue>
  let navigator: RootNavigatorType

  init(
    useCase: DashboardEnvironmentUsable,
    main: AnySchedulerOf<DispatchQueue> = .main,
    navigator: RootNavigatorType)
  {
    self.useCase = useCase
    self.main = main
    self.navigator = navigator
  }
}

extension ArtistSideEffect {
  var getTopSongItem: (MusicEntity.Artist.TopSong.Request) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .topSong(item)
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchTopSongItem)
      }
    }
  }

  var getEssentialAlbumItem: (MusicEntity.Artist.EssentialAlbum.Request) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .essentialAlbum(item)
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchEssentialAlbumItem)
      }
    }
  }

  var getFullAlbumItem: (MusicEntity.Artist.FullAlbum.Request) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .fullAlbum(item)
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchFullAlbumItem)
      }
    }
  }

  var getMusicVideoItem: (MusicEntity.Artist.MusicVideo.Request) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .musicVideo(item)
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchMusicVideoItem)
      }
    }
  }

  var getPlayListItem: (MusicEntity.Artist.PlayList.Request) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .playList(item)
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchPlayListItem)
      }
    }
  }

  var getSingleItem: (MusicEntity.Artist.Single.Request) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .single(item)
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchSingleItem)
      }
    }
  }

  var getSimilarArtistItem: (MusicEntity.Artist.SimilarArtist.Request) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .similarArtist(item)
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchSimilarArtistItem)
      }
    }
  }
}
