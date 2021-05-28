class Estacao:
    def __init__(self, nome, distanciaObjetivo):
        self.visitado = False
        self.distanciaObjetivo = distanciaObjetivo
        self.nome = nome    
        self.adjacentes = []
        
    def addEstacaoAdjacente(self, estacao):
        self.adjacentes.append(estacao)
    
'''c = Estacao("teste", 10)
c.nome
c.visitado
c.distanciaObjetivo
c.adjacentes'''
