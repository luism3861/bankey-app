//
//  File.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 08/01/23.
//

import UIKit

class AnotherPage: UIViewController{
    var studentImage = UIImageView()
    
    override func viewDidLoad() {
        setup()
        layout()
        fetchData()
    }
    
    private func fetchData(){
        let url = URL(string: "http://haritibhakti.com/studentdata.json")
        let task  = URLSession.shared.dataTask(with: url!,completionHandler:
                                                {(data, response,error) in
            
            guard let data = data, error == nil else{
                print("Error Occured While Accesing Data")
                return
            }
            var anotherObject: AnotherData?
            do{
                anotherObject = try JSONDecoder().decode(AnotherData.self, from: data)
            }catch{
                print("Error While Decoding JSON into Swift Structure \(error)")
            }
            guard let sData = anotherObject else{
                return
            }
            
            DispatchQueue.main.async {
                let urlImage = URL(string: anotherObject!.simage)
                guard let urlImage = urlImage else {
                    return
                }
                
                self.studentImage.downloadImage(from: urlImage)
            }
        })
        task.resume()
    }
}



extension AnotherPage{
    private func setup(){
        studentImage.translatesAutoresizingMaskIntoConstraints = false
        studentImage.contentMode = .scaleAspectFit
        view.addSubview(studentImage)
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            studentImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            studentImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}



extension UIImageView{
    func downloadImage(from url: URL){
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {
            (data,response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200 , let mimeTY = response?.mimeType, mimeTY.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
            else{
                return
            }
            DispatchQueue.main.async{
                self.image = image
            }
        })
        dataTask.resume()
    }
}
