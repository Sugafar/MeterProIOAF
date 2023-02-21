//
//  ReportScreen.swift
//  MeterProIOAF
//
//  Created by Raf on 2/21/23.
//

import UIKit
import CoreBluetooth

class ReportScreen: UIViewController{
    let serviceLabel = UILabel()
    let lblTitle = UILabel()
    
    var peripheralManager: CBPeripheralManager?
    var peripheral: CBPeripheral?
    var periperalTXCharacteristic: CBCharacteristic?
    @IBOutlet weak var peripheralLabel: UILabel!
   // @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var consoleTextView: UITextView!
    @IBOutlet weak var consoleTextField: UITextField!
    @IBOutlet weak var txLabel: UILabel!
    @IBOutlet weak var rxLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupUI()
      //  NotificationCenter.default.addObserver(self, selector: #selector(self.appendRxDataToTextView(notification:)), name: NSNotification.Name(rawValue: "Notify"), object: nil)

       //
        
        
     //   consoleTextField.delegate = self

      //  peripheralLabel.text = BlePeripheral.connectedPeripheral?.name

       // txLabel.text = "TX:\(String(BlePeripheral.connectedTXChar!.uuid.uuidString))"
      //  rxLabel.text = "RX:\(String(BlePeripheral.connectedRXChar!.uuid.uuidString))"

        if let service = BlePeripheral.connectedService {
          serviceLabel.text = "Number of Services: \(String((BlePeripheral.connectedPeripheral?.services!.count)!))"
        } else{
            serviceLabel.text = "Service was not found"
          print("Service was not found")
        }
      }

      @objc func appendRxDataToTextView(notification: Notification) -> Void{
       // consoleTextView.text.append("\n[Recv]: \(notification.object!) \n")
        //  consoleTextView.text.append("\(notification.object!)")
    }
    
    func setupUI()
    {
        
        //Begin the image
        // Get the screen width
        let screenWidth = UIScreen.main.bounds.width
        
        // Set the desired width of the image
        let desiredWidth: CGFloat = screenWidth
        
        
        
        // Load the original image
        let image = UIImage(named: "dcleftsvg")
        
        // Calculate the scale factor
        let scaleFactor = image!.size.width / desiredWidth
        
        // Calculate the new size
        let newSize = CGSize(width: image!.size.width / scaleFactor, height: image!.size.height / (scaleFactor * 1.20))
        
        // Create a new image that is scaled
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image!.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let padding2 = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 30)
      //  imageView = UIImageView(image:paddedImage?.withAlignmentRectInsets(padding2))
        
        //******end of add padding
        
        // Display the scaled image in an image view
        let imageView = UIImageView(image:newImage?.withAlignmentRectInsets(padding2))
      //  imageView.contentMode = .scaleAspectFit
        //imageView.center = view.center
        view.addSubview(imageView)
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
           // imageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           // imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 60)
            
        ])
        
        //Begin the label
        //let lblTitle = UILabel()
        lblTitle.text = "MeterPro.io"
        lblTitle.textColor = UIColor.black
       // lblTitle.font = .systemFont(ofSize: 20)
        lblTitle.font = .systemFont(ofSize: 26, weight: .medium)
        
        view.addSubview(lblTitle)
        
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        lblTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        lblTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 10)
        ])
        //end of lable
        
        
        view.addSubview(serviceLabel)
       // serviceLabel.text = "MeterPro.io"
        serviceLabel.textColor = UIColor.black
       // lblTitle.font = .systemFont(ofSize: 20)
        serviceLabel.font = .systemFont(ofSize: 26, weight: .medium)
        
        
        
        serviceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        serviceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        serviceLabel.topAnchor.constraint(equalTo: view.centerYAnchor,constant: 3)
        ])
    }
    
    
    
    
}
//end of class declaration

extension ReportScreen: CBPeripheralManagerDelegate {

  func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
    switch peripheral.state {
    case .poweredOn:
        print("Peripheral Is Powered On.")
    case .unsupported:
        print("Peripheral Is Unsupported.")
    case .unauthorized:
    print("Peripheral Is Unauthorized.")
    case .unknown:
        print("Peripheral Unknown")
    case .resetting:
        print("Peripheral Resetting")
    case .poweredOff:
      print("Peripheral Is Powered Off.")
    @unknown default:
      print("Error")
    }
  }


  //Check when someone subscribe to our characteristic, start sending the data
  func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
      print("Device subscribe to characteristic")
  }

}

extension ReportScreen: UITextViewDelegate {

}

extension ReportScreen: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
  //  writeOutgoingValue(data: textField.text ?? "")
  //  appendTxDataToTextView()
    textField.resignFirstResponder()
    textField.text = ""
    return true

  }

  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    textField.clearsOnBeginEditing = true
    return true
  }

}

