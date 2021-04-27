import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np

# permette di leggere tutte le colonne di una riga
# 
X = []
for line in open('Punti_valutazione.txt', 'r'):
  values = [float(s) for s in line.split()]
  X.append(values[0])
# first
Y_1 = []
for line in open('dati_autovet_n=0.txt', 'r'):
  values = [float(s) for s in line.split()]
  Y_1.append(values[0])
# second
Y_2 = []
for line in open('dati_autovet_n=1.txt', 'r'):
  values = [float(s) for s in line.split()]
  Y_2.append(values[0])
# third
Y_3 = []
for line in open('dati_autovet_n=2.txt', 'r'):
  values = [float(s) for s in line.split()]
  Y_3.append(values[0])
# fourth
Y_4 = []
for line in open('dati_autovet_n=3.txt', 'r'):
  values = [float(s) for s in line.split()]
  Y_4.append(values[0])

fig,axes = plt.subplots(2,2)
axes[0,0].plot(X,Y_1, 'r')
axes[0,0].set_xlabel('x')
axes[0,0].set_ylabel('y')
axes[0,0].set_title('autovet_1')

axes[0,1].plot(X,Y_2, 'r')
axes[0,1].set_xlabel('x')
axes[0,1].set_ylabel('y')
axes[0,1].set_title('autovet_2')

axes[1,0].plot(X,Y_3, 'r')
axes[1,0].set_xlabel('x')
axes[1,0].set_ylabel('y')
axes[1,0].set_title('autovet_3')

axes[1,1].plot(X,Y_4, 'r')
axes[1,1].set_xlabel('x')
axes[1,1].set_ylabel('y')
axes[1,1].set_title('autovet_4')

fig.tight_layout() 
plt.show()


