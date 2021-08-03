//
//  SearchViewController.swift
//  Schrodinger
//
//  Created by ido on 2021/07/29.
//

import UIKit

class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("feedItem.count =" , feedItem.count)
        return feedItem.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! SearchTableViewCell
        let item:DBSearchModel = feedItem[indexPath.row] as! DBSearchModel
        print(4)
        
        cell.NameTitle?.text = "식품명 : \(item.name!)"
        cell.Date?.text = "유통기간 : \(item.expirationDate!)"
        print("유통기간 : \(item.expirationDate!)")
        print(5)
        return cell
    }
    

    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var SegmentControl: UISegmentedControl!
    @IBOutlet weak var listTableView: UITableView!
    
    var feedItem:NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        print(1)
        // Do any additional setup after loading the view.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        let queryModel = SearchQueryModel()
//        queryModel.delegate = self
//        queryModel.downloadItems()
//        print(2)
//    }
    
    @IBAction func SegmentControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            let queryModel = UseQueryModel()
            queryModel.delegate = self
            queryModel.downloadItemed(name:SearchBar.text!)
            print(2)
        }else if sender.selectedSegmentIndex == 1 {
            let queryModel = SubmitQueryModel()
            queryModel.delegate = self
            queryModel.downloadItem(name:SearchBar.text!)
            print(2)
        }else if sender.selectedSegmentIndex == 2 {
            let queryModel = SearchQueryModel()
            queryModel.delegate = self
            queryModel.downloadItems(name:SearchBar.text!)
            print(2)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SearchViewController:UseQueryModelProtocol{
    func itemDownload(items: NSArray) {
        feedItem = items as! NSMutableArray
        self.listTableView.reloadData()
        print(3)
    }
}

extension SearchViewController:SearchQueryModelProtocol{
    func itemDownloaded(items: NSMutableArray) {
        feedItem = items
        self.listTableView.reloadData()
        print(3)
    }
}

extension SearchViewController:SubmitQueryModelProtocol{
    func itemDownloads(items: NSArray) {
        feedItem = items as! NSMutableArray
        self.listTableView.reloadData()
        print(3)
    }
}



