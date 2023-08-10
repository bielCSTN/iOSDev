//
//  ContentView.swift
//  Instafilter
//
//  Created by Biel on 25/04/23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    @State private var showingFilterSheet = false
    @State private var filterIntensity = 0.5
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var processedImage: UIImage?
    
    @State private var saveButtonDisable = true
    
    let context = CIContext()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Escolha uma Foto!")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                        image?
                        .resizable()
                        .scaledToFit()
                }.onTapGesture {
                    showingImagePicker = true
                }
                
                HStack {
                    Text("Intensidade")
                    
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { _ in apply()}
                }.padding(.vertical)
                
                HStack {
                    Button {
                        showingFilterSheet = true
                    } label: {
                        Image(systemName: "camera.filters")
                            .font(.title)
                    }
                    
                    Spacer()
                    
                    Button {
                        save()
                    } label: {
                        Image(systemName: "square.and.arrow.down")
                            .font(.title)
                    }
                    .disabled(saveButtonDisable)
                }
                
            }.padding([.horizontal, .bottom])
                .navigationTitle("InstaFilter")
                .onChange(of: inputImage) { _ in load()}
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $inputImage)
                }
                .confirmationDialog("Select a Filter", isPresented: $showingFilterSheet) {
                    Button("Chrome") { setFilter(CIFilter.photoEffectChrome())}
                    Button("Crystallize") { setFilter(CIFilter.crystallize())}
                    Button("Edges") { setFilter(CIFilter.edges())}
                    Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur())}
                    Button("Kaleidoscope") { setFilter(CIFilter.kaleidoscope())}
                    Button("Pixellate") { setFilter(CIFilter.pixellate())}
                    Button("Sepia Tone") { setFilter(CIFilter.sepiaTone())}
                    Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask())}
                    Button("Vignette") { setFilter(CIFilter.vignette())}
                    Button("Cancel", role: .cancel) { }
                }
        }
      }
    
    func load() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        apply()
    }
    
    func save() {
        guard let processedImage = processedImage else { return }
        
        let imageSaver = ImageSaver()
        imageSaver.successHandler = {
            print("Successo!")
        }
        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
        }
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func apply() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
            saveButtonDisable = false
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        load()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
