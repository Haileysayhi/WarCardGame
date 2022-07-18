//
//  EndGameViewController.swift
//  WarCardGame

import UIKit
import AVFoundation

class EndGameViewController: UIViewController {
    
    let player = AVPlayer()
    
    @IBOutlet weak var UILabel: UILabel!
    
    @IBOutlet weak var resultImage: UIImageView!
    
    
    var gameState: GameState?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        UILabel.text = winnerString()
        resultImage.image = UIImage(named: winnerImage())
        
        
        let fileUrl = Bundle.main.url(forResource: "Community", withExtension: "mp3")!
        let playerItem = AVPlayerItem(url: fileUrl)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        let time = CMTime(value: 2, timescale: 1)
        player.seek(to: time)
       
    
        
    }
    
    func winnerString() -> String{
        if gameState!.playerWin() {
            return "Player Wins!"
        } else {
            return "CPU Wins!"
        }
        
    }
    
    func winnerImage() -> String {
        if gameState!.playerWin() {
            return "PlayerWinner"
        }else {
            return "CPUWinner"
        }
    }
    
  

}
