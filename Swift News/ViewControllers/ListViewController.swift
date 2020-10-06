//
//  ListViewController.swift
//  Swift News
//
//  Created by Sandeep Sangwan on 2020-10-03.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableViewNews: UITableView?
    var newsList = [NewsArticle]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewNews?.rowHeight = UITableView.automaticDimension
        tableViewNews?.estimatedRowHeight = 44.0
        getNews()
    }
    
    func getNews() {
        APIController.shared.getNews(parameters: nil, success: { [weak self] (data) in
            DispatchQueue.main.async {[weak self] in
                self?.loadData(data: data as? NewsDataResult)
            }
        }, failure: {[weak self](statusCode) in
            DispatchQueue.main.async {[weak self] in
                let message = ValidationUtil.getAlertMessageForNews(statusCode: statusCode ?? 0)
                let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    func loadData(data: NewsDataResult?) {
        guard let result = data else {
            return
        }
        
        //update list here if paging
        newsList = result.list
        tableViewNews?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsItemCell

            //configure your cell
            cell.newsItem = newsList[indexPath.row]
            return cell
    }
}

