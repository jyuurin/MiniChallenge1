//
//ExibicaoListaCEs.swift
//SPorts
//
//Created by Julia Mendes on 10/10/22.


import SwiftUI

struct ExibicaoListaCEs: View {
    @State var offset: CGFloat = 0
    @State var lastOffset : CGFloat = 0
    @State var mostraFiltroCategoria = false
    @State var mostraFiltroZonas = false
    
    @State var categoriasSelecionadas: [String] = []
    @State var zonasSelecionadas: [String] = []
    @State var buscaSolictada: String = ""
    
    @Binding var centrosEsportivos: [CentroEsportivo]
    
    @Binding var latitude: Double
    @Binding var longitude: Double
    
    var body: some View {
        
        VStack {
            VStack {
                
                //MARK: - Search Bar
                TextField("Nome do Centro Esportivo; Piscina; Futebol", text: $buscaSolictada)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.init(UIColor.systemGray6))
                    .cornerRadius(10)

                //MARK: - botões de filtro
                HStack {
                    
                    if self.categoriasSelecionadas.isEmpty {
                        
                        Button(action: {
                            self.mostraFiltroCategoria.toggle()
                        }, label: {
                            HStack {
                                Text("Categorias")
                                Image(systemName: "chevron.down")
                            }
                            .foregroundColor(CoresApp.corPrincipal.cor())
                            .padding(5)
                            .overlay(RoundedRectangle(cornerRadius: 5)
                                        .stroke(CoresApp.corPrincipal.cor(), lineWidth: 1))
                        })
                            .sheet(isPresented: $mostraFiltroCategoria, content: {
                                FiltroCategoriaView(arrayCategorias: $categoriasSelecionadas)
                            })
                        
                    } else {
                        
                        Button(action: {
                            self.mostraFiltroCategoria.toggle()
                            self.endEditing()
                        }, label: {
                            HStack {
                                Text("Categorias")
                                Image(systemName: "chevron.down")
                            }
                            .padding(5)
                            .background(CoresApp.corPrincipal.cor())
                            .foregroundColor(.white)
                            .cornerRadius(5)
                        })
                        
                            .sheet(isPresented: $mostraFiltroCategoria, content: {
                                FiltroCategoriaView(arrayCategorias: $categoriasSelecionadas)
                            })
                        
                    }
                    
                    if !self.zonasSelecionadas.isEmpty {
                        Button(action: {
                            self.mostraFiltroZonas = true
                            self.endEditing()
                        }, label: {
                            HStack {
                                Text("Local")
                                Image(systemName: "chevron.down")
                            }
                            .padding(5)
                            .background(CoresApp.corPrincipal.cor())
                            .foregroundColor(.white)
                            .cornerRadius(5)
                            
                        })
                            .sheet(isPresented: $mostraFiltroZonas, content: {
                                FiltroZonaView(zonasSelecionadas: $zonasSelecionadas)
                            })
                        
                    } else {
                        Button(action: {
                            self.mostraFiltroZonas = true
                            self.endEditing()
                        }, label: {
                            HStack {
                                Text("Zonas")
                                Image(systemName: "chevron.down")
                            }
                            .foregroundColor(CoresApp.corPrincipal.cor())
                            .padding(5)
                            .overlay(RoundedRectangle(cornerRadius: 5)
                                        .stroke(CoresApp.corPrincipal.cor(), lineWidth: 1))
                        })
                            .sheet(isPresented: $mostraFiltroZonas, content: {
                                FiltroZonaView(zonasSelecionadas: $zonasSelecionadas)
                            })
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 5)
            }
            
                    ScrollView {
                        ExibirCentrosEsportivos(buscaSolicitada: $buscaSolictada, categoriasSelecionadas: $categoriasSelecionadas, zonasSelecionadas: $zonasSelecionadas, centrosEsportivos: $centrosEsportivos, latitude: $latitude, longitude: $longitude)
                        
                        
                    }
                    
        }
        .padding()
        .edgesIgnoringSafeArea(.bottom)
        

        
        
        
    }
    
    //Função utilizada para esconder o keyboard do dispositivo
    private func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

