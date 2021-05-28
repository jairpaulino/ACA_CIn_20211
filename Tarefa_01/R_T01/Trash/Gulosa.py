from VetorOrdenado import VetorOrdenado

class Gulosa:

    def __init__(self, objetivo):
        self.objetivo = objetivo

        self.achou = False

    def buscar(self, atual):
        print('-----------------------------------')
        print('\nAtual: {}'.format(atual.getNome()))

        atual.setVisitado(True)

        if atual == self.objetivo:
            self.achou = True
        else:
            self.fronteira = VetorOrdenado(len(atual.getAdjacentes()))
            for a in atual.getAdjacentes():
                if not a.getCidade().isVisitado():
                    a.getCidade().setVisitado(True)
                    self.fronteira.inserir(a.getCidade())

            self.fronteira.mostrar()

            if self.fronteira.getPrimeiro() != None:
                Gulosa.buscar(self, self.fronteira.getPrimeiro())


from Mapa import Mapa
mapa = Mapa()
gulosa = Gulosa(mapa.curitiba)       
gulosa.buscar(mapa.portoUniao)