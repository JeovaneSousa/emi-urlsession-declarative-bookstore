//
//  LivrosAPI.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import Foundation

class LivrosAPI {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    private var dataTask: URLSessionDataTask?
    
    init(session: URLSession = URLSession.shared,
         decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    
    func carregaTodos() -> [Livro] {
        return [
            Livro(titulo: "Orientação a Objetos",
                  subtitulo: "Aprenda seus conceitos e suas aplicabilidades de forma efetiva",
                  imagemDeCapaURI: URL(string: "https://cdn.shopify.com/s/files/1/0155/7645/products/OrientacaoaObjetos_ebook_large.jpg")!,
                  autor: Autor(foto: URL(string: "https://user-images.githubusercontent.com/13206745/114415776-622d7000-9b86-11eb-9920-92e27e199fd7.jpeg")!,
                               nome: "Alberto", sobrenome: "Souza",
                               bio: "Minha vida é andar por esse país pra ver se um dia descanso feliz, guardando as recordações das terras onde passei andando pelos sertões e dos amigos que lá deixei. Chuva e sol, poeira e carvão, longe de casa sigo o roteiro mais uma estação. E alegria no coração!",
                               tecnologias: ["Java", "Spring", "Spring Cloud", "Play", "Block Chain"]),
                 precos: [
                    Preco(valor: 19.9, tipoDeLivro: .ebook),
                    Preco(valor: 29.9, tipoDeLivro: .impresso),
                    Preco(valor: 39.9, tipoDeLivro: .combo),
                 ]),
            Livro(titulo: "ECMAScript 6",
                  subtitulo: "Descubra as novas features desta versão e entre de cabeça no futuro do JavaScript",
                  imagemDeCapaURI: URL(string: "https://cdn.shopify.com/s/files/1/0155/7645/products/cover_2e45900d-58d2-44d1-a77b-2aa1c5c992c0_large.jpg")!,
                  autor: Autor(foto: URL(string: "https://avatars.githubusercontent.com/u/21271121?v=4")!,
                               nome: "Paula", sobrenome: "Santana",
                               bio: "Eu gosto de artes marciais, sou graduada em Judô e Kickboxing. Adoro participar de comunidades de tecnologia especialmente voltadas para minorias. Sou apaixonada por viajar, gosto de praia e surf. Sou Eclética em música, adoro Queen e Emicida.",
                               tecnologias: ["Java", "Spring", "Kotlin", "Micronaut"]),
                  precos: [
                     Preco(valor: 19.9, tipoDeLivro: .ebook),
                     Preco(valor: 29.9, tipoDeLivro: .impresso),
                     Preco(valor: 39.9, tipoDeLivro: .combo),
                  ]),
            Livro(titulo: "React Native",
                  subtitulo: "Desenvolvimento de aplicativos mobile com React",
                  imagemDeCapaURI: URL(string: "https://cdn.shopify.com/s/files/1/0155/7645/products/ReactNative_ebook_large.jpg")!,
                  autor: Autor(foto: URL(string: "https://user-images.githubusercontent.com/13206745/114415754-5c378f00-9b86-11eb-996d-4d42858ad3c1.jpeg")!,
                               nome: "Rafael", sobrenome: "Rollo",
                               bio: "Um desenvolvedor que adora o que faz tanto quanto a música e o futebol e admira qualquer outra manifestação através da qual pessoas apaixonadas expressam sua essência.",
                               tecnologias: ["Swift", "iOS", "React Native", "Java", "Spring"]),
                  precos: [
                     Preco(valor: 19.9, tipoDeLivro: .ebook),
                     Preco(valor: 29.9, tipoDeLivro: .impresso),
                     Preco(valor: 39.9, tipoDeLivro: .combo),
                  ]),
            Livro(titulo: "Orientação a Objetos e SOLID para Ninjas",
                  subtitulo: "Projetando classes flexíveis",
                  imagemDeCapaURI: URL(string: "https://cdn.shopify.com/s/files/1/0155/7645/products/OrientacaoaObjetoseSOLIDparaNinjas_ebook_large.jpg")!,
                  autor: Autor(foto: URL(string: "https://lh3.googleusercontent.com/a-/AD5-WCnjn9OxGl0GxqgtVxsRYwsJVuSqFAWCsQXyCcD0=s64-p")!,
                               nome: "Rafael", sobrenome: "Ponte",
                               bio: "Príncipe do Oceano, Marajá dos Legados e Rei das Gambiarras; Engenheiro de software cansado e crossfiteiro com 5 gatos. Também um podcaster frustrado no @devscansados.",
                               tecnologias: ["Java", "Spring", "Hibernate", "Kotlin", "Micronaut"]),
                  precos: [
                     Preco(valor: 19.9, tipoDeLivro: .ebook),
                     Preco(valor: 29.9, tipoDeLivro: .impresso),
                     Preco(valor: 39.9, tipoDeLivro: .combo),
                  ]),
            Livro(titulo: "Play Framework",
                  subtitulo: "Java para web sem Servlets e com diversão",
                  imagemDeCapaURI: URL(string: "https://cdn.shopify.com/s/files/1/0155/7645/products/PlayFramework_ebook_large.jpg")!,
                  autor: Autor(foto: URL(string: "https://lh3.googleusercontent.com/a-/AD5-WCkgw0YnjfCnyUo84QN7ZcD224pYuiHR2n7EujAFsg=s64-p")!,
                               nome: "Yuri", sobrenome: "Matheus",
                               bio: "Eu sou apenas um rapaz latino-americano, sem dinheiro no banco, sem parentes importantes, e vindo do interior. Mas trago de cabeça uma canção do rádio em que um antigo compositor baiano me dizia: Tudo é divino tudo é maravilhoso!",
                               tecnologias: ["Java", "Spring", "Kotlin", "Micronaut"]),
                  precos: [
                     Preco(valor: 19.9, tipoDeLivro: .ebook),
                     Preco(valor: 29.9, tipoDeLivro: .impresso),
                     Preco(valor: 39.9, tipoDeLivro: .combo),
                  ]),
            Livro(titulo: "Spring MVC",
                  subtitulo: "Domine o principal framework web Java",
                  imagemDeCapaURI: URL(string: "https://m.media-amazon.com/images/I/41MdyrEql0L.jpg")!,
                  autor: Autor(foto: URL(string: "https://lh3.googleusercontent.com/a-/AD5-WCky6B5bGCbu0Dn7nnQbYXlS-t-5fWBXbcBbeyR3=s64-p")!,
                               nome: "Lucas", sobrenome: "Félix",
                               bio: "Prepare o seu coração pras coisas que eu vou contar. Eu venho lá do sertão e posso não lhe agradar. Aprendi a dizer não, ver a morte sem chorar. E a morte, o destino, tudo. Estava fora do lugar e eu vivo pra consertar.",
                               tecnologias: ["Java", "Spring", "Kotlin", "Micronaut"]),
                  precos: [
                     Preco(valor: 19.9, tipoDeLivro: .ebook),
                     Preco(valor: 29.9, tipoDeLivro: .impresso),
                     Preco(valor: 39.9, tipoDeLivro: .combo),
                  ]),
            Livro(titulo: "Kotlin com Android",
                  subtitulo: "Crie aplicativos de maneira fácil e divertida",
                  imagemDeCapaURI: URL(string: "https://cdn.shopify.com/s/files/1/0155/7645/products/KotlincomAndroid_ebook_large.jpg")!,
                  autor: Autor(foto: URL(string: "https://lh3.googleusercontent.com/a-/AD5-WCkG4BrYKOAZ9sp_wPucqOKOMdkU2DWH6-fC4zB-=s64-p")!,
                               nome: "Jordi", sobrenome: "Silva",
                               bio: "Eu sou terrível, vou lhe dizer, e ponho mesmo, pra derreter. Estou com a razão no que digo, não tenho medo nem do perigo, minha caranga é maquina quente. Eu sou terrível!",
                               tecnologias: ["Java", "Spring", "Kotlin", "Micronaut"]),
                  precos: [
                     Preco(valor: 19.9, tipoDeLivro: .ebook),
                     Preco(valor: 29.9, tipoDeLivro: .impresso),
                     Preco(valor: 39.9, tipoDeLivro: .combo),
                  ]),
            Livro(titulo: "Entrega contínua em Android",
                  subtitulo: "Como automatizar a distribuição de apps",
                  imagemDeCapaURI: URL(string: "https://cdn.shopify.com/s/files/1/0155/7645/products/cover_c9e53787-9bf8-48e1-ae67-15b77980654f_large.jpg")!,
                  autor: Autor(foto: URL(string: "https://lh3.googleusercontent.com/a-/AD5-WCkrsss7ozq32EAjiugkUJd5x1CuAy1Ox3eC8Ug9=s64-p-k-rw-no")!,
                               nome: "Matheus Henrique", sobrenome: "Santos",
                               bio: "Eu nasci há dez mil anos atrás e não tem nada nesse mundo que eu não saiba demais. Eu vi as velas se acenderem para o Papa, vi Babilônia ser riscada do mapa. Vi conde Drácula sugando o sangue novo e se escondendo atrás da capa.",
                               tecnologias: ["Java", "Spring", "Kotlin", "Micronaut"]),
                  precos: [
                     Preco(valor: 19.9, tipoDeLivro: .ebook),
                     Preco(valor: 29.9, tipoDeLivro: .impresso),
                     Preco(valor: 39.9, tipoDeLivro: .combo),
                  ]),
            Livro(titulo: "Flutter Framework",
                  subtitulo: "Desenvolva aplicações móveis no Dart Side!",
                  imagemDeCapaURI: URL(string: "https://cdn.shopify.com/s/files/1/0155/7645/products/IniciandocomFlutterFramework_ebook_large.jpg")!,
                  autor: Autor(foto: URL(string: "https://user-images.githubusercontent.com/13206745/114415801-678aba80-9b86-11eb-9ad0-1986b12a42e6.jpeg")!,
                               nome: "Matheus", sobrenome: "Brandino",
                               bio: "Tem lugares que me lembram minha vida, por onde andei. As histórias, os caminhos, o destino que eu mudei... Cenas do meu filme em branco e preto que o vento levou e o tempo traz.",
                               tecnologias: ["Java", "Kotlin", "Android", "Flutter"]),
                  precos: [
                     Preco(valor: 19.9, tipoDeLivro: .ebook),
                     Preco(valor: 29.9, tipoDeLivro: .impresso),
                     Preco(valor: 39.9, tipoDeLivro: .combo),
                  ]),
        ]
    }
    
    func carregaLivros(porAutorId id: Int,
                       completionHandler: @escaping ([Livro]) -> Void,
                       failureHandler: @escaping (LivrosAPI.Error) -> Void) {
        dataTask?.cancel()
        
        let url = URL(string: "https://casadocodigo-api.herokuapp.com/api/author/\(id)/books")!
        
        dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    failureHandler(.falhaAoProcessarRequisicao(error))
                }
                return
            }
            
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                DispatchQueue.main.async {
                    failureHandler(.falhaAoObterResposta)
                }
                return
            }
                
            do {
                guard let self = self else { return }
                
                let livros = try self.decoder.decode([Livro].self, from: data)
                
                DispatchQueue.main.async {
                    completionHandler(livros)
                }
                
            } catch let error {
                print(error)
                DispatchQueue.main.async {
                    failureHandler(.dadosInvalidos)
                }
            }
        }
        
        dataTask?.resume()
    }
    
}

extension LivrosAPI {
    typealias SError = Swift.Error
    
    enum Error: SError, LocalizedError {
        case falhaAoProcessarRequisicao(SError)
        case falhaAoObterResposta
        case dadosInvalidos
        
        var errorDescription: String? {
            switch self {
            case .falhaAoProcessarRequisicao(let error):
                return "Erro ao processar a requisição \(error.localizedDescription)"
                
            case .falhaAoObterResposta:
                return "Erro ao obter resposta do servidor"
                
            case .dadosInvalidos:
                return "Os dados recebidos do servidor são inválidos"
            }
        }
    }
}
