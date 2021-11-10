//
//  SynchronousViewController.swift
//  Networking
//
//  Created by Lee on 8/27/21.
//

import UIKit

class SynchronousViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let posts = NetworkServicing.shared.fetchPostSynchronous()
//        print(posts)
        NetworkServicing.shared.fetch(endpoint: PostServiceEndPoint.getPosts.url) { (_ result: Result<[PostComment], NetworkError>) in
            switch result {
            case .success(let post):
                print(post)
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("=======fetch post===========")
        let fetchTPosts: [Post]? = NetworkServicing.shared.fetchTSynchronous(endpoint: PostServiceEndPoint.getPosts.url)
        print("=======fetch post : \(fetchTPosts)===========")
    }
}
