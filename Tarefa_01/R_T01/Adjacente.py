class Adjacente:
    def __init__(self, estacao, distancia):
        self.estacao = estacao
        self.distancia = distancia
        self.distanciaAEstrela = self.estacao.distanciaObjetivo + self.distancia 