//
//  VideoGuidePlayViewController.swift
//  DOC
//
//  Created by Po Hsiang Huang on 5/21/19.
//  Copyright © 2019 Po Hsiang Huang. All rights reserved.
//

import UIKit
import WebKit

class VideoGuidePlayViewController: UIViewController, WKUIDelegate{
    
    var video: Video = Video()
    
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTitle.text = video.Title
        getVideo(videoKey: video.Key)
    }
    
    func getVideo(videoKey: String) {
        let myUrl = URL(string: "https://www.youtube.com/embed/\(videoKey)?autoplay=1&modestbranding=1")
        let request = URLRequest(url: myUrl!)
        videoWebView.load(request)
    }

}
