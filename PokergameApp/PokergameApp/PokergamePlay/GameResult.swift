////
////  GameResult.swift
////  cardGameRefactor
////
////  Created by hw on 22/08/2019.
////  Copyright © 2019 hwj. All rights reserved.
////
//
//import Foundation
//
//import Foundation
//
//
//typealias GameWinner = (name: [String], type: String)

struct GameWinner{
    var name: [String]
    var type: String
}
class GameResult {
    private var playerList : [Player]
    
    init?(_ players: [Playable]){
        guard var list = players as? [Player] else {
            return nil
        }
        playerList = list
        sortPlayerCardDeck()
    }
    
    func selectWinnerName() -> GameWinner {
        sortPlayerByDescendingOrderScore()
        let winners = hasMoreWinner(playerList[0])
        let winType = decideWinningType(playerList[0].score)
        return GameWinner(name: winners, type: winType)
    }

    private func hasMoreWinner(_ gamePlayer: Player) -> [String] {
        var result = [String]()
        result.append(gamePlayer.presentName)
        for candidateIndex in 1..<playerList.count {
            if gamePlayer == playerList[candidateIndex] {
                result.append(gamePlayer.presentName)
            }
        }
        return result
    }

    private func sortPlayerByDescendingOrderScore() {
        self.playerList.sort { (player1, player2) -> Bool in
            player1 > player2
        }
    }
    
    private func sortPlayerCardDeck() {
        for player in self.playerList {
            player.sortOwnHand()
        }
    }
    
    private func decideWinningType(_ score: Int) -> String{
        let result = CardScore(score)
        return result.description
    }
}
