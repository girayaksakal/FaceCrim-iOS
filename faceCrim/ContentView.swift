//
//  ContentView.swift
//  faceCrim
//
//  Created by Giray Aksakal on 5.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var responseText = ""
    @State private var statusText = ""
<<<<<<< HEAD
=======
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var nsfw = UserDefaults.standard.bool(forKey: "enabled_preference")
>>>>>>> take-picture
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .cornerRadius(8)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(height: 300)
<<<<<<< HEAD
                        .overlay(Text("Select an Image").foregroundStyle(.white))
=======
                        .overlay(Text("Select or Capture an Image").foregroundStyle(.white))
>>>>>>> take-picture
                        .cornerRadius(8)
                }
                
                HStack {
                    Button(action: {
                        selectedImage = nil
                        responseText = ""
                        statusText = ""
                    }) {
<<<<<<< HEAD
                        Text("Clear Fields")
=======
                        Text("Clear")
>>>>>>> take-picture
                            .padding()
                            .background(Color.gray)
                            .foregroundStyle(.white)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
<<<<<<< HEAD
                        showImagePicker = true
                    }) {
                        Text("Choose Image")
=======
                        sourceType = .camera
                        showImagePicker = true
                    }) {
                        Text("Take Photo")
>>>>>>> take-picture
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
<<<<<<< HEAD
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(selectedImage: $selectedImage)
=======
                    
                    Button(action: {
                        sourceType = .photoLibrary
                        showImagePicker = true
                    }) {
                        Text("Choose Photo")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
>>>>>>> take-picture
                    }
                }
                
                
                
                if let _ = selectedImage {
                    Button(action: {
                        uploadImage()
                    }) {
                        Text("Upload Image")
                            .padding()
                            .background(Color.green)
                            .foregroundStyle(.white)
                            .cornerRadius(8)
                    }
                }
                
<<<<<<< HEAD
//                REDACTED FOR PRESENTATION
//                Text("Prediction: \(responseText)")
//                    .padding()
//                    .font(.headline)
                
                Text("Status: \(statusText)")
                    .padding()
                    .font(.headline)
                    .foregroundStyle(statusText == "INNOCENT" ? .green : statusText == "GUILTY" ? .red : .gray)
=======
                Spacer()
                
                VStack {
                    //                MARK: - REDACTATION FOR PRESENTATION
                    if (nsfw == false) {
                        Text("Prediction: \(responseText)")
                            .padding()
                            .font(.headline)
                    }
                    
                    Text("Status: \(statusText)")
                        .padding()
                        .font(.headline)
                        .foregroundStyle(statusText == "INNOCENT" ? .green : statusText == "GUILTY" ? .red : .gray)
                }
                .padding(.bottom, 75)
>>>>>>> take-picture
            }
            .padding()
            .navigationTitle("FaceCrim")
            .navigationBarTitleDisplayMode(.large)
<<<<<<< HEAD
=======
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: sourceType, selectedImage: $selectedImage)
            }
        }
    }
    
    func uploadImage() {
        guard let image = selectedImage else { return }
        //        MARK: - PUBLIC API ENDPOINT URL
        guard let url = URL(string: "https://facecrim.azurewebsites.net/api/Image/predict") else { return }
        //        MARK: - LOCAL TEST ENDPOINT URL
        //        guard let url = URL(string: "http://192.168.0.21:8080/api/Image/predict") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let imageData = image.jpegData(compressionQuality: 0.8)!
        var body = Data()
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    responseText = "Error: \(error.localizedDescription)"
                    statusText = "COULD NOT DETERMINED"
                }
                return
            }
            if let data = data, let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String], let prediction = jsonResponse["prediction"] {
                DispatchQueue.main.async {
                    responseText = prediction
                    statusText = getStatusMessage(for: prediction)
                }
            } else {
                DispatchQueue.main.async {
                    responseText = ""
                    statusText = "COULD NOT DETERMINED"
                }
            }
        }.resume()
    }
    
    func getStatusMessage(for prediction: String) -> String {
        switch prediction {
        case "INNO":
            return NSLocalizedString("status_innocent", comment: "Message for innocent prediction")
        case "FETO", "PKK":
            return NSLocalizedString("status_guilty", comment: "Message for guilty prediction")
        default:
            return NSLocalizedString("status_undetermined", comment: "Message for undetermined prediction")
>>>>>>> take-picture
        }
    }
    
    func uploadImage() {
        guard let image = selectedImage else { return }
//        Public API endpoint url
//        guard let url = URL(string: "https://facecrim.azurewebsites.net/api/Image/predict") else { return }
        guard let url = URL(string: "http://192.168.0.21:8080/api/Image/predict") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let imageData = image.jpegData(compressionQuality: 0.8)!
        var body = Data()
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    responseText = "Error: \(error.localizedDescription)"
                    statusText = "COULD NOT DETERMINED"
                }
                return
            }
            if let data = data, let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String], let prediction = jsonResponse["prediction"] {
                DispatchQueue.main.async {
                    responseText = prediction
                    statusText = getStatusMessage(for: prediction)
                }
            } else {
                DispatchQueue.main.async {
                    responseText = ""
                    statusText = "COULD NOT DETERMINED"
                }
            }
        }.resume()
    }
    
    func getStatusMessage(for prediction: String) -> String {
            switch prediction {
            case "INNO":
                return "INNOCENT"
            case "FETO", "PKK":
                return "GUILTY"
            default:
                return "COULD NOT DETERMINED"
            }
        }
}

#Preview {
    ContentView()
}
