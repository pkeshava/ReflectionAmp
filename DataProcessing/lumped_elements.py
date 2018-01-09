# Plotting impedance of measured inductance vs simulated inductance of lumped elements

import io                       # file and stream handling
import codecs                   # encoding for python... probably don't need
import string
import numpy as np              # Numpy provides a high-performance multidimensional array and basic tools to compute with and manipulate these arrays

import matplotlib as mpl
import matplotlib.pyplot as plt # matlab like plotting
import scipy
from scipy import linalg, optimize, io
from numpy import genfromtxt


my_data = genfromtxt('VNA_lumped_inductor.csv', delimiter=',',skip_header=1)
s11_24 = np.array(1+(my_data[1,2])ja)
mat_contents = scipy.io.loadmat('RL_coordinates.mat', squeeze_me = True)
#s11_24 = my_data[:,2:4]
#s11_40 = my_data[:,4:6]
#s11_245 = np.complex([])
#s11_245.imag = s11_24[:,1]

#zin_24 = 50*(1+s11_24)/(1-s11_24)