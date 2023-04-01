//
//  ChatWindowContentViewModel.swift
//  CamelChat
//
//  Created by Alex Rozanski on 01/04/2023.
//

import Foundation

class ChatWindowContentViewModel: ObservableObject {
  enum RestorableKey: String {
    case sidebarWidth
  }

  private let chatSources: ChatSources
  private let restorableData: any RestorableData<RestorableKey>

  @Published var sidebarWidth: Double? {
    didSet {
      restorableData.set(value: sidebarWidth, for: .sidebarWidth)
    }
  }

  lazy private(set) var chatSourcesViewModel = ChatSourcesViewModel(chatSources: chatSources)

  init(chatSources: ChatSources, stateRestoration: StateRestoration) {
    self.chatSources = chatSources
    self.restorableData = stateRestoration.restorableData(for: "ChatWindow")
    _sidebarWidth = Published(initialValue: restorableData.getValue(for: .sidebarWidth))
  }
}