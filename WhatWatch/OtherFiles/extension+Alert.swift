//
//  extension+Alert.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 07/10/2022.
//

import UIKit

extension UIViewController {
    
    func AlertNoExtrait() {
        let alert = UIAlertController(title: "No Extrait", message: "Sorry no Extrait yet", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
    
    func DeleteAllOrNot(){
        
    }

}


