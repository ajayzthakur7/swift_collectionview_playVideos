//
//  ViewController.swift
//  PlayVideos
//
//  Created by Rahul Sharma on 11/01/23.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var myFeedsTableView : UITableView!
    var videoPlayer: AVPlayer? = nil
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myFeedsTableView.register(MyFeedsTableViewCell.self,forCellReuseIdentifier: "MyFeedsTableViewCell")
//        myFeedsTableView.register(UINib(nibName: "MyFeedsTableViewCell", bundle: nil), forCellReuseIdentifier: "MyFeedsTableViewCell")
        myFeedsTableView.dataSource = self
        myFeedsTableView.delegate = self
      
    }
    
    
    @IBAction func stopVideoPlayerAction(){
        self.videoPlayer?.pause()
        self.videoPlayer = nil
    }


}


extension ViewController : UITableViewDataSource, UITableViewDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFeedsTableViewCell", for: indexPath) as! MyFeedsTableViewCell
        cell.updateVideoPlayer = { av in
            self.videoPlayer = av
            
        }
     

        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.videoPlayer?.pause()
        self.videoPlayer = nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}


class PlayerView: UIView {

    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }

    var playerLayer: AVPlayerLayer {
    
        return layer as! AVPlayerLayer
    }

    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
    
        set {
            playerLayer.player = newValue
        }
    }
}
