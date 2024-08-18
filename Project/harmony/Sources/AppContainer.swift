import Architecture
import Foundation
import LinkNavigator
import Platform

// MARK: - AppContainer

final class AppContainer {

  // MARK: Lifecycle

  private init(dependency: AppSideEffect, navigator: TabLinkNavigator) {
    self.dependency = dependency
    self.navigator = navigator
  }

  // MARK: Internal

  let dependency: AppSideEffect
  let navigator: TabLinkNavigator
}

extension AppContainer {
  class func build() -> AppContainer {
    let sideEffect = AppSideEffect(
      toastViewModel: ToastViewModel(),
      musicUseCase: MusicUseCasePlatform(),
      cityTopDetailUseCase: CityTopDetailUseCasePlatform(),
      dailyTopDetailUseCase: DailyTopDetailUseCasePlatform(),
      playListDetailUseCase: PlayListDetailUseCasePlatform(),
      albumDetailUseCase: AlbumDetailUseCasePlatform(),
      searchUseCase: SearchUseCasePlatform(),
      artistUseCase: ArtistUseCasePlatform())

    return .init(
      dependency: sideEffect,
      navigator: .init(
        routeBuilderItemList: AppRouteBuilderGroup().release,
        dependency: sideEffect))
  }
}
