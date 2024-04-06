//
//  MyFeedsCollectionViewCell.swift
//  PlayVideos
//
//  Created by Rahul Sharma on 11/01/23.
//

import UIKit
import AVKit

class MyFeedsCollectionViewCell: UICollectionViewCell {

    let myVideoView : PlayerView = {
        let myVideo = PlayerView()
        myVideo.translatesAutoresizingMaskIntoConstraints = false
       return myVideo
        
    }()
    
    let feedImage : UIImageView = {
        let myFeedImage = UIImageView()
        myFeedImage.contentMode = .scaleAspectFill
        myFeedImage.backgroundColor = .red
        myFeedImage.translatesAutoresizingMaskIntoConstraints = false
        return myFeedImage
    }()
    
    let playPauseButton : UIButton = {
        let newButton = UIButton()
        newButton.backgroundColor = .blue
        newButton.translatesAutoresizingMaskIntoConstraints = false
        return newButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(feedImage)
        self.addSubview(myVideoView)
        self.addSubview(playPauseButton)
        
        feedImage.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        myVideoView.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        playPauseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        playPauseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

     
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.myVideoView.player = nil
        self.feedImage.image = UIImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
