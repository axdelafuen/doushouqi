//
//  AnimalTest.swift
//  
//
//  Created by etudiant on 30/01/2024.
//

import XCTest
@testable import Model
final class AnimalTest: XCTestCase {

    func testComparableBehaviourInf() throws {
        XCTAssertTrue(Animal.rat < Animal.cat)
        XCTAssertTrue(Animal.cat < Animal.dog)
        XCTAssertTrue(Animal.dog < Animal.wolf)
        XCTAssertTrue(Animal.wolf < Animal.leopard)
        XCTAssertTrue(Animal.leopard < Animal.tiger)
        XCTAssertTrue(Animal.tiger < Animal.lion)
        XCTAssertTrue(Animal.lion < Animal.elephant)
        XCTAssertTrue(Animal.elephant < Animal.rat)
    }

    func testComparableBehaviourSup() throws {
        XCTAssertFalse(Animal.rat > Animal.cat)
        XCTAssertFalse(Animal.cat > Animal.dog)
        XCTAssertFalse(Animal.dog > Animal.wolf)
        XCTAssertFalse(Animal.wolf > Animal.leopard)
        XCTAssertFalse(Animal.leopard > Animal.tiger)
        XCTAssertFalse(Animal.tiger > Animal.lion)
        XCTAssertFalse(Animal.lion > Animal.elephant)
        XCTAssertFalse(Animal.elephant > Animal.rat)
    }
}
