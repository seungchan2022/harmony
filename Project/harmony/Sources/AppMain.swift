import Architecture
import LinkNavigator
import SwiftUI

// MARK: - AppMain

struct AppMain {
  let viewModel: AppViewModel
}

// MARK: View

extension AppMain: View {

  var body: some View {
    TabLinkNavigationView(
      linkNavigator: viewModel.linkNavigator,
      isHiddenDefaultTabbar: false,
      tabItemList: [
        .init(
          tag: .zero,
          tabItem: .init(
            title: "home",
            image: UIImage(systemName: "house.fill"),
            tag: .zero),
          linkItem: .init(path: Link.Dashboard.Path.home.rawValue), prefersLargeTitles: true),
        .init(
          tag: 1,
          tabItem: .init(
            title: "search",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 1),
          linkItem: .init(path: Link.Dashboard.Path.search.rawValue), prefersLargeTitles: true),
        .init(
          tag: 2,
          tabItem: .init(
            title: "artist",
            image: UIImage(systemName: "person"),
            tag: 2),
          linkItem: .init(path: Link.Dashboard.Path.artist.rawValue), prefersLargeTitles: true),
      ])
      .ignoresSafeArea()
      .onAppear {
        viewModel.linkNavigator.moveTab(targetPath: Link.Dashboard.Path.search.rawValue)
      }
  }
}
