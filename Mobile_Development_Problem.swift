//
//  ViewController.swift
//  ShopifyJson
//
//  Created by Vipul Srivastav on 2017-04-30.
//  Copyright © 2017 Vipul Srivastav. All rights reserved.
//

import UIKit
import Alamofire        // Swift Networking Library to make requests easier

class ViewController: UIViewController
{
    @IBOutlet var dispRequestStatus: UILabel! // label to show get request status
    @IBOutlet var dispJson: UILabel!          // label to show Total Order Revenue
    @IBOutlet var dispCount: UILabel!        //  label to show count of Aerodynamic Cotton Keyboards
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // url
        let url = "https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6";
        Alamofire.request(url).responseJSON //Alamofire requesting url, installed using carthage
            {        response in
                // request status
                self.dispRequestStatus.text = "Request "+String(describing: response.result)
                
                let JSONres = response.result.value
                //building orders
                let orderDict =  (JSONres as AnyObject)["orders"] as? [[String:AnyObject]]
                
                // variables to store total order revenue, loop variables i & j
                var totalRevenue: Float = 0
                var i: Int = 0 // to loop over all orders
                var j: Int = 0 // to loop over line items in a particular order
                var count: Int = 0 // to count no. of keyboards
                //while loop to iterate orders, loop variable i < count(order Dict)
                while(i<(orderDict?.count)! as Int)
                {
                    // Building array to store line_items to check keyboard
                    let arr: Array = Array((orderDict?[i]["line_items"])! as! [[String:AnyObject]])
                    // while loop to iterate over line items of a order, loop variable j < count(line_items)
                    while(j<arr.count as Int)
                    {
                        // check if title = aerodynamic cotton keyboard, if yes, increment count
                        if(arr[j]["title"]! as! String == "Aerodynamic Cotton Keyboard"){count = count + 1}
                        j = j + 1;
                    }
                    
                    // To calculate Total Order Revenue
                    totalRevenue = totalRevenue + Float((orderDict?[i]["total_line_items_price"])! as! String)!
                    i = i+1
                    // Re-Intiliazing loop variable j so as to loop again for the subsequent orders
                    j=0
                }
                print(totalRevenue) // prints total order revenue in the console
                print(count)        // prints total no. of keyboards in console
                
                self.dispJson.text = "Total Revenue in CAD = " + String(totalRevenue)
                self.dispCount.text = "No. of Aerodynamic Cotton Keyboard = " + String(count)
                
        }
        
    }
    
    
}

