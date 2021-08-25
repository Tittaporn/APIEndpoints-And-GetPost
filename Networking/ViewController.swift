//
//  ViewController.swift
//  Networking
//
//  Created by Lee on 8/5/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(PostServiceEndPoint.getPosts.url)
        print(PostServiceEndPoint.getPostComments(postId: "1").url)
        print(PostServiceEndPoint.postPost.url)
        print(PostServiceEndPoint.testEndPoint(test: "test", testId: "1234", propertyId: "4567").url)
        
        NetworkServicing.shared.fetch(endpoint: PostServiceEndPoint.getPostComments(postId: "1").url) { (_ result: Result<[PostComment], NetworkError>)in
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
        NetworkServicing.shared.fetch(endpoint: PostServiceEndPoint.getPosts.url) { (_ result: Result<[Post],NetworkError>) in
            switch result {
            case .success(let posts):
                print("SUCCESSFULLY GET POSTS!")
                print(posts)
            case .failure(let error):
                print(error.errorDescription)
            }
        }
        
        let post = Post(userId: 2, id: 1, title: "TEST POST", body: "TESTPOST")
        NetworkServicing.shared.save(endpoint: PostServiceEndPoint.postPost.url, type: post) { (_ result: Result<Post,NetworkError>) in
            switch result {
            case .success(let posts):
                print("\n=================== :: posts \(posts)======================IN \(#function)\n")
            case .failure(let error):
                print("=================== \(error.errorDescription)======================")
            }
        }
    }
}



