//
//  VideoGuideViewController.swift
//  DOC
//
//  Created by Po Hsiang Huang on 5/19/19.
//  Copyright © 2019 Po Hsiang Huang. All rights reserved.
//

import UIKit

class VideoGuideViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var videos:[Video] = []
    var video: Video = Video()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let video1 = Video()
        video1.Key = "cxHpFWKIfGw"
        video1.Title = "Approach to the Exam for Parkinson's Disease"
        videos.append(video1)
        
        let video2 = Video()
        video2.Key = "4qdD4Ny34cc"
        video2.Title = "Movement signs and symptoms of Parkinson's disease"
        videos.append(video2)
        
        let video3 = Video()
        video3.Key = "3I2zhkX_olc"
        video3.Title = "Medical School - Parkinson's Disease"
        videos.append(video3)
        
        let video4 = Video()
        video4.Key = "j86omOwx0Hk"
        video4.Title = "Parkinsonian Gait Demonstration"
        videos.append(video4)
        
        let video5 = Video()
        video5.Key = "9J4LD9pQsoQ"
        video5.Title = "Picking up on Parkinson’s"
        videos.append(video5)
        
        let video6 = Video()
        video6.Key = "ikY9WpmekRY"
        video6.Title = "Exercise And Parkinson's Disease"
        videos.append(video6)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VideoGuideTableViewCell
        
        cell.videoTitle.text = videos[indexPath.row].Title
        let url = "https://img.youtube.com/vi/\(videos[indexPath.row].Key)/0.jpg"
        cell.videoImage.downloaded(from: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vi = videos[indexPath.row]
        self.video = vi
        performSegue(withIdentifier: "PlayVideo", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlayVideo" {
            let vc = segue.destination as! VideoGuidePlayViewController
            vc.video = self.video
        }
    }
}

class Video {
    var Key: String = ""
    var Title: String = ""
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
            let data = data, error == nil,
            let image = UIImage(data: data)
                else {return}
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else {return}
        downloaded(from: url, contentMode: mode)
    }
}
