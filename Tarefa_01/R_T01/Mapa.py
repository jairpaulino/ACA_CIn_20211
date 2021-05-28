from Adjacente import Adjacente
from Estacao import Estacao

class Mapa:
    
    E01 = Estacao("E01", 27.3)
    E02 = Estacao("E02", 20.9)
    E03 = Estacao("E03", 19.1)
    E04 = Estacao("E04", 18.6)
    E05 = Estacao("E05", 24.8)
    E06 = Estacao("E06", 27.6)
    E07 = Estacao("E07", 25.7)
    E08 = Estacao("E08", 6.4)
    E09 = Estacao("E09", 10.9)
    E10 = Estacao("E10", 24.2)
    E11 = Estacao("E11", 14.2)
    E12 = Estacao("E12", 0)   
    E13 = Estacao("E13", 28.8)
    E14 = Estacao("E14", 33.6)
    
    E01.addEstacaoAdjacente(Adjacente(E02, 10))
    
    E02.addEstacaoAdjacente(Adjacente(E01, 10))
    E02.addEstacaoAdjacente(Adjacente(E03, 8.5))
    E02.addEstacaoAdjacente(Adjacente(E09, 10))
    E02.addEstacaoAdjacente(Adjacente(E10, 3.5))
    
    E03.addEstacaoAdjacente(Adjacente(E02, 8.5))
    E03.addEstacaoAdjacente(Adjacente(E04, 6.3))
    E03.addEstacaoAdjacente(Adjacente(E09, 9.4))
    E03.addEstacaoAdjacente(Adjacente(E13, 18.7))

    E04.addEstacaoAdjacente(Adjacente(E03, 6.3))
    E04.addEstacaoAdjacente(Adjacente(E05, 13))
    E04.addEstacaoAdjacente(Adjacente(E08, 15.3))
    E04.addEstacaoAdjacente(Adjacente(E13, 12.8))
    
    E05.addEstacaoAdjacente(Adjacente(E04, 13))
    E05.addEstacaoAdjacente(Adjacente(E06, 3))
    E05.addEstacaoAdjacente(Adjacente(E07, 2.4))
    E05.addEstacaoAdjacente(Adjacente(E08, 30))
    
    E06.addEstacaoAdjacente(Adjacente(E05, 3))

    E07.addEstacaoAdjacente(Adjacente(E05, 2.4))
    
    E08.addEstacaoAdjacente(Adjacente(E05, 30))
    E08.addEstacaoAdjacente(Adjacente(E04, 15.3))
    E08.addEstacaoAdjacente(Adjacente(E09, 9.6))
    E08.addEstacaoAdjacente(Adjacente(E12, 6.4))

    E09.addEstacaoAdjacente(Adjacente(E02, 10))
    E09.addEstacaoAdjacente(Adjacente(E03, 9.4))
    E09.addEstacaoAdjacente(Adjacente(E08, 9.6))
    E09.addEstacaoAdjacente(Adjacente(E11, 12.2))
    
    E10.addEstacaoAdjacente(Adjacente(E02, 3.5))

    E11.addEstacaoAdjacente(Adjacente(E09, 12.2))
    
    E12.addEstacaoAdjacente(Adjacente(E08, 6.4))
    
    E13.addEstacaoAdjacente(Adjacente(E04, 12.8))
    E13.addEstacaoAdjacente(Adjacente(E14, 5.1))
    
    '''mapa = Mapa()
    for i in range(len(mapa.E13.adjacentes)):
        print(mapa.E13.adjacentes[i].estacao.nome)'''
    
