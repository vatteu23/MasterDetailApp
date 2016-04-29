//
//  Player.swift
//  Assignment3
//
//  Created by Uday Kiran Reddy Vatti on 4/7/16.
//  Copyright (c) 2016 Uday Kiran Reddy Vatti , Sreya Nooli. All rights reserved.
//

import Foundation

class Player {
    var Number : String
    var FirstName : String
    var LastName : String
    var Position : String
    var Bats : String
    var Throws : String
    var Height : String
    var Weight : String
    var DOB : String
    var playType : String
    init(Number : String, FirstName : String, LastName : String , Position : String , Bats : String, Throws : String, Height : String, Weight : String , DOB : String , playType : String)
    {
        self.Number = Number
        self.FirstName = FirstName
        self.LastName = LastName
        self.Position = Position
        self.Bats = Bats
        self.Throws = Throws
        self.Height = Height
        self.Weight = Weight
        self.DOB = DOB
        self.playType = playType
    }
    
}
