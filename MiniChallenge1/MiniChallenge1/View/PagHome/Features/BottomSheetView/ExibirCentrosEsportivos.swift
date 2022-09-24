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
    
    @State var centroEsportivoMostrando: CentroEsportivo?
    
    var body: some View {
        ScrollView{
            VStack {
                ForEach(centrosEsportivos, id:\.ceId) { item in
                    //Botão de cada centro esportivo, ao clicar nele abre uma sheet.
                    Button(action: {centroEsportivoMostrando = item}, label: {
                        centroEsportivoDados(title: item.ceNome, subTitle: item.ceEndereco.endereco, zona: item.ceZona)
                    })
                    // se tem um item ele vai exibir uma sheet passando os dados dos centros esportivos para a DetalhesSheet.
                    .sheet(item: $centroEsportivoMostrando){ CE in
                        DetalhesSheet(centroEsportivo: CE)
                    }
                }
            }
            .onChange(of: self.categoriasSelecionadas) { _ in
                //Caso o usuário use filtro por categorias, essa função será ativada
                selecionaCentrosEsportivos()
            }
            .onChange(of: self.zonasSelecionadas) { _ in
                //Caso o usuário use filtro por zonas, essa função será ativada
                selecionaCentrosEsportivos()
            }
            .onAppear {
                selecionaCentrosEsportivos()
            }
            
        }
    }
    
    func selecionaCentrosEsportivos() {
        self.centrosEsportivos = DataLoader().centrosEsportivos
        
        filtraPorCategoria()
        
        //Chamando formataZonas para utilizar zonasFormatadas como variável auxiliar no filtro dos centros esportivos
        formataZonas()
        
        filtraPorZonas()
        
    }
    
    func filtraPorCategoria() {
        if(!self.categoriasSelecionadas.isEmpty) {
            
            //Criando uma array auxiliar de centros esportivos para ajudar na filtragem
            var centrosEsportivosAux = [CentroEsportivo]()
            
            //Se o centro esportivo tiver alguma categoria contida na array de categorias selecionadas
            for centroEsportivo in self.centrosEsportivos {
                for modalidade in centroEsportivo.ceModalidades {
                    if categoriasSelecionadas.contains(modalidade.categoria) {
                        centrosEsportivosAux.append(centroEsportivo)
                        break
                    }
                }
            }
            //Atribuindo a array de centros esportivos filtrados a array principal de centros esportivos
            self.centrosEsportivos = centrosEsportivosAux
            
        }
    }

    func filtraPorZonas() {
        if(!self.zonasFormatadas.isEmpty) {
            
            //Criando uma array auxiliar de centros esportivos para ajudar na filtragem
            var centrosEsportivosAux = [CentroEsportivo]()
            
            //Se o centro esportivo for da zona contida na array de zonas selecionadas
            for centroEsportivo in self.centrosEsportivos {
                if self.zonasFormatadas.contains(centroEsportivo.ceZona) {
                    centrosEsportivosAux.append(centroEsportivo)
                }
            }
            //Atribuindo a array de centros esportivos filtrados a array principal de centros esportivos
            self.centrosEsportivos = centrosEsportivosAux
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
    
    func centroEsportivoDados(title: String, subTitle: String, zona: String) -> some View {
        HStack{
            Image(zona)
                .resizable()
                .frame(width: 60, height: 60)
            VStack(alignment: .leading) {
                Text(title)
                Text(subTitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .multilineTextAlignment(.leading)
            .padding(5)
            Spacer()
        }
    }
}


