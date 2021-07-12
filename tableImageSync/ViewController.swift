//
//  ViewController.swift
//  tableImageSync
//
//  Created by Shylak Anton on 6.07.21.
//

import UIKit

class ViewController: UIViewController {
    var currentIndexRow: Int = -1
    var arrayURL: [String] = ["https://cdn.vox-cdn.com/thumbor/qoGA3CmmVNbYoR0jUFe0sgWE9Bg=/0x0:1800x1179/1820x1213/filters:focal(676x269:964x557):format(webp)/cdn.vox-cdn.com/uploads/chorus_image/image/66741310/3zlqxf_copy.0.jpg","https://ichef.bbci.co.uk/images/ic/704xn/p072ms1x.jpg","https://www.lboro.ac.uk/media/wwwlboroacuk/external/content/mediacentre/pressreleases/2018/10/maxresdefault.jpg"]
    var memesSmile: [String] = ["🐶","🐱","🐭"]
    var contentView: ContentViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
    
        contentView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "contentView")
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayURL.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentName = memesSmile[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = currentName
        return cell ?? UITableViewCell()
    }
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndexRow = indexPath.row
        guard let vc = contentView else {
            return
        }
        
        _ = vc.view
        vc.actionActivity.isHidden = false
        vc.actionActivity.startAnimating()
        
        DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime.now() + 2) {
            if let imageURL = URL(string: self.arrayURL[self.currentIndexRow]),
               let imageData = try? Data(contentsOf: imageURL)  {
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    vc.actionActivity.stopAnimating()
                    vc.actionActivity.isHidden = true
                    vc.imageContent.image = image
                }
            }
        }
        navigationController?.show(vc, sender: nil)
    }
}
