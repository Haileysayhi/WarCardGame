//
//  ViewController.swift
//  WarCardGame

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var leftImageView: UIImageView!
    
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var leftScoreLabel: UILabel!
    
    @IBOutlet weak var rightScoreLabel: UILabel!
    
    
    var gameState: GameState = GameState()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateView()
        self.navigationItem.hidesBackButton = true
    }
    
    func updateView() {
        leftImageView.image = UIImage(named: gameState.player1VisibleCard()?.filename() ?? "")
        rightImageView.image = UIImage(named: gameState.player2VisibleCard()?.filename() ?? "")
        
        
        leftScoreLabel.text = String(gameState.player1CardCount())
        rightScoreLabel.text = String(gameState.player2CardCount())
    }
    
    @IBAction func dealTapped(_ sender: Any) {
        if gameState.gameEnded {
            performSegue(withIdentifier: "EndGameSegue", sender: nil)
        }
        else if gameState.isInBattle() {
            gameState.decideBattle()
            gameState.player1DrawCard()
            gameState.player2DrawCard()
        } else {
            gameState.player1DrawCard()
            gameState.player2DrawCard()
        }
        updateView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EndGameSegue"{
            let destinationController = segue.destination as! EndGameViewController
            destinationController.gameState = gameState
        }
    }

}
