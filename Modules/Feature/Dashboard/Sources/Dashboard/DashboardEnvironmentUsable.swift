import Architecture
import Domain

public protocol DashboardEnvironmentUsable {
  var toastViewModel: ToastViewActionType { get }
  var musicUseCase: MusicUseCase { get }
  var cityTopDetailUseCase: CityTopDetailUseCase { get }
  var dailyTopDetailUseCase: DailyTopDetailUseCase { get }
  var topPlayListDetailUseCase: TopPlayListDetailUseCase { get }
  var albumDetailUseCase: AlbumDetailUseCase { get }
  var searchUseCase: SearchUseCase { get }
}
