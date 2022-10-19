//
//  ExibirCentrosEsportivos.swift
//  MiniChallenge1
//
//  Created by Julia Mendes on 14/09/22.
//

import SwiftUI
import MapKit

struct CentroEsportivoCDistancia: Identifiable {
    var id = UUID()
    var centroEsportivo: CentroEsportivo
    var distancia: Double
}

struct ExibirCentrosEsportivos: View {
    
    @Binding var buscaSolicitada: String
    @Binding var categoriasSelecionadas: [String]
    @Binding var zonasSelecionadas: [String]
    
    //Variáveis auxiliares das funções dessa struct
    @State var zonasFormatadas: [String] = []
    @State var centroEsportivoCDistanciaAtual = CentroEsportivoCDistancia(
        centroEsportivo: DataLoader().centrosEsportivos[0],
        distancia: 0.0)
    @State var centroEsportivoMostrando = false
    @Binding var centroEsportivoCDistancia: [CentroEsportivoCDistancia]
    
    @Binding var centrosEsportivos: [CentroEsportivo]
    @Binding var latitude: Double
    @Binding var longitude: Double
    
    var body: some View {
        ScrollView{
            VStack {
                //NavigationLink que envia o usuário para tela de detalhes do centro esportivo com o centroEsportivoAtual como parâmetro
                NavigationLink(destination: DetalhesSheet(centroEsportivoCDistancia: $centroEsportivoCDistanciaAtual), isActive: $centroEsportivoMostrando, label: {})
                
                if !centrosEsportivos.isEmpty {
                    ForEach(centroEsportivoCDistancia, id:\.centroEsportivo.ceId) { centroEsportivoCDistancia in
                        Divider()
                        //Botão de cada centro esportivo, ao clicar nele abre uma sheet.
                        Button(action: {
                            self.centroEsportivoMostrando = true
                            self.centroEsportivoCDistanciaAtual = centroEsportivoCDistancia
                            self.endEditing()
                        }, label: {
                            centroEsportivoDados(
                                title: centroEsportivoCDistancia.centroEsportivo.ceNome,
                                subTitle: centroEsportivoCDistancia.centroEsportivo.ceEndereco.endereco,
                                zona: centroEsportivoCDistancia.centroEsportivo.ceZona,
                                modalidades: selecionaCategoriasDeposito(modalidades: centroEsportivoCDistancia.centroEsportivo.ceModalidades),
                                distancia: centroEsportivoCDistancia.distancia / 1000
                                )
                        })
                        
                    }
                } else {
                    Text("Não há Centros Esportivos disponíveis com essas informações.")
                }
                
            }
            .padding(.top, 2)
            .padding([.leading, .trailing], 15)
            .onChange(of: self.latitude) { _ in
                selecionaCentrosEsportivos()
            }
            .onChange(of: self.categoriasSelecionadas) { _ in
                //Caso o usuário use filtro por categorias, essa função será ativada
                selecionaCentrosEsportivos()
            }
            .onChange(of: self.zonasSelecionadas) { _ in
                //Caso o usuário use filtro por zonas, essa função será ativada
                selecionaCentrosEsportivos()
            }
            .onChange(of: self.buscaSolicitada) { _ in
                //Caso o usuário faca alguma busca na searchbar, essa função será ativada
                selecionaCentrosEsportivos()
            }
            .onAppear {
                selecionaCentrosEsportivos()
            }
            
        }
    }
    
    func selecionaCentrosEsportivos() {
        
        
        //Zerando todos itens dentro dessas arrays para que não ocorra duplicidade
        self.centroEsportivoCDistancia = []
        self.centrosEsportivos = []
        
        for centroEsportivo in DataLoader().centrosEsportivos {
            self.centrosEsportivos.append(centroEsportivo)
            
            //Adicionando centro esportivo e distancia à variável tuple
            let distancia = CLLocation(
                latitude: self.latitude,
                longitude: self.longitude).distance(
                    from: CLLocation(
                        latitude: Double(centroEsportivo.ceEndereco.latitude) ?? 0.0,
                        longitude: Double(centroEsportivo.ceEndereco.longitude) ?? 0.0
                    )
                )
            
            self.centroEsportivoCDistancia.append(CentroEsportivoCDistancia(centroEsportivo: centroEsportivo, distancia: Double(distancia)))
        }
        
        
        filtraPorCategoria()
        
        //Chamando formataZonas para utilizar zonasFormatadas como variável auxiliar no filtro dos centros esportivos
        formataZonas()
        
        filtraPorZonas()
        
        filtraPorBusca()
        
        ordenaCentrosEsportivosPDistancia()
    }
    
    func filtraPorCategoria() {
        if(!self.categoriasSelecionadas.isEmpty) {
            
            //Criando uma array auxiliar de centros esportivos com distancias
            var centrosEsportivosCDistanciaAux = [CentroEsportivoCDistancia]()
            var centrosEsportivosAux = [CentroEsportivo]()
            
            //Se o centro esportivo tiver alguma categoria contida na array de categorias selecionadas
            for centroEsportivo in self.centrosEsportivos {
                for modalidade in centroEsportivo.ceModalidades {
                    if categoriasSelecionadas.contains(modalidade.categoria) {
                        
                        
                        centrosEsportivosAux.append(centroEsportivo)
                        
                        //Adicionando centro esportivo e distancia à variável tuple
                        let distancia = CLLocation(
                            latitude: self.latitude,
                            longitude: self.longitude).distance(
                                from: CLLocation(
                                    latitude: Double(centroEsportivo.ceEndereco.latitude) ?? 0.0,
                                    longitude: Double(centroEsportivo.ceEndereco.longitude) ?? 0.0
                                )
                            )
                        self.centroEsportivoCDistancia.append(CentroEsportivoCDistancia(centroEsportivo: centroEsportivo, distancia: Double(distancia)))
                        
                        centrosEsportivosCDistanciaAux.append(CentroEsportivoCDistancia(centroEsportivo: centroEsportivo, distancia: Double(distancia)))
                        
                        break
                        
                    }
                }
            }
            
            //Atribuindo a array de centros esportivos filtrados a array principal de centros esportivos
            self.centrosEsportivos = centrosEsportivosAux
            self.centroEsportivoCDistancia = centrosEsportivosCDistanciaAux
            
        }
    }

    func filtraPorZonas() {
        if(!self.zonasFormatadas.isEmpty) {
            
            //Criando uma array auxiliar de centros esportivos para ajudar na filtragem
            var centrosEsportivosCDistanciaAux = [CentroEsportivoCDistancia]()
            var centrosEsportivosAux = [CentroEsportivo]()
            
            //Se o centro esportivo for da zona contida na array de zonas selecionadas
            for centroEsportivo in self.centrosEsportivos {
                if self.zonasFormatadas.contains(centroEsportivo.ceZona) {
                    
                    centrosEsportivosAux.append(centroEsportivo)
                    
                    //Adicionando centro esportivo e distancia à variável tuple
                    let distancia = CLLocation(
                        latitude: self.latitude,
                        longitude: self.longitude).distance(
                            from: CLLocation(
                                latitude: Double(centroEsportivo.ceEndereco.latitude) ?? 0.0,
                                longitude: Double(centroEsportivo.ceEndereco.longitude) ?? 0.0
                            )
                        )
                    centrosEsportivosCDistanciaAux.append(CentroEsportivoCDistancia(centroEsportivo: centroEsportivo, distancia: Double(distancia)))
                }
            }
            //Atribuindo a array de centros esportivos filtrados a array principal de centros esportivos
            self.centrosEsportivos = centrosEsportivosAux
            self.centroEsportivoCDistancia = centrosEsportivosCDistanciaAux
        }
    }
    
    func filtraPorBusca() {
        if(self.buscaSolicitada != "") {
            
            //Criando uma array auxiliar de centros esportivos para ajudar na filtragem
            var centrosEsportivosAux = [CentroEsportivo]()
            var centrosEsportivosCDistanciaAux = [CentroEsportivoCDistancia]()
            
            //Fazendo a verificação dos itens do centro esportivos que tem relação com o que o usuário digitou
            for centroEsportivo in self.centrosEsportivos {
                
                //Criando a variável auxiliar para permitir que continue fazendo a filtragem caso ainda não tenha achado nada com relação ao centro esportivo
                var continuaFiltragem = true
                
                //Verificando pelas modalidades
                for modalidade in centroEsportivo.ceModalidades {
                    if (modalidade.modalidade.lowercased().contains(self.buscaSolicitada.lowercased()) || modalidade.categoria.lowercased().contains(self.buscaSolicitada.lowercased())) && continuaFiltragem  {
                        
                        centrosEsportivosAux.append(centroEsportivo)
                        
                        //Adicionando centro esportivo e distancia à variável tuple
                        let distancia = CLLocation(
                            latitude: self.latitude,
                            longitude: self.longitude).distance(
                                from: CLLocation(
                                    latitude: Double(centroEsportivo.ceEndereco.latitude) ?? 0.0,
                                    longitude: Double(centroEsportivo.ceEndereco.longitude) ?? 0.0
                                )
                            )
                        centrosEsportivosCDistanciaAux.append(CentroEsportivoCDistancia(centroEsportivo: centroEsportivo, distancia: Double(distancia)))
                        
                        continuaFiltragem = false
                        break
                        
                    }
                }
                
                //Verificando pelas estruturas
                for estrutura in centroEsportivo.ceEstrutura {
                    if estrutura.nomeEstrutura.lowercased().contains(self.buscaSolicitada.lowercased()) && continuaFiltragem {
                        
                        centrosEsportivosAux.append(centroEsportivo)
                        
                        //Adicionando centro esportivo e distancia à variável tuple
                        let distancia = CLLocation(
                            latitude: self.latitude,
                            longitude: self.longitude).distance(
                                from: CLLocation(
                                    latitude: Double(centroEsportivo.ceEndereco.latitude) ?? 0.0,
                                    longitude: Double(centroEsportivo.ceEndereco.longitude) ?? 0.0
                                )
                            )
                        centrosEsportivosCDistanciaAux.append(CentroEsportivoCDistancia(centroEsportivo: centroEsportivo, distancia: Double(distancia)))
                        
                        continuaFiltragem = false
                        break
                        
                    }
                }
                
                //Verificando pelo nome e endereço do centro esportivo
                if (centroEsportivo.ceNome.lowercased().contains(self.buscaSolicitada.lowercased())
                    || centroEsportivo.ceEndereco.endereco.lowercased().contains(self.buscaSolicitada.lowercased())) && continuaFiltragem {
                    
                    centrosEsportivosAux.append(centroEsportivo)
                    
                    //Adicionando centro esportivo e distancia à variável tuple
                    let distancia = CLLocation(
                        latitude: self.latitude,
                        longitude: self.longitude).distance(
                            from: CLLocation(
                                latitude: Double(centroEsportivo.ceEndereco.latitude) ?? 0.0,
                                longitude: Double(centroEsportivo.ceEndereco.longitude) ?? 0.0
                            )
                        )
                    centrosEsportivosCDistanciaAux.append(CentroEsportivoCDistancia(centroEsportivo: centroEsportivo, distancia: Double(distancia)))
                    
                    continuaFiltragem = false
                }
            }
            //Atribuindo a array de centros esportivos filtrados a array principal de centros esportivos
            self.centrosEsportivos = centrosEsportivosAux
            self.centroEsportivoCDistancia = centrosEsportivosCDistanciaAux
        }
    }
    
    //Variável criada para selecionar as categorias que vão aparecer como pré-visualização de cada centro esportivo
    func selecionaCategoriasDeposito(modalidades: [ModalidadeCentroEsportivo]) -> [String] {
        var categoriasSelecionadasPMiniaturas: [String] = []
        
        var cont = 0
        
        for modalidade in modalidades {
            categoriasSelecionadasPMiniaturas.append(modalidade.categoria)
            
            if cont > 6 {
                break
            }
            cont = cont + 1
        }
        
        return categoriasSelecionadasPMiniaturas
    }
    
    func ordenaCentrosEsportivosPDistancia() {
        self.centroEsportivoCDistancia = self.centroEsportivoCDistancia.sorted(by: { $0.distancia < $1.distancia })
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
    
    func centroEsportivoDados(title: String, subTitle: String, zona: String, modalidades: [String], distancia: Double) -> some View {
            HStack{
                Image(zona)
                .resizable()
                .frame(width: 60, height: 60)
                
                VStack(alignment: .leading) {
                    Text(title)
                    .foregroundColor(.black)
                    .font(.system(.headline , design: .rounded)) //MARK: ALTERACÃO FEITA
                    
                    Text(subTitle)
                        .font(.system(.subheadline, design: .rounded))  //MARK: ALTERACÃO FEITA
                        .foregroundColor(.gray)
                    
                    //Implementando miniaturas de categorias como pré-visualização
                    HStack {
                        ForEach(CategoriasCE.categorias.categoriasCE, id: \.idCategoria) { categoria in
                            if modalidades.contains(categoria.nomeCategoria) {
                                Image("\(categoria.nomePriImagem)")
                                    .resizable()
                                    .frame(width: 20, height: 20, alignment: .center)
                            }
                        }
                    }
                    .frame(alignment: .leading)
                }
                .frame(minHeight: 90, maxHeight: 90, alignment: .center)
                .multilineTextAlignment(.leading)
                .padding(5)
                Spacer()
                Divider()
                   .frame(height: 70)
                   .padding(.trailing)
                VStack {
                    Text(String(format: "%.1f", distancia))
                        .foregroundColor(.gray)
                        .font(.system(size: 23, weight: .regular, design: .rounded))  //MARK: ALTERACÃO FEITA
                    Text("km")
                        .foregroundColor(.gray)
                        .font(.system(size: 24, weight: .regular, design: .rounded))  //MARK: ALTERACÃO FEITA
                }
                .frame(maxWidth: 50)
            }
        }
    
    //Função utilizada para esconder o keyboard do dispositivo
    private func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


