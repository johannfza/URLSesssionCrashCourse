import Foundation

// MARK:- URLSession Crash Course

//  Setup a Mock Server
/// 1. Create a folder on your Desktop called `MockServer`
/// 2. Copy the file `StockInfoData.json` in to  the `MockServer` folder
/// 3. Open terminal
/// 4. Enter command `cd Desktop/MockServer` and press `return` on your keyboard
/// 5. Enter command `python –m SimpleHTTPServer` and press `return` on your keyboard
/// 6. Open your browser and enter `http://localhost:8000/StockInfoData.json`
/// 7. If you see the .json data you are all set up now
///

// MARK:- Parameters

let url = URL(string: "http://localhost:8000/StockInfoData.json")!


// MARK:- Level 1

//  URLSession
/// We can use the `data` object, of type `Data`, to check out what data we got back from the webserver, such as the JSON we’ve requested
/// The `response` object, of type `URLResponse`, can tell us more about the request’s response, such as its length, encoding, HTTP status code, return header fields, etcetera
/// The `error` object contains an `Error` object if an error occurred while making the request. When no error occurred, it’s simply nil.

func MockServerStocksAPICallWithURLSession() {
    let session = URLSession.shared
    let task = session.dataTask(with: url, completionHandler: { data, response, error in
        // Show Response
        print(">>>>> Response Object: ",String(describing: response))
        
        // Ensure no errors
        guard error == nil else {
            print(">>>>> Error Object: ", String(describing: error))
            return
        }
        
        // Ensure data is present
        guard let data = data else {
            return
        }

        // Serialize the data into an object
        do {
            let decoder = JSONDecoder()
            let stocks: [StockInfoModel] = try decoder.decode([StockInfoModel].self, from: data)
            print(">>>>> Stocks Array: ", String(describing: stocks))
        } catch {
            print(">>>>> Serialization Error: ", String(describing: error))
        }
    })
    task.resume()
}

print("Running MockServerStocksAPICallWithURLSession()...")
MockServerStocksAPICallWithURLSession()
