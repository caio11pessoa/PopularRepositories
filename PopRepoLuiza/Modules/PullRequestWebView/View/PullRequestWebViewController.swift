//
//  PullRequestWebViewController.swift
//  PopRepoLuiza
//
//  Created by Caio de Almeida Pessoa on 11/08/25.
//

import UIKit
import WebKit

class PullRequestWebViewController: AbstractViewController {
    var viewModel: PullRequestWVViewModel = PullRequestWVViewModel()
    lazy private var webView: WKWebView = {
        var webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupWebView()
        viewModel.setupLoadingBindings(loadingIndicator: loadingIndicator)
        viewModel.webViewWithErrorBindings(viewController: self)
        loadRequest()
    }
    
    private func setupWebView() {
        
        view.addSubview(webView)
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadRequest() {
        guard let request = viewModel.makeRequest() else {
            return
        }
        webView.load(request)
    }
}

extension PullRequestWebViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        viewModel.isLoading.accept(true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        viewModel.isLoading.accept(false)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        viewModel.isLoading.accept(false)
        viewModel.viewWithError.accept(true)
    }
}
