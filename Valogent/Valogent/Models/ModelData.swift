//
//  ModelData.swift
//  Valogent
//
//  Created by Timothy Kristanto on 21/05/22.
//

import Foundation

class ModelData : ObservableObject{
    // when this array gets updated, it will notify the views to also update itself
    @Published var agents: [Agent] = []
    
    func fetchData() {
        guard let url = URL(string: "https://valorant-api.com/v1/agents") else{
            print("Error occured when trying to connect to the link!")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do{
                let agents = try JSONDecoder().decode(AgentData.self, from: data)
                
                DispatchQueue.main.async {
                    self?.agents = agents.data
                }
            }catch DecodingError.dataCorrupted(let context) {
                print(context)
            } catch DecodingError.keyNotFound(let key, let context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.valueNotFound(let value, let context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.typeMismatch(let type, let context) {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
        
        task.resume()
    }
}
