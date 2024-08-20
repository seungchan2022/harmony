import DesignSystem
import Domain
import SwiftUI

// MARK: - ArtistPage.InfoComponent

extension ArtistPage {
  struct InfoComponent {
    let viewState: ViewState
  }
}

extension ArtistPage.InfoComponent { }

// MARK: - ArtistPage.InfoComponent + View

extension ArtistPage.InfoComponent: View {
  var body: some View {
    RemoteImage(url: viewState.item.artwork.url?.absoluteString ?? "") {
      Rectangle()
        .fill(.gray.opacity(0.3))
        .scaledToFill()
        .frame(height: 400)
        .frame(maxWidth: .infinity)
    }
    .scaledToFill()
    .frame(height: 400)
    .frame(maxWidth: .infinity)
    .overlay(
      Rectangle()
        .fill(Color.black.opacity(0.1))
        .ignoresSafeArea(.all, edges: [.top, .bottom]))
    .overlay(alignment: .bottomLeading) {
      Text(viewState.item.artistName)
        .font(.title)
        .fontWeight(.bold)
        .foregroundStyle(.white)
        .padding(.leading, 16)
    }
  }
}

// MARK: - ArtistPage.InfoComponent.ViewState

extension ArtistPage.InfoComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Artist.TopSong.Response
  }
}
