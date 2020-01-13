//
//  MoviesFilterViewController.swift
//  TopFilmes
//
//  Created by Rodrigo Prado de Albuquerque on 18/10/19.
//  Copyright © 2019 Rodrigo Prado de Albuquerque. All rights reserved.
//

import UIKit

struct MoviesFilter {
    let text: String
    let year: String
}

protocol MoviesFilterProtocol {
    func filterMovies(filter: MoviesFilter)
}

class MoviesFilterVC: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    
    var delegate: MoviesFilterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filtro"
    }

    @IBAction func filter(_ sender: Any) {
        if searchIsValid() {
            doFilter()
        } else {
            showAlert()
        }
    }
    
    private func doFilter() {
        let filter = MoviesFilter(text: self.titleTextField.text ?? "",
                                  year: self.titleTextField.text ?? "")
        self.delegate?.filterMovies(filter: filter)
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchIsValid() -> Bool {
        if self.titleTextField.text != "" {
            return true
        } else {
            return false
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Atenção", message: "Você deve preencher o campo 'Titulo' para fazer uma busca", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
