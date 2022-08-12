//
//  VideoViewController.swift
//  FinalProject
//
//  Created by Dung Nguyen T.T. [3] VN.Danang on 8/11/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

final class VideoViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var playerVideoView: WKYTPlayerView!

    // MARK: - Properties
    var viewModel: VideoViewModel?

    // MARK: - Lice cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        playerVideoView.stopVideo()
    }

    // MARK: - Private functions
    private func setupData() {
        guard let viewModel = viewModel else { return }
        let urlArr = viewModel.url.components(separatedBy: "v=")
        if urlArr != [""] {
            let videoId: String = urlArr[1]
            playerVideoView.load(withVideoId: videoId, playerVars: ["playsinline": "1"])
            playerVideoView.delegate = self
        } else {
            return
        }
    }
}

// MARK: - WKYTPlayerViewDelegate
extension VideoViewController: WKYTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: WKYTPlayerView) {
        playerView.playVideo()
    }
}
