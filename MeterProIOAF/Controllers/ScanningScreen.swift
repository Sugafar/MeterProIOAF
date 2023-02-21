//
//  ViewController.swift
//  Basic Chat
//
//  Created by Trevor Beaton on 2/3/21.
//

import UIKit
import CoreBluetooth

class ScanningScreen: UIViewController {
    
    // Data
    private var centralManager: CBCentralManager!
    private var mpPeripheral: CBPeripheral!
    private var txCharacteristic: CBCharacteristic!
    private var rxCharacteristic: CBCharacteristic!
    private var peripheralArray: [CBPeripheral] = []
    private var rssiArray = [NSNumber]()
    private var timer = Timer()
    
    // UI
    let lblTitle = UILabel()
    let buttonDeviceName = UIButton(type: .system)
    let scanButton = UIButton(type: .system)
    let scanLabel = UILabel()
    let peripheralFoundLabel = UILabel()
    let tableView = UITableView()
    // @IBOutlet weak var tableView: UITableView!
    // @IBOutlet weak var peripheralFoundLabel: UILabel!
    // @IBOutlet weak var scanningLabel: UILabel!
    // @IBOutlet weak var scanningButton: UIButton!
    
    // @IBAction func scanningAction(_ sender: Any) {
    // startScanning()
    //  }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        
        setupUI()
        // Manager
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
      disconnectFromDevice()
      self.tableView.reloadData()
      //startScanning()
    }

    func connectToDevice() -> Void {
      centralManager?.connect(mpPeripheral!, options: nil)
  }

    func disconnectFromDevice() -> Void {
      if mpPeripheral != nil {
        centralManager?.cancelPeripheralConnection(mpPeripheral!)
      }
  }
    
    func removeArrayData() -> Void {
      centralManager.cancelPeripheralConnection(mpPeripheral)
           rssiArray.removeAll()
           peripheralArray.removeAll()
       }

    @objc func startScanning() -> Void {
        // Remove prior data
       
        peripheralArray.removeAll()
        rssiArray.removeAll()
        // Start Scanning
       // centralManager?.scanForPeripherals(withServices: [CBUUIDs.BLEService_UUID])
        centralManager?.scanForPeripherals(withServices: nil,options: nil)
        scanLabel.text = "Scan..."
       // scanButton.isEnabled = false
        Timer.scheduledTimer(withTimeInterval: 15, repeats: false) {_ in
            self.stopScanning()
        }
    }

    func scanForBLEDevices() -> Void {
      // Remove prior data
      peripheralArray.removeAll()
      rssiArray.removeAll()
      // Start Scanning
       // centralManager?.scanForPeripherals(withServices: [CBUUIDs.BLEService_UUID] , //options: [CBCentralManagerScanOptionAllowDuplicatesKey:true])
        
        centralManager?.scanForPeripherals(withServices: nil,options: nil)
     
      scanLabel.text = "Sca..."

      Timer.scheduledTimer(withTimeInterval: 15, repeats: false) {_ in
          self.stopScanning()
      }
  }

    func stopTimer() -> Void {
      // Stops Timer
      self.timer.invalidate()
    }

    func stopScanning() -> Void {
        scanLabel.text = ""
        scanButton.isEnabled = true
        centralManager?.stopScan()
    }

    @objc func delayedConnection() -> Void {
        connectToDevice()
        let nextScreen = ReportScreen()
        nextScreen.title = "Second Screen"
    BlePeripheral.connectedPeripheral = mpPeripheral

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.navigationController?.pushViewController(nextScreen, animated: true)
        })
  }
    
   
    
    
    
    func setupUI(){
        
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
        
        //begin scanbutton
        
        view.addSubview(scanButton)
        
       // scanButton.configuration = .filled()
        scanButton.backgroundColor = .systemGreen
        scanButton.titleLabel?.textColor = UIColor.black
        //scanButton.titleLabel?.text = "Scan for PPC"
        scanButton.setTitle("Scan for PPC", for: .normal)
       
        
        scanButton.translatesAutoresizingMaskIntoConstraints = false
        
        scanButton.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        scanButton.topAnchor.constraint(equalTo:lblTitle.bottomAnchor,constant: 15).isActive = true
        scanButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        scanButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        scanButton.addTarget(self,action: #selector(startScanning),for:.touchUpInside)
        
       
        
        //end of scanButton
        
        //Begin scanLabel
        
        scanLabel.text = ""
        scanLabel.textColor = UIColor.black
       // lblTitle.font = .systemFont(ofSize: 20)
        scanLabel.font = .systemFont(ofSize: 26, weight: .medium)
        
        view.addSubview(scanLabel)
        
        scanLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        scanLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        scanLabel.topAnchor.constraint(equalTo: scanButton.bottomAnchor,constant: 10)
        ])
        //end of scanlable
        
        //Begin periphiralFoundLabel
        
        peripheralFoundLabel.text = ""
        peripheralFoundLabel.textColor = UIColor.black
       // lblTitle.font = .systemFont(ofSize: 20)
        peripheralFoundLabel.font = .systemFont(ofSize: 26, weight: .medium)
        
       view.addSubview(peripheralFoundLabel)
        
        peripheralFoundLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
       peripheralFoundLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        peripheralFoundLabel.topAnchor.constraint(equalTo: scanLabel.bottomAnchor,constant: 10)
        ])
        //end of peripheralFounfLabel
        
        //begin deviceButton
               view.addSubview(buttonDeviceName)
               
               buttonDeviceName.backgroundColor = .systemGreen
              buttonDeviceName.titleLabel?.textColor = UIColor.black
              // buttonDeviceName.titleLabel?.text = "Scan for PPC"
               buttonDeviceName.setTitle("Get Report", for: .normal)
              
               buttonDeviceName.translatesAutoresizingMaskIntoConstraints = false
               
               buttonDeviceName.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
               buttonDeviceName.topAnchor.constraint(equalTo:peripheralFoundLabel.bottomAnchor,constant: 15).isActive = true
               buttonDeviceName.widthAnchor.constraint(equalToConstant: 200).isActive = true
               buttonDeviceName.heightAnchor.constraint(equalToConstant: 50).isActive = true
               buttonDeviceName.addTarget(self,action: #selector(delayedConnection),for:.touchUpInside)
               
               
               //end of buttonDevice
        
        //Begin tableView
        
      
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor.white
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
       tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
       tableView.topAnchor.constraint(equalTo: buttonDeviceName.bottomAnchor,constant: 10)
        ])
        //end of tableView
    }
}
      
// A protocol that provides updates for the discovery and management of peripheral devices.
extension ScanningScreen: CBCentralManagerDelegate {

   // MARK: - Check
   func centralManagerDidUpdateState(_ central: CBCentralManager) {

     switch central.state {
       case .poweredOff:
           print("Is Powered Off.")

           let alertVC = UIAlertController(title: "Bluetooth Required", message: "Check your Bluetooth Settings", preferredStyle: UIAlertController.Style.alert)

           let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) -> Void in
               self.dismiss(animated: true, completion: nil)
            })

            alertVC.addAction(action)

            self.present(alertVC, animated: true, completion: nil)

        case .poweredOn:
            print("Is Powered On.")
            startScanning()
        case .unsupported:
            print("Is Unsupported.")
        case .unauthorized:
        print("Is Unauthorized.")
        case .unknown:
            print("Unknown")
        case .resetting:
            print("Resetting")
        @unknown default:
          print("Error")
        }
    }

    // Discover
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
      print("Function: \(#function),Line: \(#line)")

      mpPeripheral = peripheral

      if peripheralArray.contains(peripheral) {
          print("Duplicate Found.")
      } else {
          if(peripheral.name == "MeterPro.io")
          {
              peripheralArray.append(peripheral)
              BlePeripheral.connectedPeripheral = peripheral
              connectToDevice()
              
              stopScanning()
          }
        rssiArray.append(RSSI)
         // stopScanning()
          
      }

      peripheralFoundLabel.text = "Peripherals Found: \(peripheralArray.count)"

      mpPeripheral.delegate = self
       // buttonDeviceName.titleLabel?.text = "Get Report"
      print("Peripheral Discovered: \(peripheral)")

      self.tableView.reloadData()
    }

    // MARK: - Connect
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        stopScanning()
        mpPeripheral.discoverServices([CBUUIDs.BLEService_UUID])
    }
}


// A protocol that provides updates on the use of a peripheral’s services.
extension ScanningScreen: CBPeripheralDelegate {

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {

      guard let services = peripheral.services else { return }
      for service in services {
        peripheral.discoverCharacteristics(nil, for: service)
      }
      BlePeripheral.connectedService = services[0]
    }

  func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {

    guard let characteristics = service.characteristics else {
        return
    }

    print("Found \(characteristics.count) characteristics.")

    for characteristic in characteristics {

      if characteristic.uuid.isEqual(CBUUIDs.BLE_Characteristic_uuid_Rx)  {

        rxCharacteristic = characteristic

        BlePeripheral.connectedRXChar = rxCharacteristic

        peripheral.setNotifyValue(true, for: rxCharacteristic!)
        peripheral.readValue(for: characteristic)

        print("RX Characteristic: \(rxCharacteristic.uuid)")
      }

      if characteristic.uuid.isEqual(CBUUIDs.BLE_Characteristic_uuid_Tx){
        txCharacteristic = characteristic
        BlePeripheral.connectedTXChar = txCharacteristic
        print("TX Characteristic: \(txCharacteristic.uuid)")
      }
    }
    delayedConnection()
 }



  func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {

    var characteristicASCIIValue = NSString()

    guard characteristic == rxCharacteristic,

          let characteristicValue = characteristic.value,
          let ASCIIstring = NSString(data: characteristicValue, encoding: String.Encoding.utf8.rawValue) else { return }

      characteristicASCIIValue = ASCIIstring

    print("Value Recieved: \((characteristicASCIIValue as String))")

    NotificationCenter.default.post(name:NSNotification.Name(rawValue: "Notify"), object: "\((characteristicASCIIValue as String))")
  }

  func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        peripheral.readRSSI()
    }

  func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
      guard error == nil else {
          print("Error discovering services: error")
          return
      }
    print("Function: \(#function),Line: \(#line)")
      print("Message sent")
  }


  func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
      print("*******************************************************")
    print("Function: \(#function),Line: \(#line)")
      if (error != nil) {
          print("Error changing notification state:\(String(describing: error?.localizedDescription))")

      } else {
          print("Characteristic's value subscribed")
      }

      if (characteristic.isNotifying) {
          print ("Subscribed. Notification has begun for: \(characteristic.uuid)")
      }
  }

}


// The methods adopted by the object you use to manage data and provide cells for a table view.
extension ScanningScreen: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.peripheralArray.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

      let cell = tableView.dequeueReusableCell(withIdentifier: "BlueCell") as! TableViewCell

      let peripheralFound = self.peripheralArray[indexPath.row]

      let rssiFound = self.rssiArray[indexPath.row]

        if peripheralFound == nil {
            cell.peripheralLabel.text = "Unknown"
        }else {
            cell.peripheralLabel.text = peripheralFound.name
            cell.rssiLabel.text = "RSSI: \(rssiFound)"
        }
        return cell
    }


}

// Methods for managing selections, deleting and reordering cells and performing other actions in a table view.
extension ScanningScreen: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

      mpPeripheral = peripheralArray[indexPath.row]

        BlePeripheral.connectedPeripheral = mpPeripheral

        connectToDevice()

    }
}


