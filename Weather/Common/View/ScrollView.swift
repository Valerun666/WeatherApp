//
//  ScrollView.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 17.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

protocol RefreshableViewModel {
    func refresh()
}

struct ScrollView<Content: View, ViewModel: RefreshableViewModel> : UIViewRepresentable {
    var width : CGFloat
    var height : CGFloat

    let viewModel: ViewModel
    let content: () -> Content

    init(width: CGFloat, height: CGFloat, viewModel: ViewModel, @ViewBuilder content: @escaping () -> Content) {
        self.width = width
        self.height = height
        self.viewModel = viewModel
        self.content = content
    }

    func makeUIView(context: Context) -> UIScrollView {
        let control = UIScrollView()
        control.refreshControl = UIRefreshControl()
        control.refreshControl?.addTarget(context.coordinator,
                                          action: #selector(Coordinator.handleRefreshControl),
                                          for: .valueChanged)

        let childView = UIHostingController(rootView: content())

        childView.view.frame = CGRect(x: 0, y: 0, width: width, height: height)

        control.addSubview(childView.view)
        return control
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }

    class Coordinator: NSObject {
        var viewModel: ViewModel

        init(viewModel: ViewModel) {
            self.viewModel = viewModel
        }

        @objc func handleRefreshControl(sender: UIRefreshControl) {
            sender.endRefreshing()
            viewModel.refresh()
        }
    }
}
