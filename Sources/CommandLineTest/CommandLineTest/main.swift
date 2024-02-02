//
//  main.swift
//  CommandLineTest
//
//  Created by etudiant on 10/01/2024.
//

import Foundation
import Model
import CommandLineExt

/*
 * DEBUG
 */

//debugTp1()
//debugTp2()
//debugTp3()
//debugTp4()

/*
 * START SOME DIFERENT KIND OF GAMES
 */

//try await two_dumb_AI_Game()

//try await simple_AI_vs_random_Game()

//try await testHumanVsRandom()

/*
 * CREATE SAMPLE OF GAME INTO CSV (need to use it in console, or no csv created)
 */

trainingAI(nbGameSample: 1000)
