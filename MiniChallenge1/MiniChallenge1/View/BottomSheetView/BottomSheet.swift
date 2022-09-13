//
//  BottomSheet.swift
//  MiniChallenge1
//
//  Created by Julia Mendes on 13/09/22.
//

import SwiftUI

struct BottomSheet: View {
    
    @GestureState var gestureOffset: CGFloat = 0
    @State var searchText = ""
    @State var offset: CGFloat = 0
    @State var lastOffset : CGFloat = 0
    
    var body: some View {
        GeometryReader{proxy -> AnyView in
            let height = proxy.frame(in: .global).height
            
            return AnyView(
                
                ZStack {
                    
                    BlurView(style: .systemMaterialLight)
                        .clipShape(CustomCorner(corners: [.topLeft,.topRight], radius: 30))
                    
                    VStack {
                        
                        //Icone arredondado
                        Capsule()
                            .fill(.white)
                            .frame(width: 80, height: 4)
                            .padding(.top)
                        HStack {
                            // Search Bar
                            TextField("Search", text: $searchText)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(BlurView(style: .dark))
                                .cornerRadius(10)
                                .colorScheme(.dark)
                                .padding(.top, 10)
                            
                            //Botão Filtro
                            Button(action: {}, label: {
                                Image(systemName: "chevron.left")
                                Text("Filtro")
                            })
                        }
                        // Conteudo da Sheet. Precisa ler os dados do JSON para fazer.
                        //BottomContent()
                        Text("Blablabla")
                        
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

//struct BottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomSheet()
//    }
//}
