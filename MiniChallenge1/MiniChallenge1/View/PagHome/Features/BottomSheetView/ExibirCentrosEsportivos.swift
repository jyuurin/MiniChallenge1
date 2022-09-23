//
//  ExibirCentrosEsportivos.swift
//  MiniChallenge1
//
//  Created by Julia Mendes on 14/09/22.
//

import SwiftUI

struct ExibirCentrosEsportivos: View {
    
    @State var centrosEsportivos = [CentroEsportivo]()
    @Binding var categoriasSelecionadas: [String]
    @Binding var zonasSelecionadas: [String]
    
    @State var zonasFormatadas: [String] = []
    
    var body: some View {
        ScrollView{
            VStack {
                ForEach(centrosEsportivos, id:\.ceId) { centroEsportivo in
                    centroEsportivoDados(title: centroEsportivo.ceNome, subTitle: centroEsportivo.ceEndereco.endereco)
                }
            }
            .onChange(of: self.categoriasSelecionadas) { _ in
                print("Ao mudar: \(categoriasSelecionadas)")
                selecionaCentrosEsportivos()
                print("Ja mudou: \(categoriasSelecionadas)")
            }
            .onChange(of: self.zonasSelecionadas) { _ in
                selecionaCentrosEsportivos()
            }
            .onAppear {
                selecionaCentrosEsportivos()
            }
            
        }
    }
    
    func selecionaCentrosEsportivos() {
        
        if(self.centrosEsportivos.isEmpty) {
            self.centrosEsportivos = DataLoader().centrosEsportivos
        }
        

        filtraPorCategoria()
        
        //Chamando formataZonas para utilizar zonasFormatadas como variável auxiliar no filtro dos centros esportivos
        formataZonas()
        
        print(zonasFormatadas)
        
        filtraPorZonas()
        
    }
    
    func filtraPorCategoria() {
        if(!self.categoriasSelecionadas.isEmpty) {
            
            var centrosEsportivosAux = [CentroEsportivo]()
            var apagaTudo = true
            
            for centroEsportivo in self.centrosEsportivos {
                for modalidade in centroEsportivo.ceModalidades {
                    if categoriasSelecionadas.contains(modalidade.categoria) {
                        centrosEsportivosAux.append(centroEsportivo)
                        
                        break
                    }
                }
            }
            
//            if apagaTudo {
//                self.centrosEsportivos = []
//            }
            
            print(centrosEsportivosAux)
            if !centrosEsportivosAux.isEmpty {
                self.centrosEsportivos = centrosEsportivosAux
            }
            
        } else {
            self.centrosEsportivos = DataLoader().centrosEsportivos
        }
    }
    
    func filtraPorZonas() {
        if(!self.zonasFormatadas.isEmpty) {
            
            var centrosEsportivosAux = [CentroEsportivo]()
            
            for centroEsportivo in self.centrosEsportivos {
                if self.zonasFormatadas.contains(centroEsportivo.ceZona) {
                    centrosEsportivosAux.append(centroEsportivo)
                }
            }
            
            print(centrosEsportivosAux)
            
            if !centrosEsportivosAux.isEmpty {
                self.centrosEsportivos = centrosEsportivosAux
            }
        }
    }
    
    func formataZonas() {
        
        self.zonasFormatadas = []
        
        
        //Formatando a array de zonas para conformar com as zonas contidas no JSON
        for zonaSelecionada in self.zonasSelecionadas {
            switch zonaSelecionada {
            case "Zona Sul":
                self.zonasFormatadas.append("zs")
            case "Zona Leste":
                self.zonasFormatadas.append("zl")
            case "Zona Oeste":
                self.zonasFormatadas.append("zo")
            case "Zona Norte":
                self.zonasFormatadas.append("zn")
            case "Região Central":
                self.zonasFormatadas.append("zc")
            default:
                print("Erro: A zona selecionada não está nos conformes.")
                break
            }
        }
        
    }
    
    func centroEsportivoDados(title: String, subTitle: String) -> some View {
        HStack{
            Rectangle()
                .foregroundColor(Color.gray)
                .cornerRadius(10)
                .frame(width: 100, height: 100)
            VStack(alignment: .leading) {
                Text(title)
                Text(subTitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
    
    
    
}

