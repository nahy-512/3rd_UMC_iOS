//
//  ReelsXibCollectionViewCell.swift
//  Instagram
//
//  Created by 김나현 on 2022/10/29.
//

import UIKit
import AVKit
import AVFoundation
import MarqueeLabel

class ReelsXibCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var reelsContentLabel: UILabel!
    @IBOutlet weak var reelsMusicLabel: MarqueeLabel!
    @IBOutlet weak var heartNumLabel: UILabel!
    @IBOutlet weak var commentNumLabel: UILabel!
    
    @IBOutlet weak var followBackgroundView: UIView!
    @IBOutlet weak var nextProfileImageView: UIImageView!
    
    // Video Player
    @IBOutlet weak var playerView: VideoPlayerViewClass!
    
    //    var videoUrl : URL?
    var videoUrl: URL? {
        didSet {
            print("cocoa", videoUrl)
        }
    }
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        setViewDetail()
    }
    
    
    
    //    override func layoutSubviews() {
    //        super.layoutSubviews()
    //
    //        playerView.playerLayer.frame = UIScreen.main.bounds
    //    }
    
    
    // MARK: - Functions
    func setPlayerView() {
        guard let videoUrl = videoUrl else {
            print("cocoa2 fail")
            return }
        
        self.playerView = VideoPlayerViewClass(frame: UIScreen.main.bounds , videoUrl: videoUrl)
    }
    
    func setViewDetail() {
        
        // 팔로우 배경
        followBackgroundView.layer.cornerRadius = 5
        followBackgroundView.layer.borderWidth = 0.8
        followBackgroundView.layer.borderColor = UIColor.systemGray6.cgColor
        
        // 프로필 이미지 둥글게
        userProfileImageView.contentMode = .scaleAspectFill
        userProfileImageView.clipsToBounds = true
        userProfileImageView.layer.cornerRadius = 20
        
        nextProfileImageView.contentMode = .scaleAspectFill
        nextProfileImageView.clipsToBounds = true
        nextProfileImageView.layer.cornerRadius = 10
        
        reelsMusicLabel.speed = .duration(20)
    }
    
    
}

class VideoPlayerViewClass: UIView {
    
    var quePlayer: AVQueuePlayer?
    var playerLayer: AVPlayerLayer?
    var playerLooper: AVPlayerLooper?
    var videoUrl: URL?
//    {
//        didSet {
//            print("cocoa2_didset", videoUrl)
//        }
//    }
    
    init(frame: CGRect, videoUrl: URL) {
        
        self.videoUrl = videoUrl
        print("cocoa2_init", self.videoUrl)
        super.init(frame: frame)
        print("cocoa2_init2", videoUrl)
        
        let videoAsset = AVURLAsset(url: videoUrl)
        let playerItem = AVPlayerItem(asset: videoAsset)
        print("cocoa2_videoAsset", videoAsset)
        print("cocoa2_playerItem", playerItem)
        
        quePlayer = AVQueuePlayer(playerItem:playerItem)
        playerLayer = AVPlayerLayer(player: quePlayer)
        print("cocoa2_quePlayer", quePlayer)
        print("cocoa2_playerLayer", playerLayer)
        
        
        guard let playerLayer = playerLayer
        else {
            fatalError("Error")
        }
        
        
//        playerLayer.zPosition = -1
        playerLayer.videoGravity = .resizeAspectFill
//        print("cocoa2", quePlayer)
        
        self.layer.addSublayer(playerLayer)
        
        
        playerLooper = AVPlayerLooper(player: quePlayer!, templateItem: playerItem)
        print("cocoa2_playerLooper", playerLooper)
        
//        self.quePlayer?.insert(playerItem, after: playerItem)
        
        self.quePlayer?.play()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.playerLayer?.frame = bounds
    }
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    //    func setVideoPlayer(videoURL: URL) {
    //
    //        let videoAsset = AVURLAsset(url: videoURL)
    //        let playerItem = AVPlayerItem(asset: videoAsset)
    //
    //        player = AVQueuePlayer()
    //        playerLayer = AVPlayerLayer(player: player)
    //
    //        guard let playerLayer = playerLayer
    //        else {
    //            fatalError("Error")
    //        }
    //
    //        layer.addSublayer(playerLayer)
    //        playerLayer.zPosition = -1
    //        playerLayer.videoGravity = .resizeAspectFill
    //
    //
    //        playerLooper = AVPlayerLooper(player: player!, templateItem: playerItem)
    //
    //
    //        self.player?.insert(playerItem, after: nil)
    //
    //        self.player?.play()
    //    }
    //
    @objc
    func playerItemDidReachEnd(notification: Notification) {
        playerLayer?.player?.seek(to: CMTime.zero)
    }
    //
    ////    override static var layerClass: AnyClass {
    ////        return AVPlayerLayer.self
    ////    }
    //
    ////    var playerLayer: AVPlayerLayer { // 뷰의 레이어 변경
    ////        let layer = AVPlayerLayer()
    ////        layer.videoGravity = .resizeAspectFill // 영상 비율 결정
    ////        return layer
    ////    }
    ////
    ////    var player: AVPlayer? {
    ////        get {
    ////            return playerLayer.player
    ////        }
    ////
    ////        set {
    //////            playerLayer.player = newValue
    ////        }
    ////    }
}
