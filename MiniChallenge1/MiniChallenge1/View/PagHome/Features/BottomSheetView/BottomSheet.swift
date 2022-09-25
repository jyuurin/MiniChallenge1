//
//  BottomSheet.swift
//  MiniChallenge1
//
//  Created by Julia Mendes on 13/09/22.
//

import SwiftUI

struct BottomSheet: View {
    
    @GestureState var gestureOffset: CGFloat = 0
    @State var offset: CGFloat = 0
    @State var lastOffset : CGFloat = 0
    @State var mostraFiltroCategoria = false
    @State var mostraFiltroZonas = false
    
    @State var categoriasSelecionadas: [String] = []
    @State var zonasSelecionadas: [String] = []
    @State var buscaSolictada: String = ""
    
    
    var body: some View {
        GeometryReader{proxy -> AnyView in
            let height = proxy.frame(in: .global).height
            
            return AnyView(
                
                ZStack {
                    
                    //Setando o estilo da sheetView
                    BlurView(style: .light)
                    .background(Color.white)
                    .clipShape(CustomCorner(corners: [.topLeft,.topRight], radius: 10))
                        
                    
                    VStack {
                        
                        //Icone arredondado
                        Capsule()
                        .fill(Color.init(UIColor.systemGray4))
                        .frame(width: 50, height: 4)
                        .padding(.top, 10)
                        
                        VStack {
                            //MARK: - Search Bar
                            TextField("Exemplo: *Nome do CE*; Piscina; Futebol", text: $buscaSolictada)
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
                                        Text("Categorias")
                                        Image(systemName: "chevron.down")
                                    })
                                    .foregroundColor(CoresApp.corPrincipal.cor())
                                    .padding(5)
                                    .overlay(RoundedRectangle(cornerRadius: 5)
                                        .stroke(CoresApp.corPrincipal.cor(), lineWidth: 1))
                                    .sheet(isPresented: $mostraFiltroCategoria, content: {
                                        FiltroCategoriaView(arrayCategorias: $categoriasSelecionadas)
                                    })
                                    
                                } else {
                                    
                                    Button(action: {
                                        self.mostraFiltroCategoria.toggle()
                                    }, label: {
                                        Text("Categorias")
                                        Image(systemName: "chevron.down")
                                    })
                                    .padding(5)
                                    .background(CoresApp.corPrincipal.cor())
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                                    .sheet(isPresented: $mostraFiltroCategoria, content: {
                                        FiltroCategoriaView(arrayCategorias: $categoriasSelecionadas)
                                    })
                                    
                                }
                                
                                if !self.zonasSelecionadas.isEmpty {
                                    Button(action: {
                                        self.mostraFiltroZonas = true
                                    }, label: {
                                        Text("Local")
                                        Image(systemName: "chevron.down")
                                    })
                                    .padding(5)
                                    .background(CoresApp.corPrincipal.cor())
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                                    .sheet(isPresented: $mostraFiltroZonas, content: {
                                        FiltroZonaView(zonasSelecionadas: $zonasSelecionadas)
                                    })
                                
                                } else { 
                                    Button(action: {
                                        self.mostraFiltroZonas = true
                                    }, label: {
                                        
                                        
                                        Text("Local")
                                        Image(systemName: "chevron.down")
                                    })
                                    .foregroundColor(CoresApp.corPrincipal.cor())
                                    .padding(5)
                                    .overlay(RoundedRectangle(cornerRadius: 5)
                                        .stroke(CoresApp.corPrincipal.cor(), lineWidth: 1))
                                    .sheet(isPresented: $mostraFiltroZonas, content: {
                                        FiltroZonaView(zonasSelecionadas: $zonasSelecionadas)
                                    })
                                }
                                
                                Spacer()
                            }
                            .padding(.vertical, 5)
                        }
                        
                        //Conteudo da bottomsheet
                        ExibirCentrosEsportivos(buscaSolicitada: $buscaSolictada, categoriasSelecionadas: $categoriasSelecionadas, zonasSelecionadas: $zonasSelecionadas)
                        
                    
                    }
                    .padding(.horizontal)
                    //Define tamanho
                    .frame(maxHeight: .infinity, alignment: .top)
                }
                //Offset desloca o visual do objeto
                .offset(y: height - 100)
                // conta doida pra fazer a sheet travar em baixo, não fica solta.
                .offset(y: -offset > 0 ? -offset <= (height - 100) ? offset : -(height - 100) : 0)
                .gesture(DragGesture().updating($gestureOffset, body: {
                    value, out, _ in
                    
                    out = value.translation.height
                    onChange()
                }).onEnded({ value in
                    //Função que executa quando o usuario deixa de arrastar
                    let maxHeight = height - 100
                    
                    withAnimation{
                        // condicoes para mover
                        // cima baixo ou meio
                        if -offset > 100 && -offset < maxHeight / 2 {
                            // meio
                            offset = -(maxHeight / 3)
                        }
                        else if -offset > maxHeight / 2 {
                            offset = -maxHeight
                        }
                        else {
                            offset = 0
                        }
                    }
                    // guardando a ultima offset, pra ficar a ultima posicao
                    lastOffset = offset
                }))
                    
            )
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    func onChange() {
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet()
    }
}
