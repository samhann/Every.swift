//
//  DetailViewController.swift
//  Every
//
//  Created by Samhan on 05/01/16.
//  Copyright © 2016 Samhan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    deinit
    {
        print("deinit!")
        
    }
    


    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.every_clearTimers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        every(1.minutes + 3.seconds, owner: self) {
            print("hello")
            return true
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

