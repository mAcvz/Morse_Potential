# GRAFICAZIONE AUTO VETTORI HAMILTONIANA 
import pandas as pd
import matplotlib.pyplot as plt
#
# PARAMETRI 
directory = "Graphic/"      # cartella salvataggio grafici
size = (9.7, 7)             # dimensioni immagine 
col = "r"                   # colore marker           
msize = 3                   # dimensione marker 
lbsize = 10                 # dimensione testo label
lgsize = 15                 # dimensione testo label
my_dpi = 300                # dpi immagine 
file = 'autovet.txt'        # nome file lettura
#
# CREAZIONE DATA FRAME DA FILE .txt
df = pd.read_csv(file, sep=",")
#
# GRAFICAZIONE COLONNE DATE FRAME -> AUTOVE VET
for ind, column in enumerate(df.columns[1:]):
    #
    name_figure = ("A_Vet_" + str(ind + 1) + ".png")
    #
    plt.figure(figsize=size)
    plt.plot(df.iloc[:,0], df.iloc[:,ind+1],'-',markersize = msize,color = col)
    plt.legend(["Auto vettore " + str(ind+1)], prop={"size":lgsize})
    plt.xlabel("x",fontsize = lbsize)
    plt.ylabel("y",fontsize = lbsize)
    #plt.hlines(L[1],L[2],data.V.iloc[-1])
    plt.savefig(directory + name_figure,dpi = my_dpi)
#
