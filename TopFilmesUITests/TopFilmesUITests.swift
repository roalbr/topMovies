//
//  TopFilmesUITests.swift
//  TopFilmesUITests
//
//  Created by Rodrigo Prado de Albuquerque on 20/10/19.
//  Copyright © 2019 Rodrigo Prado de Albuquerque. All rights reserved.
//

import XCTest

class TopFilmesUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
    }

    func testListAction() {
        let app = XCUIApplication()
        app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        app.buttons["arrowDown"].tap()
        app.navigationBars["Detalhes do filme"].buttons["Top Filmes"].tap()
    }
    
    func testFilterAction() {
        
        let app = XCUIApplication()
        app.navigationBars["Top Filmes"].buttons["Search"].tap()
        app.otherElements.containing(.navigationBar, identifier:"Filtro").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 0).tap()
        
        let opcionalTextField = app.textFields["opcional"]
        opcionalTextField.tap()
        opcionalTextField.tap()
        app.buttons["Filtrar"].tap()
    }
    
    func testFavoritesAction() {
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        app.buttons["Adicionar aos Favoritos"].tap()
        app.buttons["arrowDown"].tap()
        
        let detalhesDoFilmeNavigationBar = app.navigationBars["Detalhes do filme"]
        detalhesDoFilmeNavigationBar.buttons["Top Filmes"].tap()
        app.navigationBars["Top Filmes"].buttons["Organize"].tap()
        collectionViewsQuery.cells.children(matching: .other).element.children(matching: .other).element.tap()
        app.buttons["Remover dos Favoritos"].tap()
        detalhesDoFilmeNavigationBar.buttons["Filmes Favoritos"].tap()
        app.navigationBars["Filmes Favoritos"].buttons["Top Filmes"].tap()
    }
    
    func testInfiniteScroolAndPushToRefresh() {
        let app = XCUIApplication()
        let collectionView = app.otherElements.containing(.navigationBar, identifier:"Top Filmes").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element
        collectionView.swipeDown()
        collectionView.swipeUp()
        app.collectionViews.children(matching: .cell).element(boundBy: 7).children(matching: .other).element.swipeUp()
    }
}
