import Architecture
import Dashboard
import Domain
import Foundation
import LinkNavigator
import Platform

// MARK: - AppSideEffect

struct AppSideEffect: DependencyType, DashboardEnvironmentUsable {
  let toastViewModel: ToastViewActionType
  let musicUseCase: MusicUseCase
  let cityTopDetailUseCase: CityTopDetailUseCase
  let dailyTopDetailUseCase: DailyTopDetailUseCase
  let topPlayListDetailUseCase: TopPlayListDetailUseCase
  let albumDetailUseCase: AlbumDetailUseCase
  let searchUseCase: SearchUseCase
  let artistUseCase: ArtistUseCase
}
