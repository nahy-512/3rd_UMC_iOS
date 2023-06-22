//
//  ReelsViewController.swift
//  Instagram
//
//  Created by 김나현 on 2022/10/26.
//
import UIKit
import AVKit
import AVFoundation

class ReelsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Properties
    @IBOutlet weak var reelsCollectionView: UICollectionView!
    
    
    let reelsDataModel : [ReelsDataModel] = [
        ReelsDataModel(videoURL: Bundle.main.url(forResource: "Bread", withExtension: "mp4")!, profileImg: UIImage(named: "namo"), userName: "cocoa", reelsContent: "일이삼사오육칠팔구십일이삼사오육칠팔구", reelsMusic: "Glass Animals · Heat Waves", heartNum: "5.6만", commentNum: "4"),
        ReelsDataModel(videoURL: Bundle.main.url(forResource: "Sea", withExtension: "mp4")!, profileImg: UIImage(named: "profile"), userName: "profile", reelsContent: "마음이 너무 힘들다", reelsMusic: "Maroon5 · Memories", heartNum: "123", commentNum: "19"),
        ReelsDataModel(videoURL: Bundle.main.url(forResource: "Sunset", withExtension: "mp4")!, profileImg: UIImage(named: "sundae"), userName: "sundae_123", reelsContent: "뚜루루뚜뚜뚜두두예이예이에이에에", reelsMusic: "Em Beihold · Numb Little Bug BugBUgBugBUGBUGGBUUBUUBUBUBUU", heartNum: "24", commentNum: "5"),
    ]
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNib()
        
        reelsCollectionView.delegate = self
        reelsCollectionView.dataSource = self
        
        inputItems()
        
    }
    
    // MARK: - Functions
    private func registerNib() { // Nib 등록
        let nibName = UINib(nibName: "ReelsXibCollectionViewCell", bundle: nil)
        reelsCollectionView.register(nibName, forCellWithReuseIdentifier: "ReelsXibCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reelsDataModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = reelsCollectionView.dequeueReusableCell(withReuseIdentifier: "ReelsXibCollectionViewCell", for: indexPath) as? ReelsXibCollectionViewCell else {
            return UICollectionViewCell() }
        
        // Setting cell's player
        //        cell.playerView.contentMode = .scaleAspectFill
        //        cell.playerView.clipsToBounds = true
        
        //        let videoAsset = AVURLAsset(url: Bundle.main.url(forResource: "Bread", withExtension: "mp4")!)
        
        //        cell.playerLooper?.loopingPlayerItems
        //        cell.playerLooper = AVPlayerLooper(player: player!, templateItem: AVPlayerItem)
        //        cell.playerView.playerLayer.player?.play()
        
        //        cell.player?.insert(AVPlayerItem(asset: videoAsset), after: nil)
        
        
        
        //        cell.playerView.playerLayer?.player = AVQueuePlayer(url: reelsDataModel[indexPath.row].videoURL!)
        
        //        cell.setVideoPlayer(videoURL: reelsDataModel[indexPath.row].videoURL!)
        
        cell.videoUrl = reelsDataModel[indexPath.row].videoURL!
        print("cocoa", reelsDataModel[indexPath.row].videoURL!)
        cell.setPlayerView()
        
        cell.userProfileImageView.image = reelsDataModel[indexPath.row].profileImg
        cell.userNameLabel.text = reelsDataModel[indexPath.row].userName
        cell.reelsContentLabel.text = reelsDataModel[indexPath.row].reelsContent
        cell.reelsMusicLabel.text = reelsDataModel[indexPath.row].reelsMusic
        cell.heartNumLabel.text = reelsDataModel[indexPath.row].heartNum
        cell.commentNumLabel.text = reelsDataModel[indexPath.row].commentNum
        cell.nextProfileImageView.image = reelsDataModel[indexPath.row].profileImg
        
        //        cell.setVideoPlayer(videoURL: reelsDataModel[indexPath.row].videoURL!)
        
        return cell
    }
    
    
    //    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    //        (cell as? ReelsXibCollectionViewCell)?.playerView.quePlayer?.play()
    //        //cell.playerView.playerLayer.player?.play()
    //        //(cell as? ReelsXibCollectionViewCell)?.player?.play()
    //    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ReelsXibCollectionViewCell else {
            return
        }
        cell.playerView?.quePlayer?.pause()
        cell.playerView?.quePlayer?.seek(to: CMTime.zero)
        //        (cell as? ReelsXibCollectionViewCell)?.playerView.playerLayer.player?.pause()
        //        (cell as? ReelsXibCollectionViewCell)?.playerView.playerLayer.player?.seek(to: CMTime.zero)
    }
    
    
    private func inputItems() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 0 // 아이템 사이의 공간 값
        
        layout.scrollDirection = .vertical // 아이템 스크롤 방향
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing) //아이템 상하좌우 사이값 초기화
        layout.minimumLineSpacing = spacing //아이템 라인 사이값 초기화
        layout.minimumInteritemSpacing = spacing //아이템 섹션 사이값 초기화
        
        reelsCollectionView.collectionViewLayout = layout //CollctionView의 Layout 적용
        
        reelsCollectionView.isScrollEnabled = true
        reelsCollectionView.showsVerticalScrollIndicator = false
        reelsCollectionView.backgroundColor = .clear
        reelsCollectionView.clipsToBounds = true
        //        reelsCollectionView.isPagingEnabled = true // 한 페이지의 넓이를 조절할 수 없기 때문
        reelsCollectionView.contentInsetAdjustmentBehavior = .never // 내부적으로 safe area에 의해 가려지는 것을 방지하기 위해 자동으로 inset 조정해주는 것을 비활성화
        reelsCollectionView.decelerationRate = .fast // 스크롤이 빠르게 페이징
        reelsCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension ReelsViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = reelsCollectionView.frame.width
        let height = reelsCollectionView.frame.height
        return CGSize(width: width, height: height)
        
    }
}

struct ReelsDataModel {
    //    let reelsVideo : UIImage?
    let videoURL : URL? //(url: post.fullURL)
    let profileImg : UIImage?
    let userName : String
    let reelsContent : String?
    let reelsMusic : String
    let heartNum : String
    let commentNum : String
}
