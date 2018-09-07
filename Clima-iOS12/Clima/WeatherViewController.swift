//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

// What is a Delegate?
// A delegate volunteers to deal with certain information. In this case, the CLLocation Manager will deal with all location manager return calls
class WeatherViewController: UIViewController, CLLocationManagerDelegate, changeCityDelegate {
    
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "8e74172eb8baa8e2249a7a88173f3bee"
    /***Get your own App ID at https://openweathermap.org/appid ****/
    

    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()

    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO:Set up the location manager here.
        locationManager.delegate = self //We are delegate the location manager to ourselves
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization() //NOTE: When requesting permission, you need to add it to plist in order for the pop-up to show correctly
        locationManager.startUpdatingLocation() //runs asyncronously in the background
        
        
        
        
    }
    
    
    //MARK: - Networking
    /***************************************************************/
    //Alamofire is API for making networking requests
    //Write the getWeatherData method here:
    func getWeatherData(url : String, parameters : [String : String]){
        Alamofire.request(url, method: .get, parameters: parameters) .responseJSON{
            response in
            if response.result.isSuccess{
                print("Success connecting to HTTP via Alamofire")
                
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
                self.updateWeatherData(json: weatherJSON) //When you have something with (in) you have to use self
                
                
            }
            else{
                print(response.result.error)
                self.cityLabel.text = "Connection Error"
            }
   

            
        }
        
    }

    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //Write the updateWeatherData method here:
    func updateWeatherData(json : JSON){
        if let tempResult = json["main"]["temp"].double{
            
            weatherDataModel.temperature = Int(tempResult - 273.15)
            print(weatherDataModel.temperature)
            
            weatherDataModel.city = json["name"].stringValue
            
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            
        } // Using SwiftyJSON we can do: JSON->Main->Tem
        else{
            cityLabel.text = "Weather Unavailable"
        }
        updateUIWithWeatherData()
    }

    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    func updateUIWithWeatherData(){
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = String(weatherDataModel.temperature)
        weatherIcon.image = UIImage.init(named: weatherDataModel.weatherIconName)
    }
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var last = locations[locations.count-1]
        if last.horizontalAccuracy > 0{
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil //guaranteed do not retrieve information when locate has updated
            var latitude = String(last.coordinate.latitude)
            var longitude = String(last.coordinate.longitude)

            //Dictionary: Associates a key with a value. You can change the data type. Kind of like array, but instead of 0,1,2,3,4... you can have any datatype
            var params : [String : String] = ["lat" : latitude, "lon" : longitude , "appid" : APP_ID] // This is the API call that you can find in the OpenWeatherMap.org API
            getWeatherData(url : WEATHER_URL, parameters : params)
        }

        

    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Failed to get location"
    }
    
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    func userEnteredANewCityName(city: String) {
        print(city)
        let params : [String : String] = ["q" : city, "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: params)
    }

    
    //Write the PrepareForSegue Method here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "changeCityName"){
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
        }    
    }
    
    
    
    
}


