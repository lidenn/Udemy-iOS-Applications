//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""
    var publicKey = "M2E5YThjYjAxMWJkNDkzNGE5ZTE3YzQ5MDYzMTJhYWM"
    var secretKey = "MTZlMTNkMDQyZTFjNDhlM2EwOWRmZWRiZDg4YWJkNDk4ZGJhZWRlYmM1MmY0YjkyOWZhNjI2YjY1MjNjOTY0Yw"

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self //Set to delegate to self if someone uses the picker
        currencyPicker.dataSource = self //Data source is set to self because it is in this file
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Number of columns
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        finalURL = baseURL + currencyArray[row]
        getPrice(url: finalURL)
    }
    

    
    
    
//    
//    //MARK: - Networking
//    /***************************************************************/
    
    
   
    func getPrice(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    let weatherJSON : JSON = JSON(response.result.value!)

                    print(weatherJSON)
                    self.updatePrice(json: weatherJSON)

                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
            }

    }

//    //MARK: - JSON Parsing
//    /***************************************************************/
    
    func updatePrice(json : JSON) {
        var tempPrice : Double = 0
        if  let tempPrice = json["last"].double{
            bitcoinPriceLabel.text = String(tempPrice)
        }
    }
    




}

