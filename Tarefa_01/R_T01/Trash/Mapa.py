from Adjacente import Adjacente
from Cidade import Cidade

class Mapa:
    
    portoUniao = Cidade("Porto União", 203)
    pauloFrontin = Cidade("Paulo Frontin", 172)
    canoinhas = Cidade("Canoinhas", 141)
    irati = Cidade("Irati", 139)
    palmeira = Cidade("Palmeira", 59)
    campoLargo = Cidade("Campo Largo", 27)
    curitiba = Cidade("Curitiba", 0)
    balsaNova = Cidade("Balsa Nova", 41)
    araucaria = Cidade("Araucária", 23)
    saoJose = Cidade("São José dos Pinhais", 13)
    contenda = Cidade("Contenda", 39)
    mafra = Cidade("Mafra", 94)
    tijucas = Cidade("Tijucas do Sul", 56)
    lapa = Cidade("Lapa", 74)
    saoMateus = Cidade("São Mateus do Sul", 123)
    tresBarras = Cidade("Três Barras", 131)

    portoUniao.addCidadeAdjacente(Adjacente(pauloFrontin))  
    portoUniao.addCidadeAdjacente(Adjacente(canoinhas))
    portoUniao.addCidadeAdjacente(Adjacente(saoMateus))
       
    pauloFrontin.addCidadeAdjacente(Adjacente(portoUniao))
    pauloFrontin.addCidadeAdjacente(Adjacente(irati))
    
    canoinhas.addCidadeAdjacente(Adjacente(portoUniao))
    canoinhas.addCidadeAdjacente(Adjacente(tresBarras))
    canoinhas.addCidadeAdjacente(Adjacente(mafra))
    
    irati.addCidadeAdjacente(Adjacente(pauloFrontin))
    irati.addCidadeAdjacente(Adjacente(palmeira))
    irati.addCidadeAdjacente(Adjacente(saoMateus))
    
    palmeira.addCidadeAdjacente(Adjacente(irati))
    palmeira.addCidadeAdjacente(Adjacente(saoMateus))
    palmeira.addCidadeAdjacente(Adjacente(campoLargo))
    
    campoLargo.addCidadeAdjacente(Adjacente(palmeira))
    campoLargo.addCidadeAdjacente(Adjacente(balsaNova))
    campoLargo.addCidadeAdjacente(Adjacente(curitiba))
    
    curitiba.addCidadeAdjacente(Adjacente(campoLargo))
    curitiba.addCidadeAdjacente(Adjacente(balsaNova))
    curitiba.addCidadeAdjacente(Adjacente(araucaria))
    curitiba.addCidadeAdjacente(Adjacente(saoJose))
    
    balsaNova.addCidadeAdjacente(Adjacente(curitiba))
    balsaNova.addCidadeAdjacente(Adjacente(campoLargo))
    balsaNova.addCidadeAdjacente(Adjacente(contenda))
    
    araucaria.addCidadeAdjacente(Adjacente(curitiba))
    araucaria.addCidadeAdjacente(Adjacente(contenda))
    
    saoJose.addCidadeAdjacente(Adjacente(curitiba))
    saoJose.addCidadeAdjacente(Adjacente(tijucas))
    
    contenda.addCidadeAdjacente(Adjacente(balsaNova))
    contenda.addCidadeAdjacente(Adjacente(araucaria))
    contenda.addCidadeAdjacente(Adjacente(lapa))

    mafra.addCidadeAdjacente(Adjacente(tijucas))
    mafra.addCidadeAdjacente(Adjacente(lapa))
    mafra.addCidadeAdjacente(Adjacente(canoinhas))
    
    tijucas.addCidadeAdjacente(Adjacente(mafra))
    tijucas.addCidadeAdjacente(Adjacente(saoJose))

    lapa.addCidadeAdjacente(Adjacente(contenda))
    lapa.addCidadeAdjacente(Adjacente(saoMateus))
    lapa.addCidadeAdjacente(Adjacente(mafra))
    
    saoMateus.addCidadeAdjacente(Adjacente(palmeira))
    saoMateus.addCidadeAdjacente(Adjacente(irati))
    saoMateus.addCidadeAdjacente(Adjacente(lapa))
    saoMateus.addCidadeAdjacente(Adjacente(tresBarras))
    saoMateus.addCidadeAdjacente(Adjacente(portoUniao))
    
    tresBarras.addCidadeAdjacente(Adjacente(saoMateus))
    tresBarras.addCidadeAdjacente(Adjacente(canoinhas))


'''mapa.araucaria.nome
mapa.araucaria.visitado
mapa.araucaria.adjacentes
for i in range(len(mapa.portoUniao.adjacentes)):
  print(mapa.portoUniao.adjacentes[i].cidade.nome)'''
