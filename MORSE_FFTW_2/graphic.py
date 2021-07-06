import pandas as pd
import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np
#
df = pd.read_csv('autovet_real.txt', sep=",")
print(df) #controllo per vedere se il dataframe è giusto p.s è giusto lo visto con i mei occhi
#
plt.figure(figsize=(9.7, 7))
plt.plot(df.iloc[:,0], df.iloc[:,1],'-',markersize=3,color="r")
plt.legend(["Auto vettore 1"],prop={"size":15})
plt.xlabel("x",fontsize=10)
plt.ylabel("y",fontsize=10)
#
plt.grid()
plt.show()