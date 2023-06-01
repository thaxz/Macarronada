//
//  ChallengeMacarronadaApp.swift
//  ChallengeMacarronada
//
//  Created by thaxz on 23/05/23.
//

import SwiftUI

@main
struct ChallengeMacarronadaApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @StateObject private var viewModel = PersistentStore()
    
    init(){
        NotificationManager.shared.requestAuthorization()
        NotificationManager.shared.scheduleNotification(
            title: "Bom dia!",
            subtitle: "Vamos começar as atividades?",
            hour: 8,
            minute: 0,
            imageName: "1")
        NotificationManager.shared.scheduleNotification(
            title: "Show!",
            subtitle: "Bom almoço, aproveite o descanso e até já :)",
            hour: 12,
            minute: 0,
            imageName: "2")
        NotificationManager.shared.scheduleNotification(
            title: "Massa!",
            subtitle: "Boa noite, lembre-se de descansar e até amanhã!",
            hour: 18,
            minute: 04,
            imageName: "3")
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
                .frame(width: 390, height: 624)
        }
    }
    
    class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
        
        private var statusItem: NSStatusItem!
        private var popover: NSPopover!
        //        private var vm: HomeViewModel!
        
        
        @MainActor
        func applicationDidFinishLaunching(_ notification: Notification) {
            
            statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
            //            self.vm = HomeViewModel()
            
            if let statusButton = statusItem.button {
                statusButton.image = NSImage(systemSymbolName: "bell.fill", accessibilityDescription: "Heart")
                statusButton.action = #selector(togglePopover)
            }
            
            self.popover = NSPopover()
            self.popover.contentSize = NSSize(width: 390, height: 624)
            self.popover.behavior = .transient
            self.popover.contentViewController = NSHostingController(rootView: HomeView().environmentObject(PersistentStore()))
            
        }
        
        @objc func togglePopover(){
            Task {
                //await self.vm.populateTasks()
            }
            if let button = statusItem.button {
                if popover.isShown {
                    self.popover.performClose(nil)
                } else {
                    popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
                }
            }
        }
        
    }
    
}
