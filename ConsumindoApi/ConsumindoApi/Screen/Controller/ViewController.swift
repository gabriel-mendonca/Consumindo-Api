//
//  ViewController.swift
//  ConsumindoApi
//
//  Created by Gabriel Mendonça on 15/05/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var precoBitcoin: UILabel!
    @IBOutlet weak var btnAtualizar: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
    }
    @IBAction func atulizarPreco(_ sender: Any) {
        self.recuperarPrecoBitcoin()
    }
    
    func nummberFormater(preco: NSNumber) -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.locale = Locale(identifier: "pt_BR")
        
        if let precoFinal = nf.string(from: preco) {
            return precoFinal
        }
        return "0,00"
    }
    
    func recuperarPrecoBitcoin() {
        
        self.btnAtualizar.setTitle("Atualizando...", for: .normal)
        if let url = URL(string: "https://blockchain.info/ticker") {
               let tarefa = URLSession.shared.dataTask(with: url) { (dados, requisicao, erro) in
                   
                   if erro == nil {
                       
                       if let dadodRetorno = dados {
                           
                           
                           do {
                               let objetoJson = try JSONSerialization.jsonObject(with: dadodRetorno, options: []) as? [String: Any]
                              
                               if let brl = objetoJson!["BRL"] as? [String: Any] {
                                   
                                   if let preco = brl["buy"] as? Double {
                                    let formatarPreco = self.nummberFormater(preco: NSNumber(value: preco))
                                    DispatchQueue.main.async(execute: {
                                        self.precoBitcoin.text = "R$ " + formatarPreco
                                        self.btnAtualizar.setTitle("Atualizar", for: .normal)
                                    })
                                    
                                   }
                               }
                               
                           } catch  {
                               print("erro")
                           }
                           
                       }
                       
                   }else {
                       print("erro")
                   }
                   }
                   tarefa.resume()
                   
                   
               }
               
    }
    

}

