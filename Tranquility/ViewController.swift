//
//  ViewController.swift
//  Tranquility
//
//  Created by Mark Malburg on 11/28/16.
//  Copyright © 2016 Tyler Young and Mark Malburg. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creates the rainfall gif in the background. Code borrowed from "GIF-Swift" iOSDevCenters on 12/08/16
        let rainfallGif = UIImage.gifImageWithName("rainfall")
        let imageView = UIImageView(image: rainfallGif)
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.insertSubview(imageView, at: 0)
        
        MusicHelper.sharedHelper.playBackgroundMusic();
    }
    
    // Music Helper class to play the audio file
    class MusicHelper {
        static let sharedHelper = MusicHelper()
        var audioPlayer: AVAudioPlayer?
        
        func playBackgroundMusic() {
            let aSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "rain-3", ofType: "wav")!)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:aSound as URL)
                audioPlayer!.numberOfLoops = -1
                audioPlayer!.prepareToPlay()
                audioPlayer!.play()
            } catch {
                print("Cannot play the file")
            }
        }
        
        func stopBackgroundMusic() {
                audioPlayer?.stop()
            }
    }
    
    // Stops music when screen switches
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
    if segue.identifier == "ShowSecondViewController" {
            _ = segue.destination as! SecondViewController
              MusicHelper.sharedHelper.stopBackgroundMusic()
           }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

