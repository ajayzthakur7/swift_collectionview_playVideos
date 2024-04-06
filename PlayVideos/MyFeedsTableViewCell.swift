//
//  MyFeedsTableViewCell.swift
//  PlayVideos
//
//  Created by Rahul Sharma on 11/01/23.
//

import UIKit
import AVKit

import UIKit

class MyFeedsTableViewCell: UITableViewCell {
    
    private var myFeedsCollectionView: UICollectionView?
    private var collectionViewLayout: UICollectionViewFlowLayout!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = false;
        self.selectionStyle = .none
        self.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.collectionViewLayout.scrollDirection = .horizontal
        let frame = CGRect(x: 0.0, y: 0.0, width: self.frame.width , height: 300)
        self.myFeedsCollectionView = UICollectionView(frame: frame, collectionViewLayout: self.collectionViewLayout)
        self.myFeedsCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.myFeedsCollectionView!)
        self.myFeedsCollectionView?.isScrollEnabled = true
        self.myFeedsCollectionView?.isPagingEnabled = true
        self.myFeedsCollectionView?.showsVerticalScrollIndicator = false
        self.myFeedsCollectionView?.showsHorizontalScrollIndicator = false
        
        self.myFeedsCollectionView?.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        self.myFeedsCollectionView?.dataSource = self
        self.myFeedsCollectionView?.delegate = self
        myFeedsCollectionView?.register(MyFeedsCollectionViewCell.self, forCellWithReuseIdentifier: "MyFeedsCollectionViewCell")
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var videoUrls : [String] = [
        "https://res.cloudinary.com/dxepownu9/video/upload/v1672305619/ReSaree/1672305616400.707.mov",
        "https://res.cloudinary.com/dxepownu9/image/upload/v1670767240/ReSaree/nltd4fviiidne3r764gb.jpg",
        "https://res.cloudinary.com/dxepownu9/video/upload/v1670767442/ReSaree/1670767438900.348.mov",
        "https://res.cloudinary.com/dxepownu9/video/upload/v1670767242/ReSaree/1670767238155.4219.mov",
        "https://res.cloudinary.com/dmtqdysqr/video/upload/v1649659577/1649659570640.2932.mov",
        "https://res.cloudinary.com/dxepownu9/video/upload/v1672305560/ReSaree/1672305556038.844.mov",
        "https://res.cloudinary.com/dxepownu9/image/upload/v1670767441/ReSaree/sxwourunqkea7nmavlyd.jpg",
        "https://res.cloudinary.com/dxepownu9/image/upload/v1670767441/ReSaree/ankv9bnysl0e8vsikqs8.jpg"]
    
    var updateVideoPlayer: ((AVPlayer)->())?
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension MyFeedsTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        videoUrls.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyFeedsCollectionViewCell", for: indexPath) as! MyFeedsCollectionViewCell
        cell.playPauseButton.tag = indexPath.row
        cell.playPauseButton.addTarget(self, action: #selector(playPauseAction), for: .touchUpInside)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.contentView.frame.width   , height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
     
        stopPreviousPlayingVideo()
        
        if let index = collectionView.indexPathsForVisibleItems.first{
            self.playVideo(collectionView: collectionView, index: index.row )
        }
        
        if let cell = cell as? MyFeedsCollectionViewCell{
            cell.myVideoView.player?.pause()
            cell.myVideoView.player = nil
        }
    }
    
    @objc func playPauseAction(sender: UIButton){
        if sender.isSelected{
            self.stopPreviousPlayingVideo()
        }else{
            self.playVideo(collectionView: self.myFeedsCollectionView!, index: sender.tag )
        }
    }
    
    
    func stopPreviousPlayingVideo(){
        if let myTableView = self.superview as? UITableView {
            _ = myTableView.visibleCells.map { cell in
                if let myCell = cell as? MyFeedsTableViewCell, let myVideoCell = myCell.myFeedsCollectionView?.visibleCells.first as? MyFeedsCollectionViewCell{
                    myVideoCell.playPauseButton.isSelected = false
                    myVideoCell.myVideoView.player?.pause()
                    myVideoCell.myVideoView.player = nil
                }
            }
        }
    }
    
    
    func playVideo(collectionView : UICollectionView,index : Int ){
        self.stopPreviousPlayingVideo()
        if let cell = collectionView.visibleCells.first as? MyFeedsCollectionViewCell{
            let avplayer = AVPlayer(url: URL(string:videoUrls[index])!)
            cell.playPauseButton.isSelected = true
            cell.myVideoView.playerLayer.player = avplayer
            cell.myVideoView.playerLayer.frame = cell.myVideoView.layer.bounds
            cell.myVideoView.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            avplayer.playImmediately(atRate: 1)
            self.updateVideoPlayer!(avplayer)
            
            
            // Show image from thumbnail
              let asset = AVURLAsset(url: URL(string:videoUrls[index])!)
              let generator = AVAssetImageGenerator(asset: asset)
              generator.appliesPreferredTrackTransform = true
              let timestamp = CMTime(seconds: 1, preferredTimescale: 60)
              do {
                  let imageRef = try generator.copyCGImage(at: timestamp, actualTime: nil)
                  cell.feedImage.image =  UIImage(cgImage: imageRef)
              }
              catch let error as NSError
              {
                  print("Image generation failed with error \(error)")
                  cell.feedImage.image = UIImage()
              }
        }
    }
    
    
    
}

