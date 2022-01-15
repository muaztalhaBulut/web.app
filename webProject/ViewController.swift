//
//  ViewController.swift
//  webProject
//
//  Created by Muaz Talha Bulut on 14.01.2022.
//

import UIKit
import WebKit

class ViewController: UIViewController, UITextFieldDelegate, WKNavigationDelegate {
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var goButton: UIBarButtonItem!
    @IBOutlet weak var adressField: UITextField!
    @IBOutlet weak var webKit: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.isEnabled = false // app ilk açıldığında buttonlar aktif değil. Ardından kullanıcı işlem yapacağı için uıtextfieldelegate ı ekliyoruz.
        goButton.isEnabled = false
        adressField.delegate = self
        webKit.navigationDelegate = self
    }
    // sayfa yüklendiğinde buttonları çalıştırma işlemi
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isEnabled = webView.canGoBack
        goButton.isEnabled = webView.canGoForward
    }
    //app açıldığında ilk açılacak sayfa..
    
    override func viewDidAppear(_ animated: Bool) {
        let urlString = "https://google.com"
        let url = URL(string: urlString)
        // request oluşturalım
        let request = URLRequest(url: url!)
        webKit.load(request) // request işlemi tamamlandı.
        adressField.text = urlString
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlString = adressField.text!
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        webKit.load(request)
        textField.resignFirstResponder()
        return true
    }

    @IBAction func backButton(_ sender: Any) {
        if webKit.canGoBack {
            webKit.goBack()
            adressField.text = webKit.url?.absoluteString
        }
    }
    
    @IBAction func goButton(_ sender: Any) {
        if webKit.canGoForward {
            webKit.goForward()
            adressField.text = webKit.url?.absoluteString
        }
                
    }
}

